#ifndef UTILITY_H
#define UTILITY_H

#include <QDebug>
#include <QImage>
#include <QObject>
#include <QPainter>
#include <QPrintDialog>
#include <QPrinter>
#include <QRectF>
#include <QSqlDatabase>
#include <QtQml>

class Utility : public QObject {
  Q_OBJECT
  QML_ELEMENT
  Q_PROPERTY(bool isDatabaseOpen READ isDatabaseOpen WRITE setIsDatabaseOpen
                 NOTIFY isDatabaseOpenChanged)
public:
  explicit Utility(QObject *parent = nullptr);

  Q_INVOKABLE bool isOpen();
  Q_INVOKABLE bool printDocument();

  bool isDatabaseOpen() const;
  void setIsDatabaseOpen(bool newIsDatabaseOpen);

private:
  bool m_isDatabaseOpen;

signals:
  void isDatabaseOpenChanged();
};

#endif // UTILITY_H
