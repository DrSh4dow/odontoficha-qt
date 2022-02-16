import QtQuick
import QtQuick.Controls
import cl.odontoficha.patient 1.0

Item {
    id: root
    clip: true
    property int pacienteId: 0

    Patient {
        id: patient
        patient_id: pacienteId
    }

    Column {
        anchors.fill: parent
        topPadding: 64
        spacing: 8
        Label {
            anchors.left: parent.left
            anchors.leftMargin: 104
            text: "Ficha Clinica"
            font.pixelSize: 48
        }

        Rectangle {
            id: card
            anchors.left: parent.left
            anchors.leftMargin: 104
            border.color: "#E5E5E5"
            border.width: 1
            radius: 12
            width: 680
            height: 320

            Column {
                anchors.fill: parent
                topPadding: 24
                Row {
                    anchors.left: parent.left
                    anchors.leftMargin: 24
                    anchors.right: parent.right
                    anchors.rightMargin: 24
                    height: 144
                    spacing: 16

                    Column {
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        width: 240
                        spacing: 16
                        Label {
                            text: "Nombres: " + patient.name
                            font.pixelSize: 16
                            wrapMode: Label.WordWrap
                        }
                        Label {
                            text: "RUT: " + [patient.rut.slice(
                                    0, -7), '.', patient.rut.slice(
                                    -7, -4), '.', patient.rut.slice(
                                    -4,
                                    -1), '-', patient.rut.slice(-1)].join('')
                            font.pixelSize: 16
                            wrapMode: Label.WordWrap
                        }
                        Label {
                            text: "Fono: " + patient.phone
                            font.pixelSize: 16
                            wrapMode: Label.WordWrap
                        }
                    }
                    Column {
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        width: 240
                        spacing: 16

                        Label {
                            text: "Apellidos: " + patient.last_name
                            font.pixelSize: 16
                            wrapMode: Label.WordWrap
                        }
                        Label {
                            text: "Fecha de Nacimiento: " + patient.birth_day + " (" + getAge(
                                      patient.birth_day) + " años)"
                            font.pixelSize: 16
                            wrapMode: Label.WordWrap

                            function getAge(dateString) {
                                var today = new Date()
                                var birthDate = new Date(dateString)
                                var age = today.getFullYear(
                                            ) - birthDate.getFullYear()
                                var m = today.getMonth() - birthDate.getMonth()
                                if (m < 0 || (m === 0 && today.getDate(
                                                  ) < birthDate.getDate())) {
                                    age--
                                }
                                return age
                            }
                        }
                        Label {
                            text: "Email: " + patient.email
                            font.pixelSize: 16
                            wrapMode: Label.WordWrap
                        }
                    }
                }
                Button {
                    text: "Editar Datos"
                    anchors.left: parent.left
                    anchors.leftMargin: 24
                    topPadding: 16
                    bottomPadding: 16
                    width: 142
                    Material.background: "#D8B4FE"
                    Material.foreground: "#FFFFFF"
                    font.bold: true
                }
            }
        }
    }
}
