import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

Window {
    id: root
    minimumWidth: 800
    minimumHeight: 640
    visible: true
    title: qsTr("Hello World")

    Rectangle {
        color: "#FBFCFD"
        anchors.fill: parent
        z: -10
    }

    NavBar {
        id: navigationBar
    }

    StackLayout {
        id: layout
        anchors.fill: parent
        anchors.leftMargin: navigationBar.width
        currentIndex: navigationBar.currentIndex
        Rectangle {
            color: 'white'
            implicitWidth: 200
            implicitHeight: 200
        }
        Rectangle {
            color: 'plum'
            implicitWidth: 300
            implicitHeight: 200
        }
    }
}
