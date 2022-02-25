import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.12


Window {
    id: root
    visible: true
    x: (Screen.width / 2) - (width / 2)
    y: (Screen.height / 2) - (height / 2)
    width: 998
    height: 460
    title: qsTr("Terminal Welcome Mini Studio")
    flags: Qt.FramelessWindowHint
    color: "transparent"

    property string rasterizer_image: ""
    property string code: "#"
    property int checkBox: 0
    property string sh: ""

    MouseArea {
        anchors.fill: parent
        property bool isPressed: false
        property int startx: 0
        property int starty: 0
        onPressed: {
            startx = mouseX
            starty = mouseY
            isPressed = true
        }
        onReleased: {
            startx = 0
            starty = 0
            isPressed = false
        }
        onMouseXChanged: {
            if (isPressed)
                root.x = context.cursorX() - startx
        }
        onMouseYChanged: {
            if (isPressed)
                root.y = context.cursorY() - starty
        }
    }

    Rectangle {
        id: bg
        anchors.fill: parent
        anchors.margins: radius
        radius: 4
        color: "#fff"
        Item {
            anchors.fill: parent
            Content { id: content }
            CloseBtn { }
        }

        layer.smooth: true
        layer.enabled: true
        layer.effect: DropShadow {
            color: "grey"
            transparentBorder: true
            horizontalOffset: 0
            verticalOffset: 2
            radius: 4
            samples: 9
        }
    }

    onRasterizer_imageChanged: {
        if (rasterizer_image) {
            const result = context.rasterizer(checkBox, code, rasterizer_image)
            if (result.length > 0) {
                content.textArea.text = result[0]
                sh = result[1]
            }
        }
    }

    Component.onCompleted: {
        x = (Screen.width / 2) - (width / 2)
        y = (Screen.height / 2) - (height / 2)
    }
}
