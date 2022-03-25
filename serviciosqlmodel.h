#ifndef SERVICIOSQLMODEL_H
#define SERVICIOSQLMODEL_H

#include <QDebug>
#include <QObject>
#include <QSqlDatabase>
#include <QSqlError>
#include <QSqlField>
#include <QSqlQuery>
#include <QSqlQueryModel>
#include <QSqlRecord>

class ServicioSqlModel : public QSqlQueryModel {
  Q_OBJECT
  Q_PROPERTY(int plan_id READ plan_id WRITE setPlan_id NOTIFY plan_idChanged)
public:
  explicit ServicioSqlModel(QObject *parent = nullptr);

  QVariant data(const QModelIndex &index, int role) const;
  QHash<int, QByteArray> roleNames() const;

  // GETTERS & SETTERS
  int plan_id() const;
  void setPlan_id(int newPlan_id);

private:
  int m_plan_id = 0;

  void generateRoleNames();
  QHash<int, QByteArray> m_roleNames;

signals:
  void plan_idChanged();
};

#endif // SERVICIOSQLMODEL_H
