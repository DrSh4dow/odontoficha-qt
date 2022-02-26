#include "connection.h"
#include "fichasqlmodel.h"
#include "patient.h"
#include "patientsqlmodel.h"
#include "utility.h"
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include <QIcon>
#include <QSortFilterProxyModel>

int main(int argc, char *argv[]) {
  QGuiApplication app(argc, argv);

  /**************************
   *
   * REGISTERING CUSTOM LOGIC
   *
   **************************/

  app.setWindowIcon(QIcon(":/icons/tooth.ico"));

  bool isConnected = createConnection();
  qInfo() << "Connected to DB: " << isConnected;

  // Object Instantiation
  PatientSqlModel *patientModelUnfiltered = new PatientSqlModel(&app);
  QSortFilterProxyModel *proxyPatientModel = new QSortFilterProxyModel(&app);
  proxyPatientModel->setSourceModel(patientModelUnfiltered);

  Utility *utilityObject = new Utility(&app);




  //Qml registration
  qmlRegisterType<Patient>("cl.odontoficha.patient", 1, 0, "Patient");
  qmlRegisterType<FichaSqlModel>("cl.odontoficha.fichasql", 1, 0, "FichaModel");




  QQmlApplicationEngine engine;

  //Object Registration
  engine.rootContext()->setContextProperty("patientProxyModel", proxyPatientModel);
  engine.rootContext()->setContextProperty("patientSourceModel", patientModelUnfiltered);
  engine.rootContext()->setContextProperty("utilityObject", utilityObject);

  // Finish custom logic

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
