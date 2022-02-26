#include "utility.h"

Utility::Utility(QObject *parent)
    : QObject{parent}
{

//    qInfo() << "[ C++ ] Utility instantiated (Constructor)";
    this->isOpen();
}

bool Utility::isOpen()
{
    QSqlDatabase db = QSqlDatabase::database();
    bool result = db.isOpen();

    this->setIsDatabaseOpen(result);

//    qInfo() << "Is database open? :" << result;
    return result;
}

bool Utility::isDatabaseOpen() const
{
    return m_isDatabaseOpen;
}

void Utility::setIsDatabaseOpen(bool newIsDatabaseOpen)
{
    m_isDatabaseOpen = newIsDatabaseOpen;
}
