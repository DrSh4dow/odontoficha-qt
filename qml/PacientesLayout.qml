import QtQuick
import QtQuick.Controls.Material
import Qt5Compat.GraphicalEffects
import cl.odontoficha.patient 1.0

Item {
    id: root
    clip: true

    property int globalX: 0
    property int globalY: 0

    signal pacienteSelected(int pagina, string id)

    Patient {
        id: patientUtil
    }
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
                        placeholderText: "Filtrar por Nombre o RUT"
                        id: filtroText
                        height: 40
                        width: 264
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 24
                        selectByMouse: true
                        onTextEdited: {
                            patientProxyModel.customFilter(filtroText.text)
                        }
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
                        model: patientProxyModel
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
        function titleCase(str) {
            var splitStr = str.toLowerCase().split(' ')
            for (var i = 0; i < splitStr.length; i++) {
                // You do not need to check if i is larger than splitStr length, as your for does that for you
                // Assign it back to the array
                splitStr[i] = splitStr[i].charAt(0).toUpperCase(
                            ) + splitStr[i].substring(1)
            }
            // Directly return the joined string
            return splitStr.join(' ')
        }

        onAccepted: function submitData() {
            console.log("Data sanitization and submission begin...")
            let sanitizedRut = rut.text.trim()
            let sanitizedPasaporte = pasaporte.text.trim()
            let sanitizedNombre = titleCase(nombre.text.trim())
            let sanitizedApellido = titleCase(apellido.text.trim())
            let sanitizedBirthday = birthday.text.split(
                    "/")[2] + "-" + birthday.text.split(
                    "/")[1] + "-" + birthday.text.split("/")[0]
            let sanitizedFono = fono.text.trim()
            let sanitizedEmail = email.text.trim()
            let sanitizedAntecedentes = antecedentes.text
            let sanitizedAddress = address.text

            console.log("Interfacing with c++...")

            let isCreated = patientUtil.createNewPatient(sanitizedRut,
                                                         sanitizedPasaporte,
                                                         sanitizedNombre,
                                                         sanitizedApellido,
                                                         sanitizedBirthday,
                                                         sanitizedFono,
                                                         sanitizedEmail,
                                                         sanitizedAntecedentes,
                                                         sanitizedAddress)

            if (isCreated) {
                console.log("Paciente creado con exito!")
                //                patientModel.refresh()
                patientSourceModel.refresh()
            } else {
                console.log("[ ERROR ] fracaso la creacion de paciente...")
            }
        }
        onRejected: console.log("Cancel clicked")
        onOpened: {
            rut.text = ""
            pasaporte.text = ""
            nombre.text = ""
            apellido.text = ""
            birthday.text = "28/11/1996"
            fono.text = ""
            email.text = ""
            antecedentes.text = ""
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
                    selectByMouse: true
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
                    selectByMouse: true
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
                    selectByMouse: true
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
                    selectByMouse: true
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
                    text: "28/11/1996"
                    onEditingFinished: focus = false
                    inputMask: "00/00/0000"
                    Label {
                        text: "Fecha de Nacimiento (Dia/Mes/Año)"
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
                    selectByMouse: true
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
                    selectByMouse: true
                    Label {
                        text: "Email"
                        anchors.topMargin: -12
                        anchors.top: parent.top
                        anchors.left: parent.left
                        font.pixelSize: 12
                    }
                }
                TextField {
                    id: address
                    width: 280
                    placeholderText: "Ej: calle ejemplar 1234"
                    onEditingFinished: focus = false
                    selectByMouse: true
                    Label {
                        text: "Dirección"
                        anchors.topMargin: -12
                        anchors.top: parent.top
                        anchors.left: parent.left
                        font.pixelSize: 12
                    }
                }
            }
            TextArea {
                id: antecedentes
                placeholderText: qsTr("Ej: Hipertension Arterial, Diabetes Mellitus tipo 2, Osteoporosis... ")
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.topMargin: 16
                wrapMode: TextArea.Wrap
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
