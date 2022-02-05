import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

Window {
    id: root
    minimumWidth: 800
    minimumHeight: 640
    width: 960
    height: 760
    visible: true
    title: qsTr("Odontoficha")

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

        DashboardLayout {
            onIndexChanged: newIndex => navigationBar.currentIndex = newIndex
        }
        PacientesLayout {}
        AgendaLayout {}
        RecetasLayout {}
        PresupuestoLayout {}
        ConfiguracionLayout {}
    }
}
