import QtQuick
import QtQuick.Controls.Material
import QtQuick.Controls
import QtQuick.Layouts
import cl.odontoficha.configserviciossql 1.0

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

                Label {
                    text: "Prestaciones y Precio: "
                    font.pixelSize: 24
                }
                ListView {
                    id: listView
                    width: 520
                    height: 240
                    clip: true
                    model: ConfigServiciosModel {
                        id: configServiciosModel
                    }
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
                    }
                }
            }
        }
    }
}
