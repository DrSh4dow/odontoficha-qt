#ifndef CUSTOMFILTERPROXYMODEL_H
#define CUSTOMFILTERPROXYMODEL_H

#include <QDebug>
#include <QRegularExpression>
#include <QSortFilterProxyModel>

class CustomFilterProxyModel : public QSortFilterProxyModel {
  Q_OBJECT
public:
  explicit CustomFilterProxyModel(QObject *parent = nullptr);
  ~CustomFilterProxyModel();

  Q_INVOKABLE void customFilter(QString keywords);

signals:

    // QSortFilterProxyModel interface
protected:
    bool filterAcceptsRow(int source_row, const QModelIndex &source_parent) const;
};

#endif // CUSTOMFILTERPROXYMODEL_H
