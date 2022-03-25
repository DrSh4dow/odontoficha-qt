#include "serviciosqlmodel.h"

ServicioSqlModel::ServicioSqlModel(QObject *parent) : QSqlQueryModel(parent) {
  generateRoleNames();
}

QVariant ServicioSqlModel::data(const QModelIndex &index, int role) const {
  QVariant value;
  if (role < Qt::UserRole) {
    value = QSqlQueryModel::data(index, role);
  } else {
    int columnIdx = role - Qt::UserRole - 1;
    QModelIndex modelIndex = this->index(index.row(), columnIdx);
    value = QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
  }

  //  qInfo() << "ROLE: " << role;
  //  qInfo() << "INDEX: " << index;
  //  qInfo() << "VARIANT: " << value;

  return value;
}

QHash<int, QByteArray> ServicioSqlModel::roleNames() const {
  return m_roleNames;
}

int ServicioSqlModel::plan_id() const { return m_plan_id; }

void ServicioSqlModel::setPlan_id(int newPlan_id) {
  m_plan_id = newPlan_id;
  QString query = QStringLiteral("SELECT servicio_id,prestacion,precio,pieza "
                                 "FROM servicio WHERE plan_id = %1 "
                                 "ORDER BY fecha_creacion DESC")
                      .arg(newPlan_id);
  this->setQuery(query);
}

void ServicioSqlModel::generateRoleNames() {
  const char *COLUMN_NAMES[] = {"servicio_id", "prestacion", "precio", "pieza",
                                NULL};
  m_roleNames.clear();

  int idx = 0;

  while (COLUMN_NAMES[idx]) {
    //    qInfo() << COLUMN_NAMES[idx];
    m_roleNames.insert(Qt::UserRole + idx + 1, COLUMN_NAMES[idx]);
    idx++;
  }

  //  qInfo() << m_roleNames;
}
