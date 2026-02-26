// C:\NestLink\GCS\src\AGVView\AGVActionBar.qml
import QtQuick
import QtQuick.Controls

Rectangle {
    id: root

    property bool   ready:         false
    property bool   missionActive: false
    property bool   locked:        false
    property string startLabel:    "START MISSION"
    property string stopLabel:     "STOP MISSION"
    property string accent:        "#1ff18f"

    // Extra left slot — set a child with id "extraLeftItem"
    // instead of a generic property since QML doesn't easily
    // pass live components as properties; use the default children trick.
    default property alias extraContent: extraSlot.data

    signal startClicked
    signal stopClicked
    signal pauseClicked(bool paused)
    signal returnHomeClicked
    signal clearClicked
    signal emergencyClicked

    height: 56
    color:  "#060e09"

    Rectangle {
        anchors.top: parent.top
        width: parent.width; height: 1
        // color: "rgba(255,255,255,0.1)"
    }

    Row {
        anchors.fill:    parent
        anchors.margins: 10
        spacing: 6

        // ── Extra slot (e.g. Prime Pump / Calibrate) ─────────────────────────
        Item {
            id:     extraSlot
            height: parent.height
            width:  children.length > 0 ? children[0].width : 0
        }

        // ── Start / Stop ──────────────────────────────────────────────────────
        Rectangle {
            id: startStopBtn
            property bool hovered: false
            width:  170; height: 38; radius: 7

            color: {
                if (!root.ready && !root.missionActive) return "rgba(255,255,255,0.03)"
                if (root.missionActive) return startStopBtn.hovered ? "rgba(200,20,20,0.7)" : "rgba(180,20,20,0.55)"
                return startStopBtn.hovered ? "rgba(31,241,143,0.92)" : "rgba(31,241,143,0.78)"
            }
            border.color: {
                if (!root.ready && !root.missionActive) return "rgba(255,255,255,0.08)"
                if (root.missionActive) return "#ff4444"
                return root.accent
            }
            border.width: 1
            opacity: (!root.ready && !root.missionActive) ? 0.45 : 1

            Behavior on color        { ColorAnimation { duration: 200 } }
            Behavior on border.color { ColorAnimation { duration: 200 } }

            Row {
                anchors.centerIn: parent
                spacing: 8

                Text {
                    text: root.missionActive ? "⏹" : "▶"
                    font.pixelSize: 14
                    color: {
                        if (!root.ready && !root.missionActive) return "grey"
                        if (root.missionActive) return "#ffdddd"
                        return "grey"
                    }
                    anchors.verticalCenter: parent.verticalCenter
                }

                Text {
                    text: root.missionActive ? root.stopLabel : root.startLabel
                    color: {
                        if (!root.ready && !root.missionActive) return "grey"
                        if (root.missionActive) return "#ffdddd"
                        return "grey"
                    }
                    font.pixelSize: 12
                    font.weight: Font.ExtraBold
                    font.letterSpacing: 0.5
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: (!root.ready && !root.missionActive) ? Qt.ForbiddenCursor : Qt.PointingHandCursor
                onEntered:  startStopBtn.hovered = true
                onExited:   startStopBtn.hovered = false
                onClicked: {
                    if (!root.ready && !root.missionActive) return
                    if (root.missionActive) root.stopClicked()
                    else root.startClicked()
                }
            }
        }

        // ── Pause ─────────────────────────────────────────────────────────────
        Rectangle {
            id: pauseBtn
            property bool paused:  false
            property bool hovered: false
            width: 42; height: 38; radius: 7
            color:        paused ? "rgba(255,200,0,0.15)" : hovered ? "rgba(255,255,255,0.07)" : "rgba(255,255,255,0.04)"
            border.color: paused ? "#ffd700" : "rgba(255,255,255,0.1)"
            border.width: 1
            opacity: root.missionActive ? 1 : 0.3

            Behavior on color        { ColorAnimation { duration: 150 } }
            Behavior on border.color { ColorAnimation { duration: 150 } }

            Text {
                anchors.centerIn: parent
                text: pauseBtn.paused ? "▶" : "⏸"
                font.pixelSize: 16
                color: pauseBtn.paused ? "#ffd700" : "rgba(255,255,255,0.6)"
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: root.missionActive ? Qt.PointingHandCursor : Qt.ForbiddenCursor
                onEntered: pauseBtn.hovered = true
                onExited:  pauseBtn.hovered = false
                onClicked: {
                    if (!root.missionActive) return
                    pauseBtn.paused = !pauseBtn.paused
                    root.pauseClicked(pauseBtn.paused)
                }
            }
        }

        // ── Return Home ───────────────────────────────────────────────────────
        Rectangle {
            property bool hovered: false
            width:  140; height: 38; radius: 7
            color:        hovered ? "rgba(255,255,255,0.06)" : "rgba(255,255,255,0.03)"
            // border.color: "rgba(255,255,255,0.1)";
            border.width: 1
            Behavior on color { ColorAnimation { duration: 150 } }

            Row {
                anchors.centerIn: parent
                spacing: 6
                Text { text: "🏠"; font.pixelSize: 14; anchors.verticalCenter: parent.verticalCenter }
                Text {
                    text: "Return Home"
                    color: "white"      //Qt.rgba(255,255,255,0.6)";
                    font.pixelSize: 11; font.weight: Font.DemiBold
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            MouseArea {
                anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor
                onEntered:  parent.hovered = true
                onExited:   parent.hovered = false
                onClicked:  root.returnHomeClicked()
            }
        }

        // ── Spacer ─────────────────────────────────────────────────────────────
        // Item { width: 1; height: 1; Layout.fillWidth: true
        //     // In a Row we use a fixed spacer trick:
        // }
        Rectangle { width: 1; height: 1; color: "transparent"
            // This won't stretch in a Row; use Item below
        }

        // Flexible spacer hack in Row
        Item {
            // Remaining space
            width: {
                var used = 10 + (extraSlot.width > 0 ? extraSlot.width + 6 : 0)
                         + 170 + 6 + 42 + 6 + 140 + 6 + 80 + 6 + 100 + 6 + 50 + 10
                return Math.max(0, root.width - used)
            }
            height: 1
        }

        // ── Clear ─────────────────────────────────────────────────────────────
        Rectangle {
            property bool hovered: false
            width:  80; height: 38; radius: 7
            color:        hovered ? "rgba(255,255,255,0.05)" : "transparent"
            // border.color: "rgba(255,255,255,0.08)";
            border.width: 1
            opacity: (root.missionActive || root.locked) ? 0.3 : 1
            Behavior on color { ColorAnimation { duration: 150 } }

            Row {
                anchors.centerIn: parent; spacing: 5
                Text { text: "✕"; color: "white"   //rgba(255,255,255,0.38)";
                    font.pixelSize: 12; anchors.verticalCenter: parent.verticalCenter }
                Text { text: "Clear"; color: "white" //rgba(255,255,255,0.38)";
                    font.pixelSize: 11; anchors.verticalCenter: parent.verticalCenter }
            }

            MouseArea {
                anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor
                onEntered:  parent.hovered = true
                onExited:   parent.hovered = false
                onClicked:  { if (!root.missionActive && !root.locked) root.clearClicked() }
            }
        }

        // ── Emergency Stop ────────────────────────────────────────────────────
        Rectangle {
            id: emergBtn
            property bool hovered: false
            width:  168; height: 38; radius: 7
            color:        hovered ? "#cc0000" : "rgba(150,0,0,0.4)"
            border.color: "#ff3333"; border.width: 1
            Behavior on color { ColorAnimation { duration: 150 } }

            Row {
                anchors.centerIn: parent; spacing: 6
                Text { text: "🛑"; font.pixelSize: 14; anchors.verticalCenter: parent.verticalCenter }
                Text {
                    text: "EMERGENCY STOP"
                    color: emergBtn.hovered ? "#ffdddd" : "#ff7777"
                    font.pixelSize: 11; font.weight: Font.Bold; font.letterSpacing: 0.5
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            MouseArea {
                anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor
                onEntered:  emergBtn.hovered = true
                onExited:   emergBtn.hovered = false
                onClicked: { root.emergencyClicked(); root.stopClicked() }
            }
        }

        // ── Ready indicator ───────────────────────────────────────────────────
        Rectangle {
            id: readyIndicator
            width: 50; height: 38; radius: 7
            color:        root.ready ? "rgba(31,241,143,0.08)" : "rgba(255,255,255,0.03)"
            border.color: root.ready ? "rgba(31,241,143,0.35)" : "rgba(255,255,255,0.07)"
            border.width: 1
            Behavior on color        { ColorAnimation { duration: 300 } }
            Behavior on border.color { ColorAnimation { duration: 300 } }

            Column {
                anchors.centerIn: parent
                spacing: 3

                Rectangle {
                    width: 8; height: 8; radius: 4
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: root.ready ? root.accent : "rgba(255,255,255,0.15)"
                    Behavior on color { ColorAnimation { duration: 300 } }

                    SequentialAnimation on opacity {
                        running: root.ready && !root.missionActive
                        loops: Animation.Infinite
                        NumberAnimation { to: 0.3; duration: 700 }
                        NumberAnimation { to: 1.0; duration: 700 }
                    }
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: root.missionActive ? "ACTIVE" : root.ready ? "READY" : "SETUP"
                    color: root.ready ? root.accent : "white"    //Qt.rgba(255,255,255,0.2)"
                    font.pixelSize: 7; font.weight: Font.ExtraBold
                    font.letterSpacing: 1; font.family: "Courier New"
                    Behavior on color { ColorAnimation { duration: 300 } }
                }
            }
        }
    }
}
