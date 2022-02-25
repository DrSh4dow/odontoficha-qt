#include "patient.h"

Patient::Patient(QObject *parent) : QObject{parent} {}

void Patient::queryPatient(int newId) {
  //  qInfo() << "info from queryPatient";

  QSqlQuery query;
  query.prepare("SELECT * FROM patient WHERE patient.patient_id = :id");
  query.bindValue(":id", newId);
  query.exec();

  while (query.next()) {

    setRut(query.value(1).toString());
    setPassport(query.value(2).toString());
    setName(query.value(3).toString());
    setLast_name(query.value(4).toString());
    setBirth_day(query.value(5).toString());
    setPhone(query.value(6).toString());
    setEmail(query.value(7).toString());
    setAntecedentes(query.value(8).toString());
    setFecha_creacion(query.value(9).toString());
    setFecha_modificacion(query.value(10).toString());
  }
}

/*
 *
 * GETERS and SETTERS LIVE FROM THIS POINT ON
 *
 */

int Patient::patient_id() const { return m_patient_id; }

void Patient::setPatient_id(int newPatient_id) {

  if (newPatient_id == m_patient_id)
    return;

  m_patient_id = newPatient_id;
  emit patient_idChanged();
  //  qInfo() << "[ MESAGGE FROM patient.h ] : ejecutando queryPatient";

  queryPatient(newPatient_id);
}

const QString &Patient::rut() const { return m_rut; }

void Patient::setRut(const QString &newRut) {
  m_rut = newRut;
  emit rutChanged();
}

const QString &Patient::passport() const { return m_passport; }

void Patient::setPassport(const QString &newPassport) {
  m_passport = newPassport;
  emit passportChanged();
}

const QString &Patient::name() const { return m_name; }

void Patient::setName(const QString &newName) {
  m_name = newName;
  emit nameChanged();
}

const QString &Patient::last_name() const { return m_last_name; }

void Patient::setLast_name(const QString &newLast_name) {
  m_last_name = newLast_name;
  emit last_nameChanged();
}

const QString &Patient::birth_day() const { return m_birth_day; }

void Patient::setBirth_day(const QString &newBirth_day) {
  m_birth_day = newBirth_day;
  emit birth_dayChanged();
}

const QString &Patient::phone() const { return m_phone; }

void Patient::setPhone(const QString &newPhone) {
  m_phone = newPhone;
  emit phoneChanged();
}

const QString &Patient::email() const { return m_email; }

void Patient::setEmail(const QString &newEmail) {
  m_email = newEmail;
  emit emailChanged();
}

const QString &Patient::antecedentes() const { return m_antecedentes; }

void Patient::setAntecedentes(const QString &newAntecedentes) {
  m_antecedentes = newAntecedentes;
  emit antecedentesChanged();
}

const QString &Patient::fecha_creacion() const { return m_fecha_creacion; }

void Patient::setFecha_creacion(const QString &newFecha_creacion) {
  m_fecha_creacion = newFecha_creacion;
  emit fecha_creacionChanged();
}

const QString &Patient::fecha_modificacion() const {
  return m_fecha_modificacion;
}

void Patient::setFecha_modificacion(const QString &newFecha_modificacion) {
  m_fecha_modificacion = newFecha_modificacion;
  emit fecha_modificacionChanged();
}

bool Patient::createNewPatient(QString nRut, QString nPassport, QString nName,
                               QString nLastName, QString nBirthday,
                               QString nPhone, QString nEmail,
                               QString nAntecedentes) {

  QSqlQuery query;

  query.prepare(
      "INSERT INTO patient(rut, passport, name, last_name, birth_day, phone, "
      "email, antecedentes) VALUES (:rut, :passport, :name, :last_name, "
      ":birth_day, :phone, :email, :antecedentes)");
  query.bindValue(":rut", nRut);
  query.bindValue(":passport", nPassport);
  query.bindValue(":name", nName);
  query.bindValue(":last_name", nLastName);
  query.bindValue(":birth_day", nBirthday);
  query.bindValue(":phone", nPhone);
  query.bindValue(":email", nEmail);
  query.bindValue(":antecedentes", nAntecedentes);

  if (!query.exec()) {
    qInfo() << "[ ERROR ] La creacion del paciente fallo";
    qInfo() << query.lastError();
    return false;
  }

  qInfo() << " [ C++ ] El paciente se creo con exito!";

  return true;
}

bool Patient::updateExistingPatient(QString nRut, QString nPassport,
                                    QString nName, QString nLastName,
                                    QString nBirthday, QString nPhone,
                                    QString nEmail, QString nAntecedentes) {

  QSqlQuery query;
  query.prepare(
      "UPDATE patient SET rut = :rut, passport = :passport, name = :name, "
      "last_name = :last_name, birth_day = :birth_day, phone = :phone, email = "
      ":email, antecedentes = :antecedentes WHERE patient_id = :id");

  query.bindValue(":rut", nRut);
  query.bindValue(":passport", nPassport);
  query.bindValue(":name", nName);
  query.bindValue(":last_name", nLastName);
  query.bindValue(":birth_day", nBirthday);
  query.bindValue(":phone", nPhone);
  query.bindValue(":email", nEmail);
  query.bindValue(":antecedentes", nAntecedentes);
  query.bindValue(":id", m_patient_id);

  if (!query.exec()) {
    qInfo() << "[ ERROR ] el paciente no se pudo modificar";
    qInfo() << query.lastError();
    return false;
  }

  qInfo() << "El paciente se modifico con exito!";
  setRut(nRut);
  setPassport(nPassport);
  setName(nName);
  setLast_name(nLastName);
  setBirth_day(nBirthday);
  setPhone(nPhone);
  setEmail(nEmail);
  setAntecedentes(nAntecedentes);

  return true;
}
