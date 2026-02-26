// C:\NestLink\GCS\src\AGVView\AGVPanelSelection.qml
import QtQuick

Column {
    property string label:   ""
    property string accent:  "#1ff18f" //"#ff6b35"
    property var    options: []

    spacing: 6

    AGVSectionHeader { width: parent.width; label: parent.label; accent: parent.accent }

    Repeater {
        model: options

        delegate: Rectangle {
            width:  parent.width
            height: 30
            radius: 4
            color:  itemMouse.pressed    ? Qt.rgba(1,0.42,0.21,0.2) :
                    itemMouse.containsMouse ? Qt.rgba(1,1,1,0.04) : "transparent"

            Behavior on color { ColorAnimation { duration: 80 } }

            property bool selected: false

            Row {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left:           parent.left
                anchors.leftMargin:     8
                spacing:                10

                // Selection indicator
                Rectangle {
                    width:                  6
                    height:                 6
                    radius:                 3
                    anchors.verticalCenter: parent.verticalCenter
                    color:                  parent.parent.selected ? accent : Qt.rgba(1,1,1,0.2)

                    Behavior on color { ColorAnimation { duration: 150 } }
                }

                Text {
                    text:           modelData
                    color:          parent.parent.selected ? "#ffffff" : "#888888"
                    font.pixelSize: 12
                    font.weight:    parent.parent.selected ? Font.Medium : Font.Normal

                    Behavior on color { ColorAnimation { duration: 150 } }
                }
            }

            // Right tick
            Text {
                anchors.right:          parent.right
                anchors.rightMargin:    10
                anchors.verticalCenter: parent.verticalCenter
                text:                   "✓"
                color:                  accent
                font.pixelSize:         11
                visible:                parent.selected
            }

            MouseArea {
                id:             itemMouse
                anchors.fill:   parent
                hoverEnabled:   true
                cursorShape:    Qt.PointingHandCursor
                onClicked:      parent.selected = !parent.selected
            }
        }
    }
}