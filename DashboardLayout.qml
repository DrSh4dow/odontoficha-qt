import QtQuick
import QtQuick.Controls.Material
import Qt5Compat.GraphicalEffects

Item {
    id: root
    clip: true

    signal indexChanged(int newIndex)

    ScrollView {
        anchors.fill: parent
        contentWidth: availableWidth

        Flow {
            anchors.left: parent.left
            anchors.right: parent.right
            spacing: 40
            topPadding: 120
            bottomPadding: 80
            rightPadding: 40
            leftPadding: 80

            Rectangle {
                width: 280
                height: 256
                radius: 16
                border.width: 1
                border.color: "#E5E5E5"
                color: pacientesCardMouseArea.containsMouse ? "#faf5ff" : "#ffffff"
                Behavior on color {
                    ColorAnimation {
                        duration: 50
                    }
                }

                Column {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 16
                    topPadding: 32
                    height: parent.height

                    Item {

                        width: 88
                        height: 88
                        anchors.horizontalCenter: parent.horizontalCenter
                        Image {
                            id: pacientesImg
                            anchors.fill: parent
                            source: "qrc:/icons/account-multiple.svg"
                            fillMode: Image.PreserveAspectFit
                            sourceSize: Qt.size(
                                            accountsImg.sourceSize.width * 4,
                                            accountsImg.sourceSize.height * 4)
                            Image {
                                id: accountsImg
                                source: parent.source
                                width: 0
                                height: 0
                            }
                        }
                        ColorOverlay {
                            anchors.fill: pacientesImg
                            source: pacientesImg
                            color: "#888888"
                        }
                    }

                    Label {
                        color: "#9E9E9E"
                        font.pixelSize: 24
                        text: "Pacientes"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Label {
                        color: "#d1d5db"
                        text: "Ingresos y Ficha"
                        font.pixelSize: 12
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }

                MouseArea {
                    id: pacientesCardMouseArea
                    anchors.fill: parent
                    hoverEnabled: true

                    onClicked: root.indexChanged(1)
                }
            }
            Rectangle {
                width: 280
                height: 256
                radius: 16
                border.width: 1
                border.color: "#E5E5E5"
                color: agendaCardMouseArea.containsMouse ? "#faf5ff" : "#ffffff"
                Behavior on color {
                    ColorAnimation {
                        duration: 50
                    }
                }

                Column {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 16
                    topPadding: 32
                    height: parent.height

                    Item {

                        width: 88
                        height: 88
                        anchors.horizontalCenter: parent.horizontalCenter
                        Image {
                            id: agendaImg
                            anchors.fill: parent
                            source: "qrc:/icons/calendar-blank.svg"
                            fillMode: Image.PreserveAspectFit
                            sourceSize: Qt.size(
                                            calendarImg.sourceSize.width * 4,
                                            calendarImg.sourceSize.height * 4)
                            Image {
                                id: calendarImg
                                source: parent.source
                                width: 0
                                height: 0
                            }
                        }
                        ColorOverlay {
                            anchors.fill: agendaImg
                            source: agendaImg
                            color: "#888888"
                        }
                    }

                    Label {
                        color: "#9E9E9E"
                        font.pixelSize: 24
                        text: "Agenda"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Label {
                        color: "#d1d5db"
                        text: "Calendario"
                        font.pixelSize: 12
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }

                MouseArea {
                    id: agendaCardMouseArea
                    anchors.fill: parent
                    hoverEnabled: true

                    onClicked: root.indexChanged(2)
                }
            }

            Rectangle {
                width: 280
                height: 256
                radius: 16
                border.width: 1
                border.color: "#E5E5E5"
                color: recetasCardMouseArea.containsMouse ? "#faf5ff" : "#ffffff"
                Behavior on color {
                    ColorAnimation {
                        duration: 50
                    }
                }

                Column {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 16
                    topPadding: 32
                    height: parent.height

                    Item {

                        width: 88
                        height: 88
                        anchors.horizontalCenter: parent.horizontalCenter
                        Image {
                            id: recetasImg
                            anchors.fill: parent
                            source: "qrc:/icons/clipboard-text.svg"
                            fillMode: Image.PreserveAspectFit
                            sourceSize: Qt.size(
                                            clipboardImg.sourceSize.width * 4,
                                            clipboardImg.sourceSize.height * 4)
                            Image {
                                id: clipboardImg
                                source: parent.source
                                width: 0
                                height: 0
                            }
                        }
                        ColorOverlay {
                            anchors.fill: recetasImg
                            source: recetasImg
                            color: "#888888"
                        }
                    }

                    Label {
                        color: "#9E9E9E"
                        font.pixelSize: 24
                        text: "Recetas"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Label {
                        color: "#d1d5db"
                        text: "Generación de Recetas"
                        font.pixelSize: 12
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }

                MouseArea {
                    id: recetasCardMouseArea
                    anchors.fill: parent
                    hoverEnabled: true

                    onClicked: root.indexChanged(3)
                }
            }
            Rectangle {
                width: 280
                height: 256
                radius: 16
                border.width: 1
                border.color: "#E5E5E5"
                color: presupuestoCardMouseArea.containsMouse ? "#faf5ff" : "#ffffff"
                Behavior on color {
                    ColorAnimation {
                        duration: 50
                    }
                }

                Column {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 16
                    topPadding: 32
                    height: parent.height

                    Item {

                        width: 88
                        height: 88
                        anchors.horizontalCenter: parent.horizontalCenter
                        Image {
                            id: presupuestoImg
                            anchors.fill: parent
                            source: "qrc:/icons/file-document-multiple.svg"
                            fillMode: Image.PreserveAspectFit
                            sourceSize: Qt.size(fileImg.sourceSize.width * 4,
                                                fileImg.sourceSize.height * 4)
                            Image {
                                id: fileImg
                                source: parent.source
                                width: 0
                                height: 0
                            }
                        }
                        ColorOverlay {
                            anchors.fill: presupuestoImg
                            source: presupuestoImg
                            color: "#888888"
                        }
                    }

                    Label {
                        color: "#9E9E9E"
                        font.pixelSize: 24
                        text: "Presupuesto"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Label {
                        color: "#d1d5db"
                        text: "Generación de Prespuestos"
                        font.pixelSize: 12
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }

                MouseArea {
                    id: presupuestoCardMouseArea
                    anchors.fill: parent
                    hoverEnabled: true

                    onClicked: root.indexChanged(4)
                }
            }
        }
    }
}
