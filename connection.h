#ifndef CONNECTION_H
#define CONNECTION_H
#include <QDebug>
#include <QSqlDatabase>
#include <QSqlError>

static bool createConnection() {
  QSqlDatabase db = QSqlDatabase::addDatabase("QMYSQL");
  db.setUserName("odontouser");
  db.setHostName("127.0.0.1");
  db.setDatabaseName("odontofichadb");
  db.setPassword("supersecurepassword");

  if (!db.open()) {
    qWarning("Unable to open database");
    qInfo() << db.lastError();

    return false;
  }

  //  qInfo() << "Connected to DB";
  //  db.close();
  //  qInfo() << "Connection Closed";
  return true;
};

#endif // CONNECTION_H
