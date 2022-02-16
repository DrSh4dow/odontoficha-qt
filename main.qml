import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

Window {
    id: root
    minimumWidth: 960
    minimumHeight: 720
    width: 1064
    height: 768
    visible: true
    title: qsTr("Odontoficha")

    property int selectedPatient: 0

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
        PacientesLayout {
            globalX: root.width
            globalY: root.height
            onPacienteSelected: function handler(pagina, id) {
                root.selectedPatient = id
                navigationBar.currentIndex = pagina
            }
        }
        AgendaLayout {}
        RecetasLayout {}
        PresupuestoLayout {}
        ConfiguracionLayout {}
        FichaClinica {
            pacienteId: selectedPatient
            globalX: root.width
            globalY: root.height
        }
    }
}
