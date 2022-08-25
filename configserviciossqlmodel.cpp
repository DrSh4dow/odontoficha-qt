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

    qInfo() << "[ ERROR ] Fallo obtener los datos del servicio";
    qInfo() << query.lastError();
    return "Error";
  }
  while (query.next()) {
    data.append(query.value(0).toString());
  }

  return data;
}

bool ConfigServiciosSqlModel::addServicio(QString nombreServicio,
                                          QString precioServicio) {
  if (nombreServicio == "" || precioServicio == "")
    return 0;

  QSqlQuery query;
  query.prepare("INSERT INTO servicio_config (nombre,precio) VALUES ( "
                ":nombre_servicio , :precio_servicio )");
  query.bindValue(":nombre_servicio", nombreServicio);
  query.bindValue(":precio_servicio", precioServicio);

  if (!query.exec()) {
    qInfo() << "[ ERROR ] Fallo el agregar servicio function addServicio";
    qInfo() << query.lastError();
    return 0;
  }

  this->refresh();

  return 1;
}

bool ConfigServiciosSqlModel::deleteServicio(int id) {

  qInfo() << "[ C++ ] Borrando servicio con id: " << id;

  QSqlQuery query;
  query.prepare("DELETE FROM servicio_config WHERE servicio_config_id = "
                ":servicio_config_id");
  query.bindValue(":servicio_config_id", id);

  if (!query.exec()) {
    qInfo() << "[ ERROR ] Fallo en la funcion deleteServicio()";
    qInfo() << query.lastError();
    return 0;
  }

  this->refresh();

  qInfo() << "[ C++ ] Servicio borrado con exito!";

  return 1;
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
  qInfo() << "[ C++ ] query Refreshed";
}
