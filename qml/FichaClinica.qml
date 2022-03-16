import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import cl.odontoficha.patient 1.0

Item {
    id: root
    clip: true
    property int pacienteId: 0

    property int globalX: 0
    property int globalY: 0

    function getFichas(id) {
        fichaLayout.getFichas(id)
    }

    Patient {
        id: patient
        patient_id: pacienteId
    }

    Column {
        anchors.fill: parent
        topPadding: 16
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
            width: parent.width < 960 ? parent.width - 160 : 800
            height: 320
            Material.elevation: 6
            clip: true

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
                        width: 210
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
                        width: 210
                        spacing: 16

                        Label {
                            text: "Apellidos: " + patient.last_name
                            font.pixelSize: 16
                            wrapMode: Label.WordWrap
                        }
                        Label {
                            text: "Fecha de Nacimiento: " + patient.birth_day.split(
                                      "-")[2] + "/" + patient.birth_day.split(
                                "-")[1] + "/" + patient.birth_day.split(
                                "-")[0] + " ( <b>" + getAge(
                                patient.birth_day) + " años </b>)"
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
                    onClicked: popup.open()
                }
            }

            TabBar {
                id: bar
                width: parent.width - 32
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 2
                Material.background: "#FFFFFF"
                Material.foreground: "#666666"
                TabButton {
                    text: "Nueva Hoja"
                    width: implicitWidth
                    icon.source: "qrc:/icons/resources/clipboard-text.svg"
                    display: TabButton.TextUnderIcon
                }
                TabButton {
                    text: "Historia Clinica"
                    width: implicitWidth
                    icon.source: "qrc:/icons/resources/file-document-multiple.svg"
                    display: TabButton.TextUnderIcon
                }
                TabButton {
                    text: "Antecedentes"
                    width: implicitWidth
                    icon.source: "qrc:/icons/resources/clipboard-account.svg"
                    display: TabButton.TextUnderIcon
                }
                TabButton {
                    text: "Plan de Acción"
                    width: implicitWidth
                    icon.source: "qrc:/icons/resources/file-multiple.svg"
                    display: TabButton.TextUnderIcon
                }
            }
        }
        Item {
            width: parent.width < 960 ? parent.width : 960
            height: parent.height - card.height - 80
            StackLayout {
                anchors.fill: parent
                currentIndex: bar.currentIndex

                NuevaFichaLayout {
                    id: nuevaFichaLayout
                    onSavePressed: function handler(content) {
                        fichaLayout.addFicha(content, pacienteId, 1)
                    }
                    cardWidth: card.width
                }
                FichaLayout {
                    id: fichaLayout
                    pacienteId: pacienteId
                    cardWidth: card.width
                    onIsFinish: function (isIt) {
                        if (isIt) {
                            bar.currentIndex = 1
                        }

                        nuevaFichaLayout.saveFinished(isIt)
                    }
                }
                AntecedentesLayout {

                    antecedentesText: patient.antecedentes
                    cardWidth: card.width
                }
                DocumentosLayout {}
            }
        }
    }
    Dialog {
        id: popup
        width: 640
        height: 640
        title: "Editar Datos"
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

            let isUpdated = patient.updateExistingPatient(sanitizedRut,
                                                          sanitizedPasaporte,
                                                          sanitizedNombre,
                                                          sanitizedApellido,
                                                          sanitizedBirthday,
                                                          sanitizedFono,
                                                          sanitizedEmail,
                                                          sanitizedAntecedentes)

            if (isUpdated) {
                console.log("Paciente modificado con exito!")
            } else {
                console.log("[ ERROR ] fracaso la modificacion de paciente...")
            }
        }
        onRejected: console.log("Cancel clicked")
        onOpened: {
            rut.text = patient.rut
            pasaporte.text = patient.passport
            nombre.text = patient.name
            apellido.text = patient.last_name
            birthday.text = patient.birth_day.split(
                        "-")[2] + "/" + patient.birth_day.split(
                        "-")[1] + "/" + patient.birth_day.split("-")[0]
            fono.text = patient.phone
            email.text = patient.email
            antecedentes.text = patient.antecedentes
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
                    text: "28/11/996"
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
