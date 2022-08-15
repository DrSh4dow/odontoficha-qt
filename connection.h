#ifndef CONNECTION_H
#define CONNECTION_H
#include <QDebug>
#include <QDir>
#include <QFile>
#include <QSqlDatabase>
#include <QSqlError>
#include <QSqlQuery>
#include <QStandardPaths>

static bool createConnection() {
  // Se inicializa la base de datos creando primero el directorio
  // para luego copiar un archivo sqlite base a la ubicacion correspondiente
  // segun el sistema operativo

  QString path =
      QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
  if (path.isEmpty())
    qFatal("Cannot determine standard appdata storage location");
  QDir d{path};
  if (!d.mkpath(d.absolutePath()))
    qFatal("Some terrible error has happened when creating a new directory");

  path.append("/odontoficha.db");

  //  qDebug() << QFile::exists(path);
  if (!QFile::exists(path)) {
    QFile::copy(":/db/odontoficha.db", path);
    QFile::setPermissions(path,
                          QFileDevice::ReadOwner | QFileDevice::WriteOwner |
                              QFileDevice::ReadUser | QFileDevice::WriteUser |
                              QFileDevice::ReadGroup | QFileDevice::WriteGroup |
                              QFileDevice::ReadOther | QFileDevice::WriteOther);
    qInfo() << "base db copied successfully!";
  }

    qInfo() << "DB initialiced successfully";

    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName(path);

    if (!db.open()) {
      qWarning("Unable to open database");
      qInfo() << db.lastError();

      return false;
    }

  //  qInfo() << "Connected to DB";
  //  db.close();
  //  qInfo() << "Connection Closed";
  return true;
}

#endif // CONNECTION_H
