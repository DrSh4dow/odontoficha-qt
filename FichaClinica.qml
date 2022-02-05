import QtQuick
import QtQuick.Controls

Item {
    id: root
    clip: true
    property string pacienteId: ""

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
                            text: "Nombres: Jose Antonio"
                            font.pixelSize: 16
                            wrapMode: Label.WordWrap
                        }
                        Label {
                            text: "RUT: 12.345.678-9"
                            font.pixelSize: 16
                            wrapMode: Label.WordWrap
                        }
                        Label {
                            text: "Previsión: Fonasa"
                            font.pixelSize: 16
                            wrapMode: Label.WordWrap
                        }
                        Label {
                            text: "Fono: +56912345678"
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
                            text: "Apellidos: Perez Riquelme"
                            font.pixelSize: 16
                            wrapMode: Label.WordWrap
                        }
                        Label {
                            text: "Fecha de Nacimiento: 27/05/1973 (40 años)"
                            font.pixelSize: 16
                            wrapMode: Label.WordWrap
                        }
                        Label {
                            text: "Email: Ausente"
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
                }
            }
        }
    }
}
