import QtQuick
import QtQuick.Controls

Item {
    id: root
    property int cardWidth: 400
    property string antecedentesText: ""
    ScrollView {

        height: root.height
        width: root.width
        Flickable {
            height: root.height
            width: root.width
            contentHeight: card.height + 48
            clip: true
            Rectangle {
                id: card
                width: cardWidth
                color: "white"
                height: 552
                x: 104
                border.color: "#E5E5E5"
                border.width: 1
                radius: 12
                TextArea {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    padding: 8
                    wrapMode: TextArea.Wrap
                    width: cardWidth - 32
                    height: 520
                    selectByMouse: true
                    text: antecedentesText
                    clip: true
                    readOnly: true

                    background: Rectangle {
                        implicitWidth: cardWidth - 32
                        implicitHeight: 520
                        border.width: 1
                        border.color: "#e2e8f0"
                        radius: 12
                        color: "#f8fafc"
                    }
                }
            }
        }
    }
}
