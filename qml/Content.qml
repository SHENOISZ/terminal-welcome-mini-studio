import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
    anchors.fill: parent
    property alias textArea: textArea
    property alias textInput: textInput.text

    Rectangle {
        id: btnRestarizer
        x: 18
        y: 18 + 22
        width: 200
        height: 40
        color: "transparent"
        border {
            width: 1
            color: "#07ffff"
        }
        Label {
            y: -22
            x: 0
            text: qsTr("Rasterizar Imagem:")
            font.bold: true
        }
        Text {
            anchors.centerIn: parent
            text: qsTr("Rasterizar")
            color: "#333"
        }
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onHoveredChanged: {
                cursorShape = Qt.PointingHandCursor
            }
            onExited: {
                cursorShape = Qt.ArrowCursor
            }
            onClicked: {
                dropArea.visible = true
                textInput.textCheck()
                textArea.visible = false
                root.code = textInput.text
            }
        }
    }

    Rectangle {
        id: horizontalBar
        x: 18
        y: btnRestarizer.y + btnRestarizer.height + 32
        width: btnRestarizer.width
        height: 1
        color: "#ccc"
    }

    Item {
        id: bgCheckBox
        x: 18
        y: horizontalBar.y + horizontalBar.height + 58
        Label {
            y: -22
            x: 0
            text: qsTr("Adicionar Cor de Fundo:")
            font.bold: true
        }
        CheckBox {
            id: check
            y: -4
            x: -8
        }
    }

    Rectangle {
        id: restarizerField
        x: 18
        y: bgCheckBox.y + bgCheckBox.height + 68
        width: btnRestarizer.width
        height: btnRestarizer.height
        color: "#333"
        Label {
            y: -22
            x: 0
            text: qsTr("Texto do Rasteio:")
            font.bold: true
        }
        TextInput {
            id: textInput
            anchors.centerIn: parent
            text: "#"
            color: "#fff"
            font.pixelSize: 18
            onTextEdited: {
                const len = text.length
                if (len > 1)
                    text = text[0]
            }
            function textCheck() {
                const len = text.length
                if (len < 1)
                    text = "#"
            }
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                textInput.focus = true
            }
        }
    }

    Rectangle {
        id: applyCode
        x: 18
        y: restarizerField.y + restarizerField.height + 12
        width: btnRestarizer.width
        height: 40
        color: "transparent"
        border {
            width: 1
            color: "#07ffff"
        }
        Text {
            anchors.centerIn: parent
            text: qsTr("Aplicar Mudanças")
            color: "#333"
        }
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onHoveredChanged: {
                cursorShape = Qt.PointingHandCursor
            }
            onExited: {
                cursorShape = Qt.ArrowCursor
            }
            onClicked: {
                textInput.textCheck()
                root.checkBox = check.checked ? 1 : 0
                root.code = textInput.text
                const tmp = root.rasterizer_image
                root.rasterizer_image = ""
                root.rasterizer_image = tmp
            }
        }
    }

    Rectangle {
        x: 18
        y: applyCode.y + applyCode.height + 60
        width: btnRestarizer.width
        height: 40
        color: "transparent"
        border {
            width: 1
            color: "#07ffff"
        }
        Text {
            anchors.centerIn: parent
            text: qsTr("Salvar Welcome.sh")
            color: "#333"
        }
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onHoveredChanged: {
                cursorShape = Qt.PointingHandCursor
            }
            onExited: {
                cursorShape = Qt.ArrowCursor
            }
            onClicked: {
                context.savesh(root.sh)
            }
        }
    }

    Rectangle {
        anchors.top: parent.top
        anchors.topMargin: 32
        anchors.right: parent.right
        anchors.rightMargin: 18
        width: 740
        height: 400
        color: "#333"
        border {
            width: 1
            color: "#ccc"
        }
        Label {
            y: -16
            x: 0
            text: qsTr("Visualizar:")
            font.bold: true
        }
        TextArea {
            id: textArea
            anchors.fill: parent
            text: ""
            color: "#fff"
            selectByMouse: true
            selectionColor: "#fff"
            selectedTextColor: "#333"
            textFormat: Text.RichText
            wrapMode: TextArea.WrapAnywhere
            font.family: "DejaVu Sans Mono"
            font.pixelSize: 9
            readOnly: true
        }
    }

    Rectangle {
        id: dropArea
        anchors.fill: parent
        color: "#fff"
        visible: false
        radius: 4
        DropImage {
            id: dropImage
            onHide: {
                textArea.visible = true
                dropArea.visible = false
            }
        }
    }
}
