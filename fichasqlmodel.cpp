#include "fichasqlmodel.h"

FichaSqlModel::FichaSqlModel(QObject *parent) : QSqlQueryModel(parent) {
  generateRoleNames();
}

FichaSqlModel::~FichaSqlModel() {}

QVariant FichaSqlModel::data(const QModelIndex &index, int role) const {
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

QHash<int, QByteArray> FichaSqlModel::roleNames() const { return m_roleNames; }

void FichaSqlModel::getFichas(int patient_id) {
  if (patient_id > 0) {
    QString query =
        QStringLiteral("SELECT * FROM ficha_clinica WHERE "
                       "patient_id = %1 ORDER BY fecha_creacion DESC")
            .arg(patient_id);
    this->setQuery(query);

  } else {
    qInfo() << "[ ERROR ] No se pudieron obtener fichas clinicas";
  }
}

bool FichaSqlModel::addFicha(QString contenido, int patient_id, int user_id) {

  if (contenido == "" || patient_id < 1 || user_id < 1) {
    qInfo() << "[ ERROR ] Los datos no pasaron la sanitizacion, abortando "
               "agregar ficha";
    return false;
  }

  qInfo() << "[ C++ ] Creando nueva ficha clinica";
  //  qInfo() << contenido << " " << patient_id << user_id;

  QSqlQuery query;
  query.prepare("INSERT INTO ficha_clinica (contenido, patient_id, user_id) "
                "VALUES (:contenido, :patient_id, :user_id)");
  query.bindValue(":contenido", contenido);
  query.bindValue(":patient_id", patient_id);
  query.bindValue(":user_id", user_id);
  if (!query.exec()) {
    qInfo()
        << "[ ERROR ] Ocurrio un error al crear la ficha, no se creo la ficha";
    qInfo() << query.lastError();
    return false;
  }

  qInfo() << "[ C++ ] La ficha se creo con exito!";
  this->getFichas(patient_id);
  return true;
}

void FichaSqlModel::generateRoleNames() {
  const char *COLUMN_NAMES[] = {"ficha_id",
                                "contenido",
                                "fecha_creacion",
                                "fecha_modificacion",
                                "patient_id",
                                "user_id",
                                NULL};
  m_roleNames.clear();

  int idx = 0;

  while (COLUMN_NAMES[idx]) {
    m_roleNames.insert(Qt::UserRole + idx + 1, COLUMN_NAMES[idx]);
    idx++;
  }
}
