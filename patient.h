#ifndef PATIENT_H
#define PATIENT_H

#include <QObject>

class Patient : public QObject {
  Q_OBJECT
  Q_PROPERTY(int patient_id READ patient_id WRITE setPatient_id NOTIFY
                 patient_idChanged)
public:
  explicit Patient(QObject *parent = nullptr);

  // JUST GETTERS and SETTERS

  int patient_id() const;
  void setPatient_id(int newPatient_id);

  const QString &rut() const;
  void setRut(const QString &newRut);

  const QString &passport() const;
  void setPassport(const QString &newPassport);

  const QString &name() const;
  void setName(const QString &newName);

  const QString &last_name() const;
  void setLast_name(const QString &newLast_name);

  const QString &birth_day() const;
  void setBirth_day(const QString &newBirth_day);

  const QString &phone() const;
  void setPhone(const QString &newPhone);

  const QString &email() const;
  void setEmail(const QString &newEmail);

  const QString &antecedentes() const;
  void setAntecedentes(const QString &newAntecedentes);

  const QString &fecha_creacion() const;
  void setFecha_creacion(const QString &newFecha_creacion);

  const QString &fecha_modificacion() const;
  void setFecha_modificacion(const QString &newFecha_modificacion);

private:
  int m_patient_id = 0;
  QString m_rut = "";
  QString m_passport = "";
  QString m_name = "";
  QString m_last_name = "";
  QString m_birth_day = "";
  QString m_phone = "";
  QString m_email = "";
  QString m_antecedentes = "";
  QString m_fecha_creacion = "";
  QString m_fecha_modificacion = "";

signals:
  void patient_idChanged();
  void rutChanged();
  void passportChanged();
  void nameChanged();
  void last_nameChanged();
  void birth_dayChanged();
  void phoneChanged();
  void emailChanged();
  void antecedentesChanged();
  void fecha_creacionChanged();
  void fecha_modificacionChanged();
};

#endif // PATIENT_H
