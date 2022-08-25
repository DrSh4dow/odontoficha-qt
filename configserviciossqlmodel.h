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
#include <QtQml>

class ConfigServiciosSqlModel : public QSqlQueryModel {
  Q_OBJECT
  QML_ELEMENT

public:
  explicit ConfigServiciosSqlModel(QObject *parent = nullptr);

  Q_INVOKABLE QString get(int id, bool isName) const;
  Q_INVOKABLE bool addServicio(QString nombreServicio, QString precioServicio);
  Q_INVOKABLE bool deleteServicio(int id);

  QVariant data(const QModelIndex &index, int role) const;
  QHash<int, QByteArray> roleNames() const;

private:
  void generateRoleNames();
  void refresh();
  QHash<int, QByteArray> m_roleNames;
};

#endif // CONFIGSERVICIOSSQLMODEL_H
