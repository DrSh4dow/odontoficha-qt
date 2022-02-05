import QtQuick
import QtQuick.Controls.Material

Item {
    id: root

    property string nombres: "Juan Alejandro"
    property string apellidos: "Perez Pereira"
    property string rut: "12.345.678-9"
    property string modificacion: "12-09-22"
    property string ingreso: "25-07-22"
    property string pacienteId: "132ef5421"

    anchors.left: parent.left
    anchors.right: parent.right
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
            width: 184
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
                text: rut
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
                text: modificacion
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
                text: ingreso
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