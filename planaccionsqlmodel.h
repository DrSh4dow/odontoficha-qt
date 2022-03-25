#ifndef PLANACCIONSQLMODEL_H
#define PLANACCIONSQLMODEL_H

#include <QDebug>
#include <QObject>
#include <QSqlDatabase>
#include <QSqlError>
#include <QSqlField>
#include <QSqlQuery>
#include <QSqlQueryModel>
#include <QSqlRecord>

class PlanAccionSqlModel : public QSqlQueryModel {
  Q_OBJECT
public:
  explicit PlanAccionSqlModel(QObject *parent = nullptr);

  QVariant data(const QModelIndex &index, int role) const;
  QHash<int, QByteArray> roleNames() const;

  Q_INVOKABLE void getPlanAccion(int patient_id);

private:
  void generateRoleNames();
  QHash<int, QByteArray> m_roleNames;
};

#endif // PLANACCIONSQLMODEL_H
