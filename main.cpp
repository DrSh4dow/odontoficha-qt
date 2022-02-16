#include "connection.h"
#include "patient.h"
#include "patientsqlmodel.h"
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>

int main(int argc, char *argv[]) {
  QGuiApplication app(argc, argv);

  /**************************
   *
   * REGISTERING CUSTOM LOGIC
   *
   **************************/

  bool isConnected = createConnection();
  qInfo() << "Connected to DB: " << isConnected;
  qmlRegisterType<PatientSqlModel>("cl.odontoficha.sql", 1, 0, "PatientModel");
  qmlRegisterType<Patient>("cl.odontoficha.patient", 1, 0, "Patient");

  // Finish custom logic

  QQmlApplicationEngine engine;
  const QUrl url(u"qrc:/odontoficha/main.qml"_qs);
  QObject::connect(
      &engine, &QQmlApplicationEngine::objectCreated, &app,
      [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
          QCoreApplication::exit(-1);
      },
      Qt::QueuedConnection);
  engine.load(url);

  return app.exec();
}
