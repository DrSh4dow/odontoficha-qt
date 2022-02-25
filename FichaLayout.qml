import QtQuick
import QtQuick.Controls
import cl.odontoficha.fichasql 1.0

Item {
    id: root

    property int cardWidth: 400
    property int pacienteId: 0

    signal isFinish(bool isIt)

    function getFichas(id) {
        console.log("updating fichas...")
        fichaModel.getFichas(id)
    }

    function addFicha(content, pId, uId) {
        console.log("iniciando interface con C++")

        let isAdded = fichaModel.addFicha(content, pId, uId)
        if (isAdded) {
            console.log("ficha agregada con exito!")
            root.isFinish(isAdded)
        } else {
            console.log("[ ERROR ] ocurrio un error al agregar la ficha")
            root.isFinish(isAdded)
        }
    }

    ScrollView {
        anchors.fill: parent

        ListView {
            id: listView
            anchors.fill: parent
            clip: true
            model: FichaModel {
                id: fichaModel
            }
            delegate: Item {
                width: listView.width

                property string baseDate: model.fecha_creacion
                property string formatedDate: baseDate.split("T")[0].split(
                                                  "-")[2] + "/" + baseDate.split(
                                                  "T")[0].split(
                                                  "-")[1] + "/" + baseDate.split(
                                                  "T")[0].split("-")[0]

                height: 592
                Label {
                    text: formatedDate

                    font.pixelSize: 10
                    x: 40
                    y: 16
                    color: "#9ca3af"
                }

                Rectangle {
                    height: 1
                    x: 114
                    y: 24
                    width: cardWidth - 20
                    color: "#C4C4C4"
                }

                Rectangle {
                    width: cardWidth
                    color: "white"
                    x: 104
                    y: 40
                    height: 560
                    border.color: "#E5E5E5"
                    border.width: 1
                    radius: 12
                    TextArea {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        padding: 8
                        wrapMode: TextArea.Wrap
                        width: cardWidth - 32
                        selectByMouse: true
                        text: model.contenido
                        clip: true
                        readOnly: true

                        background: Rectangle {
                            implicitWidth: cardWidth - 32
                            implicitHeight: 520
                            border.width: 1
                            border.color: "#e2e8f0"
                            radius: 12
                            color: "#f8fafc"
                        }
                    }
                }
            }
        }
    }
}
