import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

Item {
    id: root
    clip: true

    Column {
        anchors.fill: parent
        topPadding: 64
        leftPadding: 40
        spacing: 16

        Label {
            text: "Configuración"
            font.pixelSize: 48
        }
        Rectangle {
            id: card
            anchors.left: parent.left
            anchors.leftMargin: 40
            height: 560
            width: parent.width < 880 ? parent.width - 80 : 800
            border.color: "#E5E5E5"
            border.width: 1
            radius: 12
            Column {
                anchors.fill: parent
                anchors.leftMargin: 24
                anchors.rightMargin: 24
                topPadding: 24
                spacing: 16
                Label {
                    text: "Prestaciones y Precio: "
                    font.pixelSize: 24
                }

                Flow {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    spacing: 8

                    Item {
                        width: 320
                        height: 64
                        TextField {
                            id: nuevoServicioNombre
                            placeholderText: "Ej: Blanqueamiento"
                            width: parent.width
                            onEditingFinished: focus = false
                            selectByMouse: true
                            Label {
                                text: "Nombre de Servicio"
                                anchors.topMargin: -12
                                anchors.top: parent.top
                                anchors.left: parent.left
                                font.pixelSize: 12
                            }
                        }
                    }
                    Item {
                        width: 240
                        height: 64
                        TextField {
                            id: nuevoServicioPrecio
                            placeholderText: "Ej: 32.000"
                            width: parent.width
                            onEditingFinished: focus = false
                            selectByMouse: true
                            Label {
                                text: "Precio de Servicio"
                                anchors.topMargin: -12
                                anchors.top: parent.top
                                anchors.left: parent.left
                                font.pixelSize: 12
                            }
                        }
                    }
                    Item {
                        width: 240
                        height: 64
                        Button {
                            text: "Crear Servicio"
                            anchors.left: parent.left
                            anchors.rightMargin: 24
                            anchors.verticalCenter: parent.verticalCenter
                            topPadding: 16
                            bottomPadding: 16
                            enabled: nuevoServicioNombre.text === ""
                                     || nuevoServicioPrecio.text === "" ? false : true
                            width: 160
                            Material.background: "#D8B4FE"
                            Material.foreground: "#FFFFFF"
                            font.bold: true
                            onClicked: configServiciosObject.addServicio(
                                           nuevoServicioNombre.text,
                                           nuevoServicioPrecio.text)
                        }
                    }
                }

                ListView {
                    id: listView
                    width: 520
                    height: 240
                    clip: true
                    model: configServiciosObject
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
                            anchors.right: parent.right
                            anchors.rightMargin: 80
                            text: "Precio"
                            font.bold: true
                            font.pixelSize: 12
                        }
                    }

                    delegate: Item {
                        width: listView.width
                        height: 40
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
                            text: precio
                            font.pixelSize: 10
                            color: "#1f2937"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            anchors.rightMargin: 80
                        }
                        MouseArea {
                            id: servicioRowMouseArea
                            anchors.fill: parent
                            hoverEnabled: true
                            acceptedButtons: Qt.LeftButton
                                             | Qt.RightButton // default is Qt.LeftButton only
                            onClicked: function handler(mouse) {
                                if (mouse.button === Qt.RightButton) {
                                    contextMenu.x = mouse.x
                                    contextMenu.y = mouse.y
                                    contextMenu.open()
                                }
                            }
                        }

                        Menu {
                            id: contextMenu
                            MenuItem {
                                text: 'Editar'
                                onClicked: console.log("Selected Editar")
                            }
                            MenuItem {
                                text: 'Borrar'
                                onClicked: configServiciosObject.deleteServicio(
                                               servicio_config_id)
                            }
                        }
                    }
                }
            }
        }
    }
}
