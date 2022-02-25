import QtQuick 2.12
import QtQuick.Controls 2.12


Label {
    text: "x"
    anchors.top: parent.top
    anchors.topMargin: 2
    anchors.right: parent.right
    anchors.rightMargin: 6
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    width: 12
    height: 12
    color: "#666"
    font.pixelSize: 14
    font.bold: true
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
            root.close()
        }
    }
}
