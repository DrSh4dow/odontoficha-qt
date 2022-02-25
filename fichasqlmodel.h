#ifndef FICHASQLMODEL_H
#define FICHASQLMODEL_H

#include <QDebug>
#include <QObject>
#include <QSqlDatabase>
#include <QSqlError>
#include <QSqlField>
#include <QSqlQuery>
#include <QSqlQueryModel>
#include <QSqlRecord>

class FichaSqlModel : public QSqlQueryModel {
  Q_OBJECT

public:
  explicit FichaSqlModel(QObject *parent = nullptr);
  ~FichaSqlModel();

  QVariant data(const QModelIndex &index, int role) const;

  QHash<int, QByteArray> roleNames() const;

  Q_INVOKABLE void getFichas(int patient_id);
  Q_INVOKABLE bool addFicha(QString contenido, int patient_id, int user_id);

private:
  void generateRoleNames();
  QHash<int, QByteArray> m_roleNames;
};

#endif // FICHASQLMODEL_H
