#include "utility.h"

Utility::Utility(QObject *parent) : QObject{parent} {

  //    qInfo() << "[ C++ ] Utility instantiated (Constructor)";
  this->isOpen();
}

bool Utility::isOpen() {
  QSqlDatabase db = QSqlDatabase::database();
  bool result = db.isOpen();

  this->setIsDatabaseOpen(result);

  //    qInfo() << "Is database open? :" << result;
  return result;
}

bool Utility::printDocument() {
  qInfo() << "[ C++ ] printDocument Called";

  QPrinter printer;
  QImage headerImage(":/images/presupuestoheader.png");
  QPrintDialog dialog(&printer);
  QPainter painter;
  dialog.setWindowTitle(tr("Print Document"));
  if (dialog.exec() == QDialog::Accepted) {
    qInfo() << "Painting process begin";

    int pageWidth = printer.pageRect(QPrinter::DevicePixel).width();
    int pageHeight = printer.pageRect(QPrinter::DevicePixel).height();
    QRectF target(10.0, 20.0, 80.0, 80.0);

    qInfo() << "page width: " << pageWidth;
    qInfo() << "page height: " << pageHeight;

    painter.begin(&printer);
    painter.setPen(Qt::blue);
    painter.setFont(QFont("Roboto", 30));

    //    painter.drawText(0, 0, "Hello");

    painter.drawRect((pageWidth / 2) - 60, (pageHeight / 2) - 60, 120, 120);
    painter.drawImage(target, headerImage);
    painter.end();

    qInfo() << "Painting process end";
    return true;
  }
  qInfo() << " [ C++ ] Printing failed";

  return false;
}

bool Utility::isDatabaseOpen() const { return m_isDatabaseOpen; }

void Utility::setIsDatabaseOpen(bool newIsDatabaseOpen) {
  m_isDatabaseOpen = newIsDatabaseOpen;
}
