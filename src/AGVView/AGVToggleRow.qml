// C:\NestLink\GCS\src\AGVView\AGVToggleRow.qml
import QtQuick

Item {
    property string label: ""

    height: 32

    Text {
        anchors.left:           parent.left
        anchors.verticalCenter: parent.verticalCenter
        text:                   label
        color:                  "#aaaaaa"
        font.pixelSize:         12
    }

    Rectangle {
        id:                     track
        anchors.right:          parent.right
        anchors.verticalCenter: parent.verticalCenter
        width:                  40
        height:                 20
        radius:                 10
        color:                  toggled ? Qt.rgba(1,0.42,0.21,0.5) : Qt.rgba(1,1,1,0.1)

        property bool toggled: false

        Behavior on color { ColorAnimation { duration: 150 } }

        Rectangle {
            id:                     knob
            width:                  16
            height:                 16
            radius:                 8
            x:                      track.toggled ? parent.width - width - 2 : 2
            y:                      2
            color:                  track.toggled ? "#1ff18f" : "#666666" //"#ff6b35"

            Behavior on x     { NumberAnimation { duration: 150; easing.type: Easing.InOutQuad } }
            Behavior on color { ColorAnimation  { duration: 150 } }
        }

        MouseArea {
            anchors.fill:   parent
            cursorShape:    Qt.PointingHandCursor
            onClicked:      track.toggled = !track.toggled
        }
    }
}