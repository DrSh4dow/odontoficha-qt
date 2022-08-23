#include "configserviciossqlmodel.h"
#include "connection.h"
#include "customfilterproxymodel.h"
#include "fichasqlmodel.h"
#include "patient.h"
#include "patientsqlmodel.h"
#include "planaccionsqlmodel.h"
#include "serviciosqlmodel.h"
#include "utility.h"
#include <QApplication>
#include <QGuiApplication>
#include <QIcon>
#include <QQmlApplicationEngine>
#include <QtQml>

int main(int argc, char *argv[]) {
  QApplication app(argc, argv);
  //  QWebEngineProfile::defaultProfile()->setPersistentCookiesPolicy(QWebEngineProfile::ForcePersistentCookies);

  /**************************
   *
   * REGISTERING CUSTOM LOGIC
   *
   **************************/

  app.setWindowIcon(QIcon(":/icons/resources/tooth.ico"));
  app.setApplicationName("Odontoficha");
  app.setOrganizationDomain("odontoficha.cl");

  bool isConnected = createConnection();
  qInfo() << "Connected to DB: " << isConnected;

  // Object Instantiation
  PatientSqlModel *patientModelUnfiltered = new PatientSqlModel(&app);
  CustomFilterProxyModel *proxyPatientModel = new CustomFilterProxyModel(&app);
  proxyPatientModel->setSourceModel(patientModelUnfiltered);
  proxyPatientModel->sort(10, Qt::DescendingOrder);
  proxyPatientModel->setFilterKeyColumn(1);

  Utility *utilityObject = new Utility(&app);

  // Qml registration
  qmlRegisterType<Patient>("cl.odontoficha.patient", 1, 0, "Patient");
  qmlRegisterType<FichaSqlModel>("cl.odontoficha.fichasql", 1, 0, "FichaModel");
  qmlRegisterType<ConfigServiciosSqlModel>("cl.odontoficha.configserviciossql",
                                           1, 0, "ConfigServiciosModel");
  qmlRegisterType<PlanAccionSqlModel>("cl.odontoficha.planaccionsql", 1, 0,
                                      "PlanAccionModel");
  qmlRegisterType<ServicioSqlModel>("cl.odontoficha.serviciosql", 1, 0,
                                    "ServicioModel");
  //  qmlRegisterType<>()

  QQmlApplicationEngine engine;

  // Object Registration
  engine.rootContext()->setContextProperty("patientProxyModel",
                                           proxyPatientModel);
  engine.rootContext()->setContextProperty("patientSourceModel",
                                           patientModelUnfiltered);
  engine.rootContext()->setContextProperty("utilityObject", utilityObject);

  // Finish custom logic

  const QUrl url(u"qrc:/odontoficha/qml/main.qml"_qs);
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
