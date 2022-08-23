import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import cl.odontoficha.patient 1.0
import cl.odontoficha.configserviciossql 1.0

Item {
    id: root
    property int pacienteId: 0
    Patient {
        id: patient
        patient_id: pacienteId
    }

    ListModel {
        id: preDataModel
    }

    ListModel {
        id: prestacionModelOld
        ListElement {
            nombre: "Aplicación flúor barniz"
            precio: "8.500"
        }
        ListElement {
            nombre: "Blanqueamiento"
            precio: "88.000"
        }
        ListElement {
            nombre: "Carillas de resina"
            precio: "35.000"
        }
        ListElement {
            nombre: "Carillas de cerámica"
            precio: "83.000"
        }
        ListElement {
            nombre: "Consulta"
            precio: "10.000"
        }
        ListElement {
            nombre: "Detartraje"
            precio: "25.000"
        }

        ListElement {
            nombre: "Detartraje más Flúor"
            precio: "28.000"
        }
        ListElement {
            nombre: "Exodoncia"
            precio: "35.000"
        }
        ListElement {
            nombre: "Endodoncia anterior"
            precio: "135.000"
        }
        ListElement {
            nombre: "Endodoncia premolar"
            precio: "140.000"
        }
        ListElement {
            nombre: "Endodoncia molar"
            precio: "145.000"
        }
        ListElement {
            nombre: "Incrustación"
            precio: "93.000"
        }
        ListElement {
            nombre: "Juego de prótesis total acrílica"
            precio: "225.000"
        }

        ListElement {
            nombre: "PFU"
            precio: "165.000"
        }

        ListElement {
            nombre: "Prótesis total acrílica"
            precio: "120.000"
        }
        ListElement {
            nombre: "Prótesis parcial metálica"
            precio: "155.000"
        }
        ListElement {
            nombre: "Plano de relajación"
            precio: "90.000"
        }

        ListElement {
            nombre: "Restauración simple"
            precio: "30.000"
        }
        ListElement {
            nombre: "Restauración compleja"
            precio: "35.000"
        }

        ListElement {
            nombre: "Reparación prótesis removible lab."
            precio: "55.000"
        }
        ListElement {
            nombre: "Reparación prótesis removible"
            precio: "30.000"
        }
        ListElement {
            nombre: "Sellante"
            precio: "13.000"
        }
        ListElement {
            nombre: "Sellantes primeros molares"
            precio: "37.000"
        }

        ListElement {
            nombre: "Trepanación"
            precio: "30.000"
        }
    }

    Column {

        anchors.fill: parent
        topPadding: 72
        spacing: 16

        Label {
            anchors.left: parent.left
            anchors.leftMargin: 40
            text: "Presupuesto"
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
                spacing: 40
                Label {
                    text: "Paciente: " + patient.name + " " + patient.last_name
                    font.pixelSize: 16
                    wrapMode: Label.WordWrap
                }

                Flow {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    spacing: 8
                    Item {
                        width: 320
                        height: 64
                        ComboBox {
                            id: prestacionComboBox
                            model: ConfigServiciosModel {
                                id: prestacionModel
                            }
                            textRole: "nombre"
                            valueRole: "servicio_config_id"
                            width: 320
                            height: 64
                            Label {
                                text: "Prestación"
                                anchors.topMargin: -12
                                anchors.top: parent.top
                                anchors.left: parent.left
                                font.pixelSize: 12
                            }
                        }
                    }
                    Item {
                        width: 176
                        height: 64
                        ComboBox {
                            id: piezaComboBox
                            model: ["Arcada superior", "Arcada inferior", "1.1", "1.2", "1.3", "1.4", "1.5", "1.6", "1.7", "1.8", "2.1", "2.2", "2.3", "2.4", "2.5", "2.6", "2.7", "2.8", "3.1", "3.2", "3.3", "3.4", "3.5", "3.6", "3.7", "3.8", "4.1", "4.2", "4.3", "4.4", "4.5", "4.6", "4.7", "4.8", "5.1", "5.2", "5.3", "5.4", "5.5", "6.1", "6.2", "6.3", "6.4", "6.5", "7.1", "7.2", "7.3", "7.4", "7.5", "8.1", "8.2", "8.3", "8.4", "8.5"]
                            width: 176
                            height: 64
                            Label {
                                text: "Pieza"
                                anchors.topMargin: -12
                                anchors.top: parent.top
                                anchors.left: parent.left
                                font.pixelSize: 12
                            }
                        }
                    }
                    Button {
                        text: "Agregar"
                        topPadding: 16
                        bottomPadding: 16
                        width: 120
                        Material.background: "#D8B4FE"
                        Material.foreground: "#FFFFFF"
                        font.bold: true
                        onClicked: preDataModel.append({
                                                           "nombre": prestacionModel.get(
                                                                         prestacionComboBox.currentValue,
                                                                         true),
                                                           "precio": prestacionModel.get(
                                                                         prestacionComboBox.currentValue,
                                                                         false),
                                                           "pieza": piezaComboBox.currentValue
                                                       })
                    }
                }

                ListView {
                    id: listView
                    width: 520
                    height: 184
                    clip: true
                    model: preDataModel
                    headerPositioning: ListView.OverlayHeader
                    header: Item {
                        width: listView.width
                        height: 32
                        z: 2

                        Rectangle {
                            anchors.fill: parent
                            border.width: 1
                            border.color: "#E5E5E5"
                        }

                        Label {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: 16
                            text: "Prestación"
                            font.bold: true
                            font.pixelSize: 12
                        }
                        Label {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: "Pieza"
                            font.bold: true
                            font.pixelSize: 12
                        }
                        Label {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            anchors.rightMargin: 56
                            text: "Precio"
                            font.bold: true
                            font.pixelSize: 12
                        }
                    }

                    delegate: Item {
                        width: listView.width
                        height: 32
                        opacity: 1
                        Rectangle {
                            anchors.fill: parent
                            border.width: 1
                            border.color: "#E5E5E5"
                        }

                        Label {
                            text: nombre
                            font.pixelSize: 10
                            color: "#1f2937"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: 16
                        }
                        Label {
                            text: pieza
                            font.pixelSize: 10
                            color: "#1f2937"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        Label {
                            text: precio
                            font.pixelSize: 10
                            color: "#1f2937"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            anchors.rightMargin: 56
                        }
                        Label {
                            text: "X"
                            font.pixelSize: 12
                            color: "#ef4444"
                            font.bold: true
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            anchors.rightMargin: 16
                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                acceptedButtons: Qt.LeftButton
                                onClicked: preDataModel.remove(index)
                            }
                        }
                    }
                }
            }
            Button {
                enabled: preDataModel.count > 0
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
                    let direccion = patient.address

                    let dataPrestacion = []
                    let dataPrecio = []
                    let dataPieza = []

                    for (var i = 0; i < preDataModel.count; i++) {
                        dataPrestacion.push(preDataModel.get(i).nombre)
                        dataPrecio.push(preDataModel.get(i).precio)
                        dataPieza.push(preDataModel.get(i).pieza)
                    }

                    utilityObject.printDocument(dataPrestacion, dataPieza,
                                                dataPrecio, formatedName,
                                                formatedRut, direccion,
                                                root.pacienteId)
                }
            }
            Button {
                id: guardarButton
                enabled: preDataModel.count > 0 && root.pacienteId !== 0
                text: "Guardar"
                anchors.left: parent.left
                anchors.leftMargin: 190
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 24
                topPadding: 16
                bottomPadding: 16
                width: 142
                Material.background: "#4ade80"
                Material.foreground: "#FFFFFF"
                font.bold: true
                ToolTip.delay: 100

                onClicked: {
                    let formatedName = patient.name
                        == "" ? "" : patient.name + " " + patient.last_name
                    let formatedRut = patient.rut
                        == "" ? "" : [patient.rut.slice(
                                          0, -7), '.', patient.rut.slice(
                                          -7, -4), '.', patient.rut.slice(
                                          -4, -1), '-', patient.rut.slice(
                                          -1)].join('')

                    let dataPrestacion = []
                    let dataPrecio = []
                    let dataPieza = []

                    for (var i = 0; i < preDataModel.count; i++) {
                        dataPrestacion.push(preDataModel.get(i).nombre)
                        dataPrecio.push(preDataModel.get(i).precio)
                        dataPieza.push(preDataModel.get(i).pieza)
                    }

                    let isSaved = utilityObject.savePlanDeAccion(
                            dataPrestacion, dataPieza, dataPrecio,
                            root.pacienteId)

                    if (isSaved) {
                        guardarButton.ToolTip.show("Guardado con exito!", 2000)
                    } else {
                        guardarButton.ToolTip.show("ERROR al guardar", 2000)
                    }
                }
            }
        }
    }
}
