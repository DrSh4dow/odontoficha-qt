import QtQuick
import QtQuick.Controls.Material
import Qt5Compat.GraphicalEffects
import cl.odontoficha.sql 1.0

Item {
    id: root
    clip: true

    property int globalX: 0
    property int globalY: 0

    signal pacienteSelected(int pagina, string id)
    Column {
        anchors.fill: parent
        topPadding: 64
        leftPadding: 40
        spacing: 16

        Label {
            text: "Pacientes"
            font.pixelSize: 48
        }

        Rectangle {
            id: card
            anchors.left: parent.left
            anchors.leftMargin: 40
            anchors.rightMargin: 40
            anchors.right: parent.right
            height: 560
            border.color: "#E5E5E5"
            border.width: 1
            radius: 12

            Column {
                anchors.fill: parent

                Item {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: 64

                    TextField {
                        placeholderText: "Buscar por Nombre o RUT"
                        height: 40
                        width: 264
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 24
                    }

                    Button {
                        text: "Crear Paciente"
                        anchors.right: parent.right
                        anchors.rightMargin: 24
                        anchors.verticalCenter: parent.verticalCenter
                        topPadding: 16
                        bottomPadding: 16
                        width: 160
                        Material.background: "#D8B4FE"
                        Material.foreground: "#FFFFFF"
                        font.bold: true
                        onClicked: popup.open()
                    }
                }

                PacientesHeader {
                    id: pacientesHeader
                }
                Item {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: 400
                    ListView {
                        anchors.fill: parent
                        clip: true
                        model: PatientModel {}
                        delegate: PacienteRow {
                            nombres: model.name
                            apellidos: model.last_name
                            rut: model.rut
                            modificacion: model.fecha_modificacion
                            ingreso: model.fecha_creacion
                            pacienteId: model.patient_id
                            onPacienteSelected: function handler(pag, ident) {
                                root.pacienteSelected(pag, ident)
                            }
                        }
                    }
                }

                Rectangle {
                    color: "#F4F2FF"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: 48
                    border.width: 1
                    border.color: "#E5E5E5"
                }
            }
        }
    }
    Dialog {
        id: popup
        width: 640
        height: 640
        title: "Crear Paciente"
        standardButtons: Dialog.Save | Dialog.Cancel
        closePolicy: Popup.NoAutoClose
        modal: true
        focus: true
        x: ((globalX - 240) / 2) - (width / 1.5)
        y: (globalY / 2) - (height / 2)
        onAccepted: function submitData() {
            console.log("Data sanitization and submission begin...")

            console.log("TO DO lol")
        }
        onRejected: console.log("Cancel clicked")
        onOpened: {
            rut.text = ""
            pasaporte.text = ""
            nombre.text = ""
            apellido.text = ""
            birthday.text = "1990-11-25"
            fono.text = ""
            email.text = ""
        }

        Column {
            spacing: 16
            anchors.fill: parent

            Grid {
                columns: 2
                topPadding: 32
                spacing: 16
                anchors.left: parent.left
                anchors.right: parent.right
                TextField {
                    id: rut
                    placeholderText: "Ej: 123456789"
                    width: 280
                    onEditingFinished: focus = false
                    validator: IntValidator {
                        bottom: 0
                    }
                    Label {
                        text: "RUT (sin puntos ni guion)"
                        anchors.topMargin: -12
                        anchors.top: parent.top
                        anchors.left: parent.left
                        font.pixelSize: 12
                    }
                }
                TextField {
                    id: pasaporte
                    width: 280
                    onEditingFinished: focus = false
                    Label {
                        text: "Pasaporte (RUT Ausente)"
                        anchors.topMargin: -12
                        anchors.top: parent.top
                        anchors.left: parent.left
                        font.pixelSize: 12
                    }
                }
                TextField {
                    id: nombre
                    width: 280
                    onEditingFinished: focus = false
                    Label {
                        text: "Nombres*"
                        anchors.topMargin: -12
                        anchors.top: parent.top
                        anchors.left: parent.left
                        font.pixelSize: 12
                    }
                }
                TextField {
                    id: apellido
                    width: 280
                    onEditingFinished: focus = false
                    Label {
                        text: "Apellidos*"
                        anchors.topMargin: -12
                        anchors.top: parent.top
                        anchors.left: parent.left
                        font.pixelSize: 12
                    }
                }
                TextField {
                    id: birthday
                    width: 280
                    text: "1990-11-25"
                    onEditingFinished: focus = false
                    inputMask: "0000-00-00"
                    Label {
                        text: "Fecha de Nacimiento (Año-Mes-Dia)"
                        anchors.topMargin: -12
                        anchors.top: parent.top
                        anchors.left: parent.left
                        font.pixelSize: 12
                    }
                }
                TextField {
                    id: fono
                    width: 280
                    onEditingFinished: focus = false
                    placeholderText: "Ej: +56912345678"
                    Label {
                        text: "Fono"
                        anchors.topMargin: -12
                        anchors.top: parent.top
                        anchors.left: parent.left
                        font.pixelSize: 12
                    }
                }
                TextField {
                    id: email
                    width: 280
                    placeholderText: "Ej: ejemplo@correo.cl"
                    onEditingFinished: focus = false
                    Label {
                        text: "Email"
                        anchors.topMargin: -12
                        anchors.top: parent.top
                        anchors.left: parent.left
                        font.pixelSize: 12
                    }
                }
            }
            TextArea {
                placeholderText: qsTr("Ej: Hipertension Arterial, Diabetes Mellitus tipo 2, Osteoporosis... ")
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.topMargin: 16
                wrapMode: TextArea.WordWrap
                selectByMouse: true

                Label {
                    text: "Antecedentes Morbidos"
                    anchors.topMargin: -12
                    anchors.top: parent.top
                    anchors.left: parent.left
                    font.pixelSize: 12
                }
            }
        }
    }
}
