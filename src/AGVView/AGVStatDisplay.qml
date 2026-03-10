// C:\NestLink\GCS\src\AGVView\AGVStatDisplay.qml
import QtQuick

Rectangle {
    property string label: ""
    property string value: ""

    height:       35
    radius:       8
    color:        Qt.rgba(255,255,255,0.03)
    border.color: Qt.rgba(255,255,255,0.08)
    border.width: 1

    Text {
        anchors.left:           parent.left
        anchors.leftMargin:     14
        anchors.verticalCenter: parent.verticalCenter
        text:           label
        color:          Qt.rgba(255,255,255,0.5)
        font.pixelSize: 12
    }

    Text {
        anchors.right:          parent.right
        anchors.rightMargin:    14
        anchors.verticalCenter: parent.verticalCenter
        text:           value
        color:          "#1ff18f"
        font.pixelSize: 15
        font.weight:    Font.Bold
        font.family:    "Courier New"
    }
}
