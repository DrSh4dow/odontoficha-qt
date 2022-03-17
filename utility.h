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

  bool isDatabaseOpen() const;
  void setIsDatabaseOpen(bool newIsDatabaseOpen);

private:
  bool m_isDatabaseOpen;
  bool savePlanDeAccion(QStringList dataPrestacion, QStringList dataPieza,
                        QStringList dataPrecio, int patientId);
  float calculateCenter(int total, int size);

signals:
  void isDatabaseOpenChanged();
};

#endif // UTILITY_H
