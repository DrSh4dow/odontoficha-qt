#ifndef CONNECTION_H
#define CONNECTION_H
#include <QDebug>
#include <QSqlDatabase>
#include <QSqlError>

static bool createConnection() {
  QSqlDatabase db = QSqlDatabase::addDatabase("QMYSQL");
  db.setUserName("odontouser");
  db.setHostName("odontoficha-db-do-user-10883658-0.b.db.ondigitalocean.com");
  db.setPort(25060);
  db.setDatabaseName("odontofichadb");
  db.setPassword("yqTpb5wQXiR4cyBk");

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
