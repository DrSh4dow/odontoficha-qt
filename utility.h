#ifndef UTILITY_H
#define UTILITY_H

#include <QColor>
#include <QDate>
#include <QDebug>
#include <QFont>
#include <QImage>
#include <QObject>
#include <QPainter>
#include <QPen>
#include <QPrintDialog>
#include <QPrinter>
#include <QRectF>
#include <QSqlDatabase>
#include <QSqlError>
#include <QSqlQuery>
#include <QtQml>

class Utility : public QObject {
  Q_OBJECT
  QML_ELEMENT
  Q_PROPERTY(bool isDatabaseOpen READ isDatabaseOpen WRITE setIsDatabaseOpen
                 NOTIFY isDatabaseOpenChanged)
public:
  explicit Utility(QObject *parent = nullptr);

  Q_INVOKABLE bool isOpen();
  Q_INVOKABLE bool printDocument(QStringList dataPrestacion,
                                 QStringList dataPieza, QStringList dataPrecio,
                                 QString nombre = "", QString rut = "",
                                 QString direccion = "", int patientId = 0);
  Q_INVOKABLE bool printReceta(QString contenido = "", QString nombre = "",
                               QString rut = "", QString direccion = "",
                               QString edad = "", int patientId = 0);
  Q_INVOKABLE bool savePlanDeAccion(QStringList dataPrestacion,
                                    QStringList dataPieza,
                                    QStringList dataPrecio, int patientId);
  Q_INVOKABLE bool printPlan(int planId, int pacienteId);

  Q_INVOKABLE bool toggleCompletar(int planId, bool isComplete);

  bool isDatabaseOpen() const;
  void setIsDatabaseOpen(bool newIsDatabaseOpen);

private:
  bool m_isDatabaseOpen;
  int saveReceta(QString contenido, int patientId, int userId = 2);
  float calculateCenter(int total, int size);

signals:
  void isDatabaseOpenChanged();
};

#endif // UTILITY_H
