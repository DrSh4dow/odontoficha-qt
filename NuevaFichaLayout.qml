import QtQuick
import QtQuick.Controls

Item {
    id: root

    property int cardWidth: 400
    property bool isSaving: false

    ScrollView {

        height: root.height
        width: root.width
        Flickable {
            height: root.height
            width: root.width
            contentHeight: card.height + 48
            clip: true
            Column {
                topPadding: 16
                bottomPadding: 32
                Rectangle {
                    id: card
                    width: cardWidth
                    color: "white"
                    height: 624
                    x: 104
                    border.color: "#E5E5E5"
                    border.width: 1
                    radius: 12

                    TextArea {
                        placeholderText: "Nueva Ficha Clinica"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: 16
                        padding: 8
                        wrapMode: TextArea.WordWrap
                        selectByMouse: true

                        background: Rectangle {
                            implicitWidth: cardWidth - 32
                            implicitHeight: 520
                            border.width: 1
                            border.color: "#e2e8f0"
                            radius: 12
                            color: "#f8fafc"
                        }
                    }

                    Button {
                        text: "Guardar Ficha"
                        topPadding: 16
                        bottomPadding: 16
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 16
                        anchors.bottomMargin: 16
                        width: 142
                        Material.background: "#D8B4FE"
                        Material.foreground: "#FFFFFF"
                        font.bold: true
                        enabled: !isSaving

                        onClicked: isSaving = true
                        BusyIndicator {
                            running: isSaving
                            height: 32
                            width: 32
                            anchors.centerIn: parent
                        }
                    }
                }
            }
        }
    }
}
