import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

ApplicationWindow {
    id: root
    minimumWidth: 960
    minimumHeight: 720
    width: 1064
    height: 768
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
        PacientesLayout {
            globalX: root.width
            globalY: root.height
            onPacienteSelected: function handler(pagina, id) {
                //                console.log("paciente id: " + id)
                if (id < 1)
                    return
                switch (pagina) {
                case 3:
                    recetaLayout.pacienteId = id
                    break
                case 4:
                    presupuestoLayouot.pacienteId = id
                    break
                case 6:

                    fichaClinica.pacienteId = id
                    fichaClinica.getFichas(id)
                    fichaClinica.getPlanes(id)
                    break
                default:
                    console.log("invalid page")
                    return
                }
                navigationBar.currentIndex = pagina
            }
        }
        AgendaLayout {}
        RecetasLayout {
            id: recetaLayout
        }
        PresupuestoLayout {
            id: presupuestoLayouot
        }
        ConfiguracionLayout {}
        FichaClinica {
            id: fichaClinica
            globalX: root.width
            globalY: root.height
        }
    }
}
