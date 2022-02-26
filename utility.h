#ifndef UTILITY_H
#define UTILITY_H

#include <QObject>
#include <QDebug>
#include <QtQml>
#include <QSqlDatabase>

class Utility : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    Q_PROPERTY(bool isDatabaseOpen READ isDatabaseOpen WRITE setIsDatabaseOpen NOTIFY isDatabaseOpenChanged)
public:
    explicit Utility(QObject *parent = nullptr);

    Q_INVOKABLE bool isOpen();

    bool isDatabaseOpen() const;
    void setIsDatabaseOpen(bool newIsDatabaseOpen);

private:
    bool m_isDatabaseOpen;

signals:
    void isDatabaseOpenChanged();

};

#endif // UTILITY_H
