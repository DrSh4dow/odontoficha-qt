import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import cl.odontoficha.planaccionsql 1.0
import cl.odontoficha.serviciosql 1.0

Item {
    id: root
    property int cardWidth: 400
    property int pacienteId: 0

    function getPlanes(id) {
        console.log("Updating planes...")
        planModel.getPlanAccion(id)
    }

    Rectangle {
        id: card
        width: cardWidth
        color: "white"
        height: parent.height - 32
        x: 104
        border.color: "#E5E5E5"
        border.width: 1
        radius: 12
        ListView {
            id: rootListView
            clip: true
            anchors.fill: parent
            anchors.margins: 32
            model: PlanAccionModel {
                id: planModel
            }
            headerPositioning: ListView.OverlayHeader
            header: Item {
                width: rootListView.width
                height: 32
                z: 2
                Rectangle {
                    anchors.fill: parent
                    border.width: 1
                    border.color: "#E5E5E5"
                    color: "#d8b4fe"
                    RowLayout {
                        id: headerRowLayout
                        anchors.fill: parent
                        spacing: 6

                        Rectangle {
                            Layout.minimumWidth: 40
                            Layout.preferredWidth: 64
                            Layout.fillWidth: true
                            Label {
                                text: "Numero Plan"
                                font.bold: true
                                font.pixelSize: 12
                                anchors.centerIn: parent
                            }
                        }
                        Rectangle {
                            Layout.minimumWidth: 40
                            Layout.preferredWidth: 64
                            Layout.fillWidth: true
                            Label {
                                text: "Fecha de Creación"
                                font.bold: true
                                font.pixelSize: 12
                                anchors.centerIn: parent
                            }
                        }
                        Rectangle {
                            Layout.minimumWidth: 40
                            Layout.preferredWidth: 64
                            Layout.fillWidth: true
                            Label {
                                text: "Completado"
                                font.bold: true
                                font.pixelSize: 12
                                anchors.centerIn: parent
                            }
                        }

                        Rectangle {
                            color: "transparent"
                            width: 32
                            height: 32
                        }
                    }
                }
            }

            delegate: Rectangle {
                id: rootDelegate
                width: rootListView.width
                height: visibleArea.height + chList.height
                border.width: 1
                border.color: "#E5E5E5"

                property bool collapsedRole: true
                Column {
                    anchors.fill: parent
                    Rectangle {
                        id: visibleArea
                        border.width: 1
                        border.color: "#E5E5E5"

                        height: 32
                        anchors.left: parent.left
                        anchors.right: parent.right
                        RowLayout {
                            anchors.fill: parent
                            spacing: 6

                            Rectangle {
                                Layout.minimumWidth: 40
                                Layout.preferredWidth: 64
                                Layout.fillWidth: true
                                Label {
                                    text: "N°" + model.plan_id
                                    font.pixelSize: 12
                                    anchors.centerIn: parent
                                }
                            }
                            Rectangle {
                                Layout.minimumWidth: 40
                                Layout.preferredWidth: 64
                                Layout.fillWidth: true
                                Label {
                                    property date dateParsed: new Date(model.fecha_creacion)
                                    text: dateParsed.getDate(
                                              ) + "/" + (dateParsed.getMonth(
                                                             ) + 1) + "/" + dateParsed.getFullYear()
                                    font.pixelSize: 12
                                    anchors.centerIn: parent
                                }
                            }
                            Rectangle {
                                Layout.minimumWidth: 40
                                Layout.preferredWidth: 64
                                Layout.fillWidth: true
                                Label {
                                    text: "Falso"
                                    font.pixelSize: 12
                                    anchors.centerIn: parent
                                }
                            }

                            Rectangle {
                                color: "transparent"
                                width: 32
                                height: 32
                                Item {
                                    clip: true
                                    anchors.centerIn: parent
                                    height: 24
                                    width: height
                                    Image {
                                        anchors.fill: parent
                                        id: dotsIcons
                                        source: "qrc:/icons/resources/dots-vertical.svg"
                                    }
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        rootDelegate.collapsedRole = !rootDelegate.collapsedRole
                                    }
                                }
                            }
                        }
                        MouseArea {
                            id: pacienteRowMouseArea
                            anchors.fill: visibleArea
                            hoverEnabled: true
                            acceptedButtons: Qt.LeftButton
                                             | Qt.RightButton // default is Qt.LeftButton only
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
                                text: 'Ver Presupuesto'
                                onClicked: console.log("ver clicked")
                            }
                            MenuItem {
                                text: 'Imprimir Presupuesto'
                                onClicked: console.log("imprimir clicked")
                            }
                        }
                    }
                    ListView {
                        id: chList
                        interactive: false
                        anchors.left: parent.left
                        anchors.right: parent.right
                        model: ServicioModel {
                            plan_id: model.plan_id
                        }

                        height: 24 * chList.count
                        delegate: Item {
                            id: rootChildDelegate
                            width: chList.width
                            height: 24
                            Rectangle {
                                color: "transparent"
                                anchors.fill: parent
                                RowLayout {
                                    anchors.fill: parent
                                    spacing: 6
                                    Rectangle {
                                        Layout.minimumWidth: 64
                                        Layout.preferredWidth: 120
                                        Layout.fillWidth: true
                                        Label {
                                            text: "Prestacion: " + model.prestacion
                                            font.pixelSize: 12
                                            anchors.fill: parent
                                            anchors.margins: 4
                                            horizontalAlignment: Label.AlignJustify
                                            verticalAlignment: Label.AlignVCenter
                                        }
                                    }
                                    Rectangle {
                                        Layout.minimumWidth: 64
                                        Layout.preferredWidth: 80
                                        Layout.fillWidth: true
                                        Label {
                                            text: "Pieza: " + model.pieza
                                            font.pixelSize: 12
                                            anchors.fill: parent
                                            anchors.margins: 4
                                            horizontalAlignment: Label.AlignJustify
                                            verticalAlignment: Label.AlignVCenter
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                state: collapsedRole ? "collapsed" : "null"
                states: [
                    State {
                        name: "collapsed"
                        PropertyChanges {
                            target: chList
                            height: 0
                            opacity: 0
                        }
                        PropertyChanges {
                            target: dotsIcons
                            rotation: -90
                        }
                    }
                ]

                transitions: [
                    Transition {
                        NumberAnimation {
                            target: chList
                            property: "height"
                            duration: 200
                        }
                        NumberAnimation {
                            target: chList
                            property: "opacity"
                            duration: 200
                        }
                        NumberAnimation {
                            target: dotsIcons
                            property: "rotation"
                            duration: 200
                        }
                    }
                ]
            }
        }
    }
}
