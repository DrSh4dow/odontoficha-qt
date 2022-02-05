import QtQuick
import QtQuick.Controls.Material
import Qt5Compat.GraphicalEffects

Item {
    id: root
    clip: true

    signal pacienteSelected(int pagina, string id)

    Column {
        anchors.fill: parent
        topPadding: 64
        leftPadding: 40
        spacing: 16

        Label {
            text: "Pacientes"
            font.pixelSize: 48
        }

        Rectangle {
            id: card
            anchors.left: parent.left
            anchors.leftMargin: 40
            anchors.rightMargin: 40
            anchors.right: parent.right
            height: 560
            border.color: "#E5E5E5"
            border.width: 1
            radius: 12

            Column {
                anchors.fill: parent

                Item {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: 64

                    TextField {
                        placeholderText: "Buscar por Nombre o RUT"
                        height: 40
                        width: 264
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 24
                    }

                    Button {
                        text: "Crear Paciente"
                        anchors.right: parent.right
                        anchors.rightMargin: 24
                        anchors.verticalCenter: parent.verticalCenter
                        topPadding: 16
                        bottomPadding: 16
                        width: 160
                    }
                }

                PacientesHeader {
                    id: pacientesHeader
                }
                Item {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: 400
                    ListView {
                        anchors.fill: parent
                        clip: true
                        model: 100
                        delegate: PacienteRow {
                            onPacienteSelected: function handler(pag, ident) {
                                root.pacienteSelected(pag, ident)
                            }
                        }
                    }
                }

                Rectangle {
                    color: "#F4F2FF"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: 48
                    border.width: 1
                    border.color: "#E5E5E5"
                }
            }
        }
    }
}
