#ifndef CONNECTION_H
#define CONNECTION_H
#include <QDebug>
#include <QSqlDatabase>
#include <QSqlError>

static bool createConnection() {
  QSqlDatabase db = QSqlDatabase::addDatabase("QMYSQL");
  db.setUserName("odontouser");
  db.setHostName("192.168.195.80");
  db.setDatabaseName("odontofichadb");
  db.setPassword("3262daMC");

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
