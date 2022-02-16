import QtQuick
import QtQuick.Controls

Item {
    id: root

    property int cardWidth: 400

    ScrollView {
        anchors.fill: parent

        ListView {
            id: listView
            anchors.fill: parent
            clip: true
            model: 10
            delegate: Item {
                width: listView.width

                height: 592
                Label {
                    text: "23/11/2021"
                    font.pixelSize: 10
                    x: 40
                    y: 16
                    color: "#9ca3af"
                }

                Rectangle {
                    height: 1
                    x: 114
                    y: 24
                    width: cardWidth - 20
                    color: "#C4C4C4"
                }

                Rectangle {
                    width: cardWidth
                    color: "white"
                    x: 104
                    y: 40
                    height: 560
                    border.color: "#E5E5E5"
                    border.width: 1
                    radius: 12
                    TextArea {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        padding: 8
                        wrapMode: TextArea.WordWrap
                        selectByMouse: true
                        text: "some random\nshit"
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
}
