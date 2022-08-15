#include "utility.h"

Utility::Utility(QObject *parent) : QObject{parent} {

  //    qInfo() << "[ C++ ] Utility instantiated (Constructor)";
  this->isOpen();
}

bool Utility::isOpen() {
  QSqlDatabase db = QSqlDatabase::database();
  bool result = false;

  if (db.isOpen()) {
    result = true;
  } else {
    qInfo() << "[ C++ ] DB is disconnected, attempting to reconect...";
    if (!db.open()) {
      qWarning("Unable to open database");
      qInfo() << db.lastError();

      result = false;
    } else {
      result = true;
    }
  }

  this->setIsDatabaseOpen(result);

  //    qInfo() << "Is database open? :" << result;
  return result;
}

bool Utility::printDocument(QStringList dataPrestacion, QStringList dataPieza,
                            QStringList dataPrecio, QString nombre, QString rut,
                            QString direccion, int patientId) {
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

    // Image Container
    QRectF target(calculateCenter(pageWidth, 160), pageHeight * 0.05, 160.0,
                  160.0);

    qInfo() << "page width: " << pageWidth;
    qInfo() << "page height: " << pageHeight;

    painter.begin(&printer);

    // Lines Settings
    painter.setPen(QPen(QColor(200, 226, 228), 2));

    // Lines left
    painter.drawLine(0, pageHeight / 20 + 56, calculateCenter(pageWidth, 240),
                     pageHeight / 20 + 56);
    painter.drawLine(0, pageHeight / 20 + 60, calculateCenter(pageWidth, 240),
                     pageHeight / 20 + 60);
    painter.drawLine(0, pageHeight / 20 + 100, calculateCenter(pageWidth, 240),
                     pageHeight / 20 + 100);
    painter.drawLine(0, pageHeight / 20 + 104, calculateCenter(pageWidth, 240),
                     pageHeight / 20 + 104);

    // Lines Right
    painter.drawLine(pageWidth, pageHeight / 20 + 56, (pageWidth / 2) + 120,
                     pageHeight / 20 + 56);
    painter.drawLine(pageWidth, pageHeight / 20 + 60, (pageWidth / 2) + 120,
                     pageHeight / 20 + 60);
    painter.drawLine(pageWidth, pageHeight / 20 + 100, (pageWidth / 2) + 120,
                     pageHeight / 20 + 100);
    painter.drawLine(pageWidth, pageHeight / 20 + 104, (pageWidth / 2) + 120,
                     pageHeight / 20 + 104);

    // Lines Bottom center
    painter.drawLine(pageWidth / 2 - 80, (pageHeight * 0.9), pageWidth / 2 + 80,
                     (pageHeight * 0.9));
    painter.drawLine(pageWidth / 2 - 80, (pageHeight * 0.9) + 4,
                     pageWidth / 2 + 80, (pageHeight * 0.9) + 4);

    // Center image
    painter.drawImage(target, headerImage);

    //  Rectangles settings

    painter.setPen(Qt::transparent);
    painter.setBrush(QColor(234, 234, 234));

    // Rectangles drawing
    QRectF headerRectangle(0, pageHeight * 0.3, pageWidth, pageHeight * 0.10);
    QRectF leftBodyRectangle(0, pageHeight * 0.41, pageWidth * 0.3,
                             pageHeight * 0.4);
    QRectF rightBodyRectangle(pageWidth * 0.31, pageHeight * 0.41,
                              pageWidth * 0.69, pageHeight * 0.4);
    painter.fillRect(headerRectangle, painter.brush());
    painter.fillRect(leftBodyRectangle, painter.brush());
    painter.fillRect(rightBodyRectangle, painter.brush());

    // Text Settings
    painter.setPen(Qt::black);
    painter.setFont(QFont("Arial", 8));

    float lineLeftCenter = ((pageWidth / 2) - 120) / 2;
    // Header Text
    painter.drawText(lineLeftCenter - lineLeftCenter / 2,
                     pageHeight * 0.05 + 85, "PRESUPUESTO DENTAL");
    painter.drawText((pageWidth / 2 + 120) +
                         (lineLeftCenter - lineLeftCenter / 2),
                     pageHeight * 0.05 + 85, "CLINICA MONTEVIDEO");

    // Bold Text

    QRectF prestacionRectangle(pageWidth * 0.31, pageHeight * 0.41,
                               pageWidth * 0.345, pageHeight * 0.4);
    QRectF precioRectangle(pageWidth * 0.655, pageHeight * 0.41,
                           pageWidth * 0.345, pageHeight * 0.39);

    painter.setFont(QFont("Roboto", 10, 700));
    painter.drawText(16, pageHeight * 0.3 + 24, "Plan de tratamiento para:");
    painter.drawText(leftBodyRectangle.adjusted(0, 8, 0, 0), Qt::AlignHCenter,
                     "Pieza");
    painter.drawText(prestacionRectangle.adjusted(0, 8, 0, 0), Qt::AlignHCenter,
                     "Prestación");
    painter.drawText(precioRectangle.adjusted(8, 8, 0, 0), Qt::AlignHCenter,
                     "Precio");

    painter.setFont(QFont("Roboto", 8));
    //    painter.drawText(QRectF(0, 24, pageWidth - 40, 160), Qt::AlignRight,
    //                     "FOLIO: N0001");

    // Light Static Header Text
    QRectF centeredHeaderRect(0, pageHeight * 0.21, pageWidth, 160);
    painter.drawText(centeredHeaderRect, Qt::AlignHCenter,
                     "DRA. MARÍA BELÉN CHACÓN CHIODI");
    painter.drawText(centeredHeaderRect.adjusted(0, 16, 0, 0), Qt::AlignHCenter,
                     "21.373.385-0");
    painter.drawText(centeredHeaderRect.adjusted(0, 32, 0, 0), Qt::AlignHCenter,
                     "DRA.CHACONCHIODI@GMAIL.COM");

    // Light Static Bottom Text
    QRectF centeredBottomRect(0, pageHeight * 0.9, pageWidth, 80);

    painter.drawText(centeredBottomRect.adjusted(0, 16, 0, 0), Qt::AlignHCenter,
                     "+56 9 5789 8332");

    painter.drawText(centeredBottomRect.adjusted(0, 32, 0, 0), Qt::AlignHCenter,
                     "AV. BALMACEDA 4194, RENCA");

    // Dynamic shit
    // Informacion de paciente

    QString formatedNombre = "Paciente: " + nombre;
    QString formatedRut = "Rut: " + rut;
    QString formatedFecha =
        "Fecha: " + QDate::currentDate().toString("dd/MM/yyyy");
    QString formatedDireccion = "Dirección: " + direccion;

    QRectF pacienteRightRectangle(pageWidth / 2 + 16, pageHeight * 0.3,
                                  pageWidth / 2 - 16, pageHeight * 0.10);
    QRectF pacienteLeftRectangle(40, pageHeight * 0.3, pageWidth / 2 - 16,
                                 pageHeight * 0.10);

    painter.drawText(pacienteLeftRectangle.adjusted(0, 40, 0, 0),
                     Qt::AlignLeading, formatedNombre);
    painter.drawText(pacienteLeftRectangle.adjusted(0, 72, 0, 0),
                     Qt::AlignLeading, formatedRut);

    painter.drawText(pacienteRightRectangle.adjusted(0, 40, 0, 0),
                     Qt::AlignLeading, formatedFecha);
    painter.drawText(pacienteRightRectangle.adjusted(0, 72, 0, 0),
                     Qt::AlignLeading, formatedDireccion);

    int precioTotal = 0;

    for (int i = 0; i < dataPrestacion.size(); ++i) {
      painter.drawText(leftBodyRectangle.adjusted(0, 40 + i * 24, 0, 0),
                       Qt::AlignHCenter, dataPieza.at(i));
      painter.drawText(prestacionRectangle.adjusted(0, 40 + i * 24, 0, 0),
                       Qt::AlignHCenter, dataPrestacion.at(i));
      painter.drawText(precioRectangle.adjusted(8, 40 + i * 24, 0, 0),
                       Qt::AlignHCenter, dataPrecio.at(i));

      QString line = dataPrecio.at(i);
      line.remove(".");
      int lineValue = line.toInt();

      precioTotal += lineValue;
    }

    QString totalValueString = QString::number(precioTotal);
    QString formatedTotalValue = totalValueString;

    if (totalValueString.count() > 3 && totalValueString.count() < 7) {
      QString first = totalValueString.left(totalValueString.count() - 3);
      QString second = totalValueString.mid(totalValueString.count() - 3);

      //      qInfo() << first;
      //      qInfo() << second;

      formatedTotalValue = QString("%1.%2").arg(first).arg(second);

    } else if (totalValueString.count() > 6) {

      QString first = totalValueString.left(totalValueString.count() - 6);
      QString second =
          totalValueString.mid(totalValueString.count() - 6).left(3);
      QString third = totalValueString.mid(totalValueString.count() - 3);

      formatedTotalValue =
          QString("%1.%2.%3").arg(first).arg(second).arg(third);
    }

    painter.drawText(precioRectangle, Qt::AlignHCenter | Qt::AlignBottom,
                     QString("Total: $" + formatedTotalValue));

    // End the painting
    painter.end();
    qInfo() << "[ C++ ] Painting process end";

    return true;
  }
  qInfo() << " [ C++ ] Printing failed";

  return false;
}

