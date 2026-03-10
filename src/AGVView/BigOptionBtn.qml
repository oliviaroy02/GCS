// C:\NestLink\GCS\src\AGVView\AGVBigOptionBtn.qml
import QtQuick
import QtQuick.Controls

Rectangle {
    id: root
    
    property string optIcon: ""
    property string optLabel: ""
    property bool active: false
    property bool lk: false
    property string ac: "#1ff18f"
    property QtObject th: null
    
    signal tapped()

    height: 42
    radius: 6
    color: active ? Qt.rgba(31/255,241/255,143/255,0.12) :
           hm.containsMouse && !lk ? Qt.rgba(255,255,255,0.06) :
           Qt.rgba(255,255,255,0.02)
    // color: active
    //     ? (th ? th.accentBg   : Qt.rgba(31/255,241/255,143/255,0.12))
    //     : hm.containsMouse && !lk
    //         ? (th ? th.surfaceHov : Qt.rgba(255,255,255,0.06))
    //         : (th ? th.surface    : Qt.rgba(255,255,255,0.02))
    border.color: active ? ac : Qt.rgba(255,255,255,0.08)
    // border.color: active
    //     ? (th ? th.accent  : ac)
    //     : (th ? th.border  : Qt.rgba(255,255,255,0.08))
    border.width: active ? 2 : 1
    opacity: lk && !active ? 0.35 : 1
    
    Behavior on color        { ColorAnimation { duration: 100 } }
    Behavior on border.color { ColorAnimation { duration: 100 } }

    Row {
        anchors.left: parent.left
        anchors.leftMargin: 12
        anchors.verticalCenter: parent.verticalCenter
        spacing: 10

        Text {
            text: root.optIcon
            font.pixelSize: 20
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            text: root.optLabel
            color: root.active ? "#ffffff" : Qt.rgba(255,255,255,0.68)
            // color:      root.active
            //                 ? (th ? th.text    : "#ffffff")
            //                 : (th ? th.textSub : Qt.rgba(255,255,255,0.68))
            font.pixelSize: 16
            font.weight: root.active ? Font.DemiBold : Font.Normal
            anchors.verticalCenter: parent.verticalCenter
            Behavior on color { ColorAnimation { duration: 100 } }
        }
    }

    // Rectangle {
    //     anchors.right: parent.right
    //     anchors.rightMargin: 10
    //     anchors.verticalCenter: parent.verticalCenter
    //     width: 20
    //     height: 20
    //     radius: 10
    //     color: root.active ? root.ac : "transparent"
    //     border.color: root.active ? root.ac : Qt.rgba(255,255,255,0.2)
    //     border.width: 1
    //     Behavior on color { ColorAnimation { duration: 100 } }

    //     Text {
    //         anchors.centerIn: parent
    //         text: "✓"
    //         color: root.active ? "#0f1a14" : Qt.rgba(255,255,255,0.15)
    //         font.pixelSize: 10
    //         font.weight: Font.Bold
    //     }
    // }

    MouseArea {
        id: hm
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: root.lk ? Qt.ForbiddenCursor : Qt.PointingHandCursor
        enabled: !root.lk
        onClicked: root.tapped()
    }
}