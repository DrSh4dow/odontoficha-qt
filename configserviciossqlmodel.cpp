#include "configserviciossqlmodel.h"

ConfigServiciosSqlModel::ConfigServiciosSqlModel(QObject *parent)
    : QSqlQueryModel{parent} {
  this->setQuery("SELECT * FROM servicio_config ORDER BY nombre ASC");
  generateRoleNames();
}

QString ConfigServiciosSqlModel::get(int id, bool isName) const {

  QString data;
  QSqlQuery query;
  if (isName) {
    query.prepare("SELECT nombre FROM servicio_config WHERE servicio_config_id "
                  "= :servicio_config_id ");
  } else {
    query.prepare("SELECT precio FROM servicio_config WHERE servicio_config_id "
                  "= :servicio_config_id ");
  }

  query.bindValue(":servicio_config_id", id);

  if (!query.exec()) {

    qInfo() << "[ ERROR ] Fallo obtener los datos del paciente";
    qInfo() << query.lastError();
    return "Error";
  }
  while (query.next()) {
    data.append(query.value(0).toString());
  }

  return data;
}
QVariant ConfigServiciosSqlModel::data(const QModelIndex &index,
                                       int role) const {
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

QHash<int, QByteArray> ConfigServiciosSqlModel::roleNames() const {
  return m_roleNames;
}

void ConfigServiciosSqlModel::generateRoleNames() {
  const char *COLUMN_NAMES[] = {"servicio_config_id", "nombre", "precio", NULL};
  m_roleNames.clear();

  int idx = 0;

  while (COLUMN_NAMES[idx]) {
    m_roleNames.insert(Qt::UserRole + idx + 1, COLUMN_NAMES[idx]);
    idx++;
  }
}

void ConfigServiciosSqlModel::refresh() {
  this->setQuery("SELECT * FROM servicio_config ORDER BY nombre ASC");
}
