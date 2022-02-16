#include "patientsqlmodel.h"

PatientSqlModel::PatientSqlModel(QObject *parent) : QSqlQueryModel(parent) {
  QSqlDatabase db = QSqlDatabase::database();
  QSqlQueryModel::setQuery("SELECT * FROM patient", db);
  generateRoleNames();
}

PatientSqlModel::~PatientSqlModel() {
  QSqlDatabase db = QSqlDatabase::database();

  db.close();
  qInfo() << "Database closed";
}

QVariant PatientSqlModel::data(const QModelIndex &index, int role) const {
  QVariant value;
  if (role < Qt::UserRole) {
    value = QSqlQueryModel::data(index, role);
  } else {
    int columnIdx = role - Qt::UserRole - 1;
    QModelIndex modelIndex = this->index(index.row(), columnIdx);
    value = QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
  }

  return value;
}

QHash<int, QByteArray> PatientSqlModel::roleNames() const {
  return m_roleNames;
}

void PatientSqlModel::generateRoleNames() {
  m_roleNames.clear();
  for (int i = 0; i < record().count(); i++) {
    m_roleNames.insert(Qt::UserRole + i + 1, record().fieldName(i).toUtf8());
    //    qInfo() << record().fieldName(i).toUtf8();
  }
}
