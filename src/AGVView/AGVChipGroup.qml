// C:\NestLink\GCS\src\AGVView\AGVChipGroup.qml
import QtQuick
import QtQuick.Layouts

Item {
    id: root

    property string   label:    ""
    property string   icon:     ""
    property var      options:  []
    property int      selected: -1
    property bool     locked:   false
    property string   accent:   "#1ff18f"

    signal selectionChanged(int index)

    implicitHeight: headerRow.height + 8 + chipsFlow.implicitHeight

    // ── Header ────────────────────────────────────────────────────────────────
    Row {
        id: headerRow
        spacing: 6
        anchors.top: parent.top
        anchors.left: parent.left

        Text {
            text: root.icon
            font.pixelSize: 13
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            text: root.label
            color: root.selected >= 0 ? root.accent : "white"  //Qt.rgba(255,255,255,0.38)
            font.pixelSize: 8
            font.weight: Font.ExtraBold
            font.letterSpacing: 2
            font.family: "Courier New"
            anchors.verticalCenter: parent.verticalCenter

            Behavior on color { ColorAnimation { duration: 200 } }
        }

        Rectangle {
            width: 5; height: 5; radius: 3
            color: root.accent
            anchors.verticalCenter: parent.verticalCenter
            visible: root.selected >= 0
        }
    }

    // ── Chips ─────────────────────────────────────────────────────────────────
    Flow {
        id: chipsFlow
        anchors.top: headerRow.bottom
        anchors.topMargin: 8
        anchors.left: parent.left
        anchors.right: parent.right
        spacing: 5

        Repeater {
            model: root.options

            delegate: Rectangle {
                id: chip
                property bool active: root.selected === index
                property bool hovered: false

                width:  chipText.implicitWidth + 24
                height: 24
                radius: 12

                color: active
                    ? root.accent
                    : hovered ? "rgba(255,255,255,0.07)" : "rgba(255,255,255,0.04)"

                border.color: active
                    ? root.accent
                    : locked ? "rgba(255,255,255,0.06)" : "rgba(255,255,255,0.1)"
                border.width: 1

                opacity: locked && !active ? 0.4 : 1

                Behavior on color        { ColorAnimation { duration: 150 } }
                Behavior on border.color { ColorAnimation { duration: 150 } }

                Text {
                    id: chipText
                    anchors.centerIn: parent
                    text: modelData
                    color: chip.active ? "#050f09" : "white"  //Qt.rgba(255,255,255,0.6)
                    font.pixelSize: 10
                    font.weight: chip.active ? Font.Bold : Font.Normal
                    font.family: "Courier New"
                    font.letterSpacing: 0.3

                    Behavior on color { ColorAnimation { duration: 150 } }
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: (root.locked && !chip.active) ? Qt.ForbiddenCursor : Qt.PointingHandCursor
                    onEntered: chip.hovered = true
                    onExited:  chip.hovered = false
                    onClicked: {
                        if (root.locked && !chip.active) return
                        root.selectionChanged(chip.active ? -1 : index)
                    }
                }
            }
        }
    }
}
