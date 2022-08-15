import QtQuick
import QtQuick.Controls
import cl.odontoficha.patient 1.0

Item {
    id: root
    property int pacienteId: 0

    Patient {
        id: patient
        patient_id: pacienteId
    }

    Column {

        anchors.fill: parent
        topPadding: 72
        spacing: 16

        Label {
            anchors.left: parent.left
            anchors.leftMargin: 40
            text: "Receta"
            font.pixelSize: 48
        }
        Rectangle {
            id: card
            anchors.left: parent.left
            anchors.leftMargin: 40
            border.color: "#E5E5E5"
            border.width: 1
            radius: 12
            width: parent.width < 960 ? parent.width - 160 : 800
            Material.elevation: 6
            height: 520
            Column {
                anchors.fill: parent
                topPadding: 24
                anchors.leftMargin: 24
                anchors.rightMargin: 24
                spacing: 24
                Label {
                    text: "Paciente: " + patient.name + " " + patient.last_name
                    font.pixelSize: 16
                    wrapMode: Label.WordWrap
                }
                TextArea {
                    id: textArea
                    placeholderText: "Rp."
                    anchors.horizontalCenter: parent.horizontalCenter
                    padding: 8
                    width: card.width - 32
                    wrapMode: TextArea.Wrap
                    clip: true
                    selectByMouse: true
                    height: 360

                    background: Rectangle {
                        implicitWidth: card.width - 32
                        implicitHeight: 360
                        border.width: 1
                        border.color: "#e2e8f0"
                        radius: 12
                        color: "#f8fafc"
                    }
                }
            }
            Button {
                //                enabled: preDataModel.count > 0
                text: "Generar"
                anchors.left: parent.left
                anchors.leftMargin: 24
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 24
                topPadding: 16
                bottomPadding: 16
                width: 142
                Material.background: "#D8B4FE"
                Material.foreground: "#FFFFFF"
                font.bold: true

                onClicked: {
                    let formatedName = patient.name
                        == "" ? "" : patient.name + " " + patient.last_name
                    let formatedRut = patient.rut
                        == "" ? "" : [patient.rut.slice(
                                          0, -7), '.', patient.rut.slice(
                                          -7, -4), '.', patient.rut.slice(
                                          -4, -1), '-', patient.rut.slice(
                                          -1)].join('')
                    let age = getAge(patient.birth_day)
                    let direccion = patient.address

                    console.log(age)
                    console.log(typeof (age))

                    let formatedAge = !age ? "" : age + " años"

                    utilityObject.printReceta(textArea.text, formatedName,
                                              formatedRut, direccion,
                                              formatedAge, pacienteId)
                }
                function getAge(dateString) {
                    var today = new Date()
                    var birthDate = new Date(dateString)
                    var age = today.getFullYear() - birthDate.getFullYear()
                    var m = today.getMonth() - birthDate.getMonth()
                    if (m < 0 || (m === 0 && today.getDate(
                                      ) < birthDate.getDate())) {
                        age--
                    }
                    return age
                }
            }
        }
    }
}
