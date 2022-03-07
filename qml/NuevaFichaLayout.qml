import QtQuick
import QtQuick.Controls

Item {
    id: root

    property int cardWidth: 400
    property bool isSaving: false

    signal savePressed(string content)

    function saveFinished(isIt) {
        button.enabled = true
        indicator.running = false

        if (isIt) {
            textArea.text = ""
        }
    }

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
                        id: textArea
                        placeholderText: "Nueva Ficha Clinica"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: 16
                        padding: 8
                        width: cardWidth - 32
                        wrapMode: TextArea.Wrap
                        clip: true
                        selectByMouse: true
                        height: 520

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
                        id: button
                        text: "Guardar Hoja"
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

                        onClicked: {
                            button.enabled = false
                            indicator.running = true

                            root.savePressed(textArea.text)
                        }
                        BusyIndicator {
                            id: indicator
                            running: false
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
