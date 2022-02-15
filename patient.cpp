#include "patient.h"

Patient::Patient(QObject *parent) : QObject{parent} {}

/*
 *
 * GETERS and SETTERS LIVE FROM THIS POINT ON
 *
 */

int Patient::patient_id() const { return m_patient_id; }

void Patient::setPatient_id(int newPatient_id) { m_patient_id = newPatient_id; }

const QString &Patient::rut() const { return m_rut; }

void Patient::setRut(const QString &newRut) { m_rut = newRut; }

const QString &Patient::passport() const { return m_passport; }

void Patient::setPassport(const QString &newPassport) {
  m_passport = newPassport;
}

const QString &Patient::name() const { return m_name; }

void Patient::setName(const QString &newName) { m_name = newName; }

const QString &Patient::last_name() const { return m_last_name; }

void Patient::setLast_name(const QString &newLast_name) {
  m_last_name = newLast_name;
}

const QString &Patient::birth_day() const { return m_birth_day; }

void Patient::setBirth_day(const QString &newBirth_day) {
  m_birth_day = newBirth_day;
}

const QString &Patient::phone() const { return m_phone; }

void Patient::setPhone(const QString &newPhone) { m_phone = newPhone; }

const QString &Patient::email() const { return m_email; }

void Patient::setEmail(const QString &newEmail) { m_email = newEmail; }

const QString &Patient::antecedentes() const { return m_antecedentes; }

void Patient::setAntecedentes(const QString &newAntecedentes) {
  m_antecedentes = newAntecedentes;
}

const QString &Patient::fecha_creacion() const { return m_fecha_creacion; }

void Patient::setFecha_creacion(const QString &newFecha_creacion) {
  m_fecha_creacion = newFecha_creacion;
}

const QString &Patient::fecha_modificacion() const {
  return m_fecha_modificacion;
}

void Patient::setFecha_modificacion(const QString &newFecha_modificacion) {
  m_fecha_modificacion = newFecha_modificacion;
}
