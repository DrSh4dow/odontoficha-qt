import QtQuick
import QtQuick.Controls

Item {
    id: root

    width: 400
    height: 400

    Rectangle {
        anchors.fill: parent
        color: "green"

        Label {
            text: "hello"
            anchors.centerIn: parent
        }
    }
}
