#include "customfilterproxymodel.h"

CustomFilterProxyModel::CustomFilterProxyModel(QObject *parent)
    : QSortFilterProxyModel(parent) {}

CustomFilterProxyModel::~CustomFilterProxyModel() {
  //  qInfo() << "Destructor of customfilterproxymodel called";
}

void CustomFilterProxyModel::customFilter(QString keywords) {

  keywords.replace(QString("."), QString(""));
  keywords.replace(QString("-"), QString(""));
  QString filter = ".*";
  filter.append(keywords);
  filter.append(".*");
  //  qInfo() << "Custom filter Called With:" << filter;
  this->setFilterRegularExpression(
      QRegularExpression(filter, QRegularExpression::CaseInsensitiveOption));
}

bool CustomFilterProxyModel::filterAcceptsRow(
    int source_row, const QModelIndex &source_parent) const {

  QModelIndex index1 = sourceModel()->index(source_row, 1, source_parent);
  QModelIndex index3 = sourceModel()->index(source_row, 3, source_parent);
  QModelIndex index4 = sourceModel()->index(source_row, 4, source_parent);
  //  qInfo() << sourceModel()->data(index1).toString();
  //  qInfo() << sourceModel()->data(index3).toString();
  //  qInfo() << sourceModel()->data(index4).toString();

  return sourceModel()->data(index1).toString().contains(
             filterRegularExpression()) ||
         sourceModel()->data(index3).toString().contains(
             filterRegularExpression()) ||
         sourceModel()->data(index4).toString().contains(
             filterRegularExpression());
}
