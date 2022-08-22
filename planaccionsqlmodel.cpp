#include "planaccionsqlmodel.h"

PlanAccionSqlModel::PlanAccionSqlModel(QObject *parent)
    : QSqlQueryModel(parent) {
  generateRoleNames();
}

QVariant PlanAccionSqlModel::data(const QModelIndex &index, int role) const {
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

QHash<int, QByteArray> PlanAccionSqlModel::roleNames() const {
  return m_roleNames;
}

void PlanAccionSqlModel::getPlanAccion(int patient_id) {

  if (patient_id > 0) {
    QString query =
        QStringLiteral(
            "SELECT plan_id,fecha_creacion,completado FROM plan_accion WHERE patient_id "
            "= %1 ORDER BY fecha_creacion DESC")
            .arg(patient_id);
    this->setQuery(query);

  } else {
    qInfo() << "[ ERROR ] No hay paciente seleccionado";
  }
}

void PlanAccionSqlModel::generateRoleNames() {
  const char *COLUMN_NAMES[] = {"plan_id", "fecha_creacion","completado", NULL};
  m_roleNames.clear();

  int idx = 0;

  while (COLUMN_NAMES[idx]) {
    m_roleNames.insert(Qt::UserRole + idx + 1, COLUMN_NAMES[idx]);
    idx++;
  }
}
