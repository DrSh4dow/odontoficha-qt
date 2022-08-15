import QtQuick
import QtQuick.Controls.Material

Item {
    id: root

    property string nombres: "Juan Alejandro"
    property string apellidos: "Perez Pereira"
    property string rut: "123456789"
    property string modificacion: "12-09-22"
    property string ingreso: "25-07-22"
    property int pacienteId: 0
    property string formatedDateIngreso: ingreso.split(" ")[0].split(
                                             "-")[2] + "/" + ingreso.split(
                                             " ")[0].split(
                                             "-")[1] + "/" + ingreso.split(
                                             " ")[0].split("-")[0]
    property string formatedDateModificacion: modificacion.split(" ")[0].split(
                                                  "-")[2] + "/" + modificacion.split(
                                                  " ")[0].split(
                                                  "-")[1] + "/" + modificacion.split(
                                                  " ")[0].split("-")[0]

    property string formatedRut: [rut.slice(0, -7), '.', rut.slice(
            -7, -4), '.', rut.slice(-4, -1), '-', rut.slice(-1)].join('')

    width: ListView.view.width
    //        anchors.left: parent.left
    //        anchors.right: parent.right
    height: 56

    signal pacienteSelected(int pagina, string id)

    Rectangle {
        anchors.fill: parent
        border.width: 1
        border.color: "#E5E5E5"
        color: pacienteRowMouseArea.containsMouse ? "#faf5ff" : "#FFFFFF"
        Behavior on color {
            ColorAnimation {
                duration: 50
            }
        }
        Item {
            id: nombreItem
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            width: 200
            Label {
                color: "#1f2937"
                text: nombres + " " + apellidos
                font.pixelSize: 12
                anchors.centerIn: parent
                wrapMode: Label.WordWrap
                width: parent.width
                padding: 8
                horizontalAlignment: Label.AlignHCenter
            }
        }
        Item {
            id: rutItem
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: nombreItem.right
            width: 184
            Label {
                color: "#1f2937"
                text: formatedRut
                font.pixelSize: 12
                anchors.centerIn: parent
                wrapMode: Label.WordWrap
                width: parent.width
                padding: 8
                horizontalAlignment: Label.AlignHCenter
            }
        }
        Item {
            id: modificacionItem
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.right: ingresoItem.left
            width: 120
            Label {
                color: "#1f2937"
                text: formatedDateModificacion
                font.pixelSize: 12
                anchors.centerIn: parent
                wrapMode: Label.WordWrap
                width: parent.width
                padding: 8
                horizontalAlignment: Label.AlignHCenter
            }
        }
        Item {
            id: ingresoItem
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            width: 120
            Label {
                color: "#1f2937"
                text: formatedDateIngreso
                font.pixelSize: 12
                anchors.centerIn: parent
                wrapMode: Label.WordWrap
                width: parent.width
                padding: 8
                horizontalAlignment: Label.AlignHCenter
            }
        }
    }
    MouseArea {
        id: pacienteRowMouseArea
        anchors.fill: root
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton | Qt.RightButton // default is Qt.LeftButton only
        onClicked: function handler(mouse) {
            if (mouse.button === Qt.RightButton) {
                contextMenu.x = mouse.x
                contextMenu.y = mouse.y
                contextMenu.open()
            }
        }
    }

    Menu {
        id: contextMenu
        MenuItem {
            text: 'Ver Ficha Clinica'
            onClicked: root.pacienteSelected(6, pacienteId)
        }
        MenuItem {
            text: 'Crear Receta'
            onClicked: root.pacienteSelected(3, pacienteId)
        }
        MenuItem {
            text: 'Crear Presupuesto'
            onClicked: root.pacienteSelected(4, pacienteId)
        }
        MenuItem {
            text: 'Agendar Hora'
            onClicked: root.pacienteSelected(2, pacienteId)
        }
    }
}