bool Utility::printReceta(QString contenido, QString nombre, QString rut,
                          QString direccion, QString edad, int patientId) {
  qInfo() << "[ C++ ] printReceta Called";

  QPrinter printer;
  QImage recetaImage(":/images/resources/receta.png");
  QPrintDialog dialog(&printer);
  QPainter painter;
  dialog.setWindowTitle(tr("Imprimir Receta"));

  if (dialog.exec() == QDialog::Accepted) {

    QString numeroFolio = "64102";
    // Se inicia el almacenamiento de receta y obtencion de numero de folio
    if (patientId == 0) {
      qInfo()
          << "[ C++ ] No hay paciente seleccionado, saltando almacenamiento...";
    } else {
      int folioNumber = saveReceta(contenido, patientId);
      if (folioNumber == 0) {
        qInfo()
            << "[ C++ ] No se pudo almacenar la receta, cancelando impresion";
        return false;
      }

      numeroFolio = QString::number(folioNumber);
    }

    qInfo() << "Painting process begin";

    int pageWidth = printer.pageRect(QPrinter::DevicePixel).width();
    int pageHeight = printer.pageRect(QPrinter::DevicePixel).height();

    // Image Container
    QRectF target(0, 0, pageWidth, pageHeight);
    QRectF contenidoRectangle(pageWidth * 0.2, pageHeight * 0.45,
                              pageWidth * 0.65, pageHeight * 0.4);

    qInfo() << "page width: " << pageWidth;
    qInfo() << "page height: " << pageHeight;

    painter.begin(&printer);
    // Imagen de receta principal
    painter.drawImage(target, recetaImage);

    // Configuracion del lapiz
    painter.setPen(Qt::black);
    painter.setFont(QFont("Roboto", 12));

    // Escritura de texto dinamico
    painter.drawText(pageWidth * 0.25, pageHeight * 0.25, nombre);
    painter.drawText(pageWidth * 0.2, pageHeight * 0.3, rut);
    painter.drawText(pageWidth * 0.55, pageHeight * 0.3, edad);
    painter.drawText(pageWidth * 0.25, pageHeight * 0.35, direccion);
    painter.drawText(contenidoRectangle, Qt::AlignJustify | Qt::TextWordWrap,
                     contenido);

    QString formatedFolio = "Folio N°" + numeroFolio;
    painter.drawText(0, pageHeight, formatedFolio);

    // Fecha

    painter.setFont(QFont("Roboto", 14));
    painter.drawText(pageWidth * 0.16, pageHeight * 0.85,
                     QDate::currentDate().toString("dd/MM/yyyy"));

    painter.end();
    qInfo() << "[ C++ ] Painting process end";
    qInfo() << "[ C++ ] Printing process Succeed!";

    return true;
  }

  qInfo() << " [ C++ ] Printing failed";
  return false;
}

