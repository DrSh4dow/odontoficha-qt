import QtQuick
import QtQuick.Controls.Material

Item {
    id: root
    anchors.left: parent.left
    anchors.right: parent.right

    height: 48
    Rectangle {
        anchors.fill: parent
        color: "#F4F2FF"
        border.color: "#E5E5E5"
        border.width: 1

        Item {
            id: headerNombre
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            width: 200
            Label {
                color: "#6E6893"
                text: "NOMBRE COMPLETO"
                font.bold: true
                font.pixelSize: 12
                anchors.centerIn: parent
            }
        }

        Item {
            id: headerRut
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: headerNombre.right
            width: 184
            Label {
                color: "#6E6893"
                text: "RUT"
                font.bold: true
                font.pixelSize: 12
                anchors.centerIn: parent
            }
        }
        Item {
            id: headerModificacion
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.right: headerIngreso.left
            width: 120
            Label {
                color: "#6E6893"
                text: "MODIFICACIÓN"
                font.bold: true
                font.pixelSize: 12
                anchors.centerIn: parent
            }
        }
        Item {
            id: headerIngreso
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            width: 120
            Label {
                color: "#6E6893"
                text: "INGRESO"
                font.bold: true
                font.pixelSize: 12
                anchors.centerIn: parent
            }
        }
    }
}
