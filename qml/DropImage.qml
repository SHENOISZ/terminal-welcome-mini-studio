import QtQuick 2.0

Item {
    anchors.fill: parent
    signal hide

    Image {
        id: img
        x: (parent.width / 2) - (width / 2)
        y: (parent.height / 3) - (height / 3)
        width: parent.width / 4
        height: parent.height / 3
        visible: true
        antialiasing: true
        smooth: true
        source: "file:///home/shenoisz/myprojects/sources/QT-PROJECTS/terminal-welcome-studio/images/images2.svg"
        DropArea {
            id: dropArea
            anchors.fill: parent
            onDropped: {
                if (drop.hasUrls) {
                    img.source = drop.urls[0]
                    btn.color = "#07ffff"
                    btn.btnText.color = "#fff"
                    btn.btnText.text = qsTr("Rasterizar Imagem")
                }
            }
        }
    }

    Rectangle {
        id: btn
        y: img.y + img.height + 40
        x: (parent.width / 2) - (width / 2)
        width: 220
        height: 40
        color: "transparent"
        radius: 4
        border {
            color: "#07ffff"
            width: 1
        }

        property alias btnText: btnText
        property alias mouse: mouse

        Text {
            id: btnText
            anchors.centerIn: parent
            text: qsTr("Cancelar")
            color: "#666"
            font {
                pixelSize: 14
                bold: true
            }
        }
        MouseArea {
            id: mouse
            anchors.fill: parent
            hoverEnabled: true
            onHoveredChanged: {
                cursorShape = Qt.PointingHandCursor
            }
            onExited: {
                cursorShape = Qt.ArrowCursor
            }
            onClicked: {
                hide.call()

                if (btn.btnText.text === qsTr("Cancelar")) {
                    root.rasterizer_image = ""
                } else {
                    root.rasterizer_image = img.source
                }

                img.source = "file:///home/shenoisz/myprojects/sources/QT-PROJECTS/terminal-welcome-studio/images/images2.svg"
                btn.btnText.text = qsTr("Cancelar")
            }
        }
    }
}
