import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

Item {
    id: root
    anchors.left: parent.left
    anchors.bottom: parent.bottom
    anchors.top: parent.top
    width: 240

    property int currentIndex: 0

    Rectangle {
        anchors.fill: parent
        color: "white"
        Rectangle {
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: 1
            color: "#E5E5E5"
        }

        Column {
            anchors.fill: parent
            spacing: 14
            Item {
                id: header
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 16
                height: 144

                Row {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: 40
                    y: 8
                    spacing: 8
                    Rectangle {
                        width: 12
                        height: 12
                        radius: width
                        color: utilityObject.isDatabaseOpen ? "#22c55e" : "#ef4444"
                    }

                    Label {
                        color: "#111827"
                        text: utilityObject.isDatabaseOpen ? "Conectado" : "Desconectado"
                        font.pixelSize: 10
                    }
                }

                Column {
                    anchors.fill: parent
                    topPadding: 40
                    spacing: 16

                    Item {

                        height: 56
                        width: height
                        Rectangle {
                            id: mask
                            height: 56
                            width: height
                            radius: height / 2
                            visible: false
                        }
                        Image {
                            id: avatar
                            anchors.fill: parent
                            fillMode: Image.PreserveAspectCrop
                            horizontalAlignment: Image.AlignLeft
                            source: "qrc:/images/resources/exampleavatar.jpeg"
                            layer.enabled: true
                            layer.effect: OpacityMask {
                                maskSource: mask
                            }
                        }
                    }

                    Label {
                        color: "#111827"
                        text: "Belen Chacón"
                        font.bold: true
                        font.pixelSize: 20
                    }
                }
            }
            Rectangle {
                color: "#E5E5E5"
                height: 2
                anchors.left: parent.left
                anchors.right: parent.right
            }

            Item {
                id: mainMenu
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 8
                anchors.rightMargin: 8
                height: 228

                Column {
                    anchors.fill: parent
                    spacing: 8

                    Rectangle {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        color: currentIndex === 0 ? "#f3e8ff" : inicioMouseArea.containsMouse ? "#FAF5FF" : "#FFFFFF"
                        radius: 4
                        height: 40
                        Behavior on color {
                            ColorAnimation {
                                duration: 50
                            }
                        }

                        Row {
                            spacing: 24
                            anchors.fill: parent
                            anchors.leftMargin: 8
                            topPadding: 8

                            Item {
                                clip: true
                                height: 24
                                width: height
                                Image {
                                    id: dashboardIcon
                                    anchors.fill: parent
                                    source: "qrc:/icons/resources/view-dashboard.svg"
                                }
                                ColorOverlay {
                                    anchors.fill: dashboardIcon
                                    source: dashboardIcon
                                    color: currentIndex === 0 ? "#D8B4FE" : "#666666"
                                }
                            }

                            Label {
                                color: currentIndex === 0 ? "#D8B4FE" : "#1F2937"
                                anchors.verticalCenter: parent.verticalCenter
                                text: "Inicio"
                                font.pixelSize: 14
                                font.bold: true
                            }
                        }

                        MouseArea {
                            id: inicioMouseArea
                            hoverEnabled: true
                            anchors.fill: parent
                            onClicked: currentIndex = 0
                        }
                    }
                    Rectangle {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        color: currentIndex === 1 ? "#f3e8ff" : pacientesMouseArea.containsMouse ? "#FAF5FF" : "#FFFFFF"
                        radius: 4
                        height: 40
                        Behavior on color {
                            ColorAnimation {
                                duration: 50
                            }
                        }

                        Row {
                            spacing: 24
                            anchors.fill: parent
                            anchors.leftMargin: 8
                            topPadding: 8

                            Item {
                                clip: true
                                height: 24
                                width: height
                                Image {
                                    id: peopleIcon
                                    anchors.fill: parent
                                    source: "qrc:/icons/resources/account-multiple.svg"
                                }
                                ColorOverlay {
                                    anchors.fill: peopleIcon
                                    source: peopleIcon
                                    color: currentIndex === 1 ? "#D8B4FE" : "#666666"
                                }
                            }

                            Label {
                                color: currentIndex === 1 ? "#D8B4FE" : "#1F2937"
                                anchors.verticalCenter: parent.verticalCenter
                                text: "Pacientes"
                                font.pixelSize: 14
                                font.bold: true
                            }
                        }

                        MouseArea {
                            id: pacientesMouseArea
                            hoverEnabled: true
                            anchors.fill: parent
                            onClicked: currentIndex = 1
                        }
                    }
                    Rectangle {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        color: currentIndex === 2 ? "#f3e8ff" : agendaMouseArea.containsMouse ? "#FAF5FF" : "#FFFFFF"
                        radius: 4
                        height: 40
                        Behavior on color {
                            ColorAnimation {
                                duration: 50
                            }
                        }

                        Row {
                            spacing: 24
                            anchors.fill: parent
                            anchors.leftMargin: 8
                            topPadding: 8

                            Item {
                                clip: true
                                height: 24
                                width: height
                                Image {
                                    id: agendaIcon
                                    anchors.fill: parent
                                    source: "qrc:/icons/resources/calendar-blank.svg"
                                }
                                ColorOverlay {
                                    anchors.fill: agendaIcon
                                    source: agendaIcon
                                    color: currentIndex === 2 ? "#D8B4FE" : "#666666"
                                }
                            }

                            Label {
                                color: currentIndex === 2 ? "#D8B4FE" : "#1F2937"
                                anchors.verticalCenter: parent.verticalCenter
                                text: "Agenda"
                                font.pixelSize: 14
                                font.bold: true
                            }
                        }

                        MouseArea {
                            id: agendaMouseArea
                            hoverEnabled: true
                            anchors.fill: parent
                            onClicked: currentIndex = 2
                        }
                    }
                    Rectangle {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        color: currentIndex === 3 ? "#f3e8ff" : recetaMouseArea.containsMouse ? "#FAF5FF" : "#FFFFFF"
                        radius: 4
                        height: 40
                        Behavior on color {
                            ColorAnimation {
                                duration: 50
                            }
                        }

                        Row {
                            spacing: 24
                            anchors.fill: parent
                            anchors.leftMargin: 8
                            topPadding: 8

                            Item {
                                clip: true
                                height: 24
                                width: height
                                Image {
                                    id: recetaIcon
                                    anchors.fill: parent
                                    source: "qrc:/icons/resources/clipboard-text.svg"
                                }
                                ColorOverlay {
                                    anchors.fill: recetaIcon
                                    source: recetaIcon
                                    color: currentIndex === 3 ? "#D8B4FE" : "#666666"
                                }
                            }

                            Label {
                                color: currentIndex === 3 ? "#D8B4FE" : "#1F2937"
                                anchors.verticalCenter: parent.verticalCenter
                                text: "Recetas"
                                font.pixelSize: 14
                                font.bold: true
                            }
                        }

                        MouseArea {
                            id: recetaMouseArea
                            hoverEnabled: true
                            anchors.fill: parent
                            onClicked: currentIndex = 3
                        }
                    }
                    Rectangle {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        color: currentIndex === 4 ? "#f3e8ff" : presupuestoMouseArea.containsMouse ? "#FAF5FF" : "#FFFFFF"
                        radius: 4
                        height: 40
                        Behavior on color {
                            ColorAnimation {
                                duration: 50
                            }
                        }

                        Row {
                            spacing: 24
                            anchors.fill: parent
                            anchors.leftMargin: 8
                            topPadding: 8

                            Item {
                                clip: true
                                height: 24
                                width: height
                                Image {
                                    id: presupuestoIcon
                                    anchors.fill: parent
                                    source: "qrc:/icons/resources/file-document-multiple.svg"
                                }
                                ColorOverlay {
                                    anchors.fill: presupuestoIcon
                                    source: presupuestoIcon
                                    color: currentIndex === 4 ? "#D8B4FE" : "#666666"
                                }
                            }

                            Label {
                                color: currentIndex === 4 ? "#D8B4FE" : "#1F2937"
                                anchors.verticalCenter: parent.verticalCenter
                                text: "Presupuesto"
                                font.pixelSize: 14
                                font.bold: true
                            }
                        }

                        MouseArea {
                            id: presupuestoMouseArea
                            hoverEnabled: true
                            anchors.fill: parent
                            onClicked: currentIndex = 4
                        }
                    }
                }
            }
            Rectangle {
                color: "#E5E5E5"
                height: 2
                anchors.left: parent.left
                anchors.right: parent.right
            }

            Item {
                id: settingsMenu
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 8
                anchors.rightMargin: 8
                height: 228

                Column {
                    anchors.fill: parent
                    spacing: 8

                    Rectangle {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        color: currentIndex === 5 ? "#f3e8ff" : configuracionMouseArea.containsMouse ? "#FAF5FF" : "#FFFFFF"
                        radius: 4
                        height: 40
                        Behavior on color {
                            ColorAnimation {
                                duration: 50
                            }
                        }

                        Row {
                            spacing: 24
                            anchors.fill: parent
                            anchors.leftMargin: 8
                            topPadding: 8

                            Item {
                                clip: true
                                height: 24
                                width: height
                                Image {
                                    id: cogIcon
                                    anchors.fill: parent
                                    source: "qrc:/icons/resources/cog.svg"
                                }
                                ColorOverlay {
                                    anchors.fill: cogIcon
                                    source: cogIcon
                                    color: currentIndex === 5 ? "#D8B4FE" : "#666666"
                                }
                            }

                            Label {
                                color: currentIndex === 5 ? "#D8B4FE" : "#1F2937"
                                anchors.verticalCenter: parent.verticalCenter
                                text: "Configuración"
                                font.pixelSize: 14
                                font.bold: true
                            }
                        }

                        MouseArea {
                            id: configuracionMouseArea
                            hoverEnabled: true
                            anchors.fill: parent
                            onClicked: currentIndex = 5
                        }
                    }
                }
            }
        }
        Rectangle {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.leftMargin: 8
            anchors.rightMargin: 8
            anchors.bottomMargin: 8
            color: exitMouseArea.containsMouse ? "#FAF5FF" : "#FFFFFF"
            radius: 4
            height: 40
            Behavior on color {
                ColorAnimation {
                    duration: 50
                }
            }

            Row {
                spacing: 24
                anchors.fill: parent
                anchors.leftMargin: 8
                topPadding: 8

                Item {
                    clip: true
                    height: 24
                    width: height
                    Image {
                        id: exitIcon
                        anchors.fill: parent
                        source: "qrc:/icons/resources/exit-to-app.svg"
                    }
                    ColorOverlay {
                        anchors.fill: exitIcon
                        source: exitIcon
                        color: "#666666"
                    }
                }

                Label {
                    color: "#1F2937"
                    anchors.verticalCenter: parent.verticalCenter
                    text: "Cerrar Sesión"
                    font.pixelSize: 14
                    font.bold: true
                }
            }

            MouseArea {
                id: exitMouseArea
                hoverEnabled: true
                anchors.fill: parent
                onClicked: console.log("Sesion cerrada")
            }
        }
    }
}
