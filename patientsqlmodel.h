#ifndef PATIENTSQLMODEL_H
#define PATIENTSQLMODEL_H

#include <QDebug>
#include <QObject>
#include <QSqlDatabase>
#include <QSqlField>
#include <QSqlQueryModel>
#include <QSqlRecord>

class PatientSqlModel : public QSqlQueryModel {
  Q_OBJECT
public:
  explicit PatientSqlModel(QObject *parent = nullptr);
  ~PatientSqlModel();

  QVariant data(const QModelIndex &index, int role) const;

  QHash<int, QByteArray> roleNames() const;

  Q_INVOKABLE void refresh();

private:
  void generateRoleNames();
  QHash<int, QByteArray> m_roleNames;

signals:
};

#endif // PATIENTSQLMODEL_H
