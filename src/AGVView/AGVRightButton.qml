// import QtQuick
// import QtQuick.Controls

// Rectangle {
//     id: root

//     property string label: ""
//     property string icon: ""

//     height: 34
//     radius: 6

//     color: btnMouse.containsMouse ? Qt.rgba(1,1,1,0.05) : Qt.rgba(1,1,1,0.02)

//     border.color: btnMouse.containsMouse ? Qt.rgba(31,241,143,0.3) : Qt.rgba(1,1,1,0.08)
//     border.width: 1

//     Behavior on color { ColorAnimation { duration: 80 } }
//     Behavior on border.color { ColorAnimation { duration: 80 } }

//     Row {
//         anchors.left: parent.left
//         anchors.leftMargin: 12
//         anchors.verticalCenter: parent.verticalCenter
//         spacing: 8

//         Text {
//             text: root.icon
//             font.pixelSize: 14
//             visible: root.icon !== ""
//         }

//         Text {
//             text: root.label
//             color: btnMouse.containsMouse ? "#ffffff" : "#888888"
//             font.pixelSize: 11

//             Behavior on color {
//                 ColorAnimation { duration: 80 }
//             }
//         }
//     }

//     Text {
//         anchors.right: parent.right
//         anchors.rightMargin: 12
//         anchors.verticalCenter: parent.verticalCenter

//         text: "›"
//         color: "#1ff18f"
//         font.pixelSize: 14

//         visible: btnMouse.containsMouse
//     }

//     MouseArea {
//         id: btnMouse
//         anchors.fill: parent
//         hoverEnabled: true
//         cursorShape: Qt.PointingHandCursor

//         onClicked: console.log(root.label, "clicked")
//     }
// }

// C:\NestLink\GCS\src\AGVView\AGVRightButton.qml
import QtQuick

Rectangle {
    property string label: ""
    property string icon:  ""
    property string sub:   ""

    height:       sub !== "" ? 62 : 48
    radius:       8
    color:        btnM.containsMouse ? Qt.rgba(255,255,255,0.07) : Qt.rgba(255,255,255,0.03)
    border.color: btnM.containsMouse ? Qt.rgba(31,241,143,0.35)  : Qt.rgba(255,255,255,0.09)
    border.width: 1

    Behavior on color        { ColorAnimation { duration: 80 } }
    Behavior on border.color { ColorAnimation { duration: 80 } }

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
                color:          btnM.containsMouse ? "#ffffff" : Qt.rgba(255,255,255,0.7)
                font.pixelSize: 13
                font.weight:    Font.DemiBold
                Behavior on color { ColorAnimation { duration: 80 } }
            }

            Text {
                text:           sub
                color:          Qt.rgba(255,255,255,0.35)
                font.pixelSize: 10
                visible:        sub !== ""
            }
        }
    }

    Text {
        anchors.right:          parent.right
        anchors.rightMargin:    14
        anchors.verticalCenter: parent.verticalCenter
        text:           "›"
        color:          "#1ff18f"
        font.pixelSize: 20
        visible:        btnM.containsMouse
    }

    MouseArea {
        id:           btnM
        anchors.fill: parent
        hoverEnabled: true
        cursorShape:  Qt.PointingHandCursor
        onClicked:    console.log(label, "clicked")
    }
}
