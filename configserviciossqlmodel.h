#ifndef CONFIGSERVICIOSSQLMODEL_H
#define CONFIGSERVICIOSSQLMODEL_H

#include <QDebug>
#include <QObject>
#include <QSqlDatabase>
#include <QSqlError>
#include <QSqlField>
#include <QSqlQuery>
#include <QSqlQueryModel>
#include <QSqlRecord>

class ConfigServiciosSqlModel : public QSqlQueryModel {
  Q_OBJECT
public:
  explicit ConfigServiciosSqlModel(QObject *parent = nullptr);

  Q_INVOKABLE QString get(int id, bool isName) const;

  QVariant data(const QModelIndex &index, int role) const;
  QHash<int, QByteArray> roleNames() const;

private:
  void generateRoleNames();
  void refresh();
  QHash<int, QByteArray> m_roleNames;
};

#endif // CONFIGSERVICIOSSQLMODEL_H
