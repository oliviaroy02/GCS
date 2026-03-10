// import QtQuick
// import QtQuick.Controls

// Rectangle {
//     id: root

//     property string label: ""
//     property bool checked: false

//     height: 32
//     color: "transparent"

//     Row {
//         anchors.left: parent.left
//         anchors.verticalCenter: parent.verticalCenter
//         spacing: 8

//         Text {
//             text: "📋"
//             font.pixelSize: 12
//         }

//         Text {
//             text: root.label
//             color: Qt.rgba(255,255,255,0.7)
//             font.pixelSize: 11
//         }
//     }

//     Rectangle {
//         anchors.right: parent.right
//         anchors.verticalCenter: parent.verticalCenter

//         width: 38
//         height: 19
//         radius: 10

//         color: root.checked ? Qt.rgba(31,241,143,0.4) : Qt.rgba(255,255,255,0.1)

//         border.color: root.checked ? "#1ff18f" : Qt.rgba(255,255,255,0.12)
//         border.width: 1

//         Behavior on color { ColorAnimation { duration: 150 } }
//         Behavior on border.color { ColorAnimation { duration: 150 } }

//         Rectangle {
//             width: 15
//             height: 15
//             radius: 8
//             y: 2

//             x: root.checked ? parent.width - width - 2 : 2
//             color: root.checked ? "#1ff18f" : "#555555"

//             Behavior on x {
//                 NumberAnimation {
//                     duration: 150
//                     easing.type: Easing.InOutQuad
//                 }
//             }

//             Behavior on color {
//                 ColorAnimation { duration: 150 }
//             }
//         }

//         MouseArea {
//             anchors.fill: parent
//             cursorShape: Qt.PointingHandCursor

//             onClicked: root.checked = !root.checked
//         }
//     }
// }

// C:\NestLink\GCS\src\AGVView\AGVRightToggle.qml
import QtQuick

Rectangle {
    property string label:   ""
    property string icon:    ""
    property string sub:     ""
    property bool   checked: false

    height:       sub !== "" ? 62 : 48
    radius:       8
    color:        checked ? Qt.rgba(31,241,143,0.07) : Qt.rgba(255,255,255,0.03)
    border.color: checked ? Qt.rgba(31,241,143,0.3)  : Qt.rgba(255,255,255,0.09)
    border.width: 1

    Behavior on color        { ColorAnimation { duration: 150 } }
    Behavior on border.color { ColorAnimation { duration: 150 } }

    Row {
        anchors.left:           parent.left
        anchors.leftMargin:     14
        anchors.verticalCenter: parent.verticalCenter
        spacing: 12

        Text {
            text:           icon
            font.pixelSize: sub !== "" ? 22 : 18
            visible:        icon !== ""
            anchors.verticalCenter: parent.verticalCenter
        }

        Column {
            anchors.verticalCenter: parent.verticalCenter
            spacing: 3

            Text {
                text:           label
                color:          Qt.rgba(255,255,255,0.8)
                font.pixelSize: 13
                font.weight:    Font.DemiBold
            }

            Text {
                text:           sub
                color:          Qt.rgba(255,255,255,0.35)
                font.pixelSize: 10
                visible:        sub !== ""
            }
        }
    }

    // Toggle switch
    Rectangle {
        id:                     track
        anchors.right:          parent.right
        anchors.rightMargin:    14
        anchors.verticalCenter: parent.verticalCenter
        width:  42; height: 22; radius: 11
        color:        checked ? Qt.rgba(31,241,143,0.4) : Qt.rgba(255,255,255,0.1)
        border.color: checked ? "#1ff18f"               : Qt.rgba(255,255,255,0.15)
        border.width: 1

        Behavior on color        { ColorAnimation { duration: 150 } }
        Behavior on border.color { ColorAnimation { duration: 150 } }

        Rectangle {
            width:  18; height: 18; radius: 9; y: 2
            x:      checked ? parent.width - width - 2 : 2
            color:  checked ? "#1ff18f" : "#666666"

            Behavior on x     { NumberAnimation { duration: 150; easing.type: Easing.InOutQuad } }
            Behavior on color { ColorAnimation  { duration: 150 } }
        }

        MouseArea {
            anchors.fill: parent
            cursorShape:  Qt.PointingHandCursor
            onClicked:    checked = !checked
        }
    }
}
