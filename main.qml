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

    property string selectedPatient: ""

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
        }
    }
}
