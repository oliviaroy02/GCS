//C:\NestLink\GCS\src\AGVView\AGVActionButton.qml
import QtQuick

Rectangle {
    property string label: ""

    height:         32
    radius:         4
    color:          btnMouse.pressed      ? Qt.rgba(1,0.42,0.21,0.15) :
                    btnMouse.containsMouse ? Qt.rgba(1,1,1,0.05) : "transparent"
    border.color:   btnMouse.containsMouse ? Qt.rgba(1,0.42,0.21,0.4) : Qt.rgba(1,1,1,0.08)
    border.width:   1

    Behavior on color        { ColorAnimation { duration: 80 } }
    Behavior on border.color { ColorAnimation { duration: 80 } }

    Text {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left:           parent.left
        anchors.leftMargin:     12
        text:                   label
        color:                  btnMouse.containsMouse ? "#1ff18f" : "#888888" //"#ff6b35"
        font.pixelSize:         12

        Behavior on color { ColorAnimation { duration: 80 } }
    }

    Text {
        anchors.right:          parent.right
        anchors.rightMargin:    12
        anchors.verticalCenter: parent.verticalCenter
        text:                   "›"
        color:                  "#1ff18f" //"#ff6b35"
        font.pixelSize:         16
        visible:                btnMouse.containsMouse
    }

    MouseArea {
        id:             btnMouse
        anchors.fill:   parent
        hoverEnabled:   true
        cursorShape:    Qt.PointingHandCursor
        onClicked:      console.log(label, "clicked")
    }
}