bool Utility::isDatabaseOpen() const { return m_isDatabaseOpen; }

void Utility::setIsDatabaseOpen(bool newIsDatabaseOpen) {
  m_isDatabaseOpen = newIsDatabaseOpen;
}

bool Utility::savePlanDeAccion(QStringList dataPrestacion,
                               QStringList dataPieza, QStringList dataPrecio,
                               int patientId) {

  if (!isOpen()) {
    qInfo() << "[ C++ ] Database is not open, operation cancelled";
    return false;
  }

  QSqlQuery queryPlanAccion;
  queryPlanAccion.prepare(
      "INSERT INTO plan_accion(patient_id) VALUES(:patient_id)");
  queryPlanAccion.bindValue(":patient_id", patientId);

  if (!queryPlanAccion.exec()) {
    qInfo() << "[ ERROR ] La creacion del Plan de accion fallo";
    qInfo() << queryPlanAccion.lastError();
    return false;
  }

  int lastId = queryPlanAccion.lastInsertId().toInt();

  for (int i = 0; i < dataPrestacion.size(); ++i) {
    QSqlQuery query;
    query.prepare("INSERT INTO servicio(plan_id, prestacion, precio, pieza) "
                  "VALUES(:plan_id , :prestacion , :precio , :pieza)");
    query.bindValue(":plan_id", lastId);
    query.bindValue(":prestacion", dataPrestacion.at(i));
    query.bindValue(":precio", dataPrecio.at(i));
    query.bindValue(":pieza", dataPieza.at(i));
    if (!query.exec()) {
      qInfo() << "[ ERROR ] La creacion de una de las prestaciones fallo";
      qInfo() << query.lastError();
      qInfo() << "[ C++ ] Intentando revertir proceso...";
      query.prepare("DELETE FROM plan_accion WHERE plan_id = :plan_id");
      query.bindValue(":plan_id", lastId);
      if (!query.exec()) {

        qInfo() << "[ ERROR ] No se pudo revertir el proceso...";
        qInfo() << query.lastError();
        qInfo()
            << "[ C++ ] Se requiere intervencion manual en la base de datos";
        return false;
      }
      return false;
    }
  }
  qInfo() << "Se guardaron con exito las prestaciones";

  return true;
}

int Utility::saveReceta(QString contenido, int patientId, int userId) {

  qInfo() << "[ C++ ] Se inicia el proceso de almacenamiento de receta";
  if (!isOpen()) {
    qInfo() << "[ C++ ] Database is not open, operation cancelled";
    return 0;
  }

  QSqlQuery query;
  query.prepare("INSERT INTO receta (patient_id, user_id, contenido) VALUES "
                "(:patient_id , :user_id , :contenido)");
  query.bindValue(":patient_id", patientId);
  query.bindValue(":user_id", userId);
  query.bindValue(":contenido", contenido);

  if (!query.exec()) {
    qInfo() << "[ ERROR ] La creacion de la receta fallo";
    qInfo() << query.lastError();
    return 0;
  }

  qInfo() << " [ C++ ] La receta se guardo con exito!";
  //  qInfo() << " [ C++ ] ultimo id usado: " << query.lastInsertId();
  return query.lastInsertId().toInt();
}

float Utility::calculateCenter(int total, int size) {
  return ((total / 2) - (size / 2));
}
