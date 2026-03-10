// import QtQuick
// import QtQuick.Controls

// Column {
//     id: root

//     property string title: ""
//     property string icon: ""

//     spacing: 8

//     Row {
//         spacing: 7
//         height: 24

//         Rectangle {
//             width: 3
//             height: 14
//             radius: 2
//             color: "#1ff18f"
//             anchors.verticalCenter: parent.verticalCenter
//         }

//         Text {
//             text: root.icon
//             font.pixelSize: 12
//             anchors.verticalCenter: parent.verticalCenter
//         }

//         Text {
//             text: root.title
//             color: "#1ff18f"
//             font.pixelSize: 9
//             font.weight: Font.ExtraBold
//             font.letterSpacing: 1.5
//             font.family: "Courier New"
//             anchors.verticalCenter: parent.verticalCenter
//         }
//     }
// }

// C:\NestLink\GCS\src\AGVView\AGVRightSection.qml
import QtQuick

Column {
    property string title:   ""
    property string icon:    ""
    anchors.left: parent.left
    anchors.leftMargin: 5

    spacing: 6

    // Section header row
    Row {
        spacing: 8
        height:  30

        Rectangle {
            width:                  3
            height:                 16
            radius:                 2
            color:                  "#1ff18f"
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            text:                   icon
            font.pixelSize:         15
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            text:                   title
            color:                  "#1ff18f"
            font.pixelSize:         10
            font.weight:            Font.ExtraBold
            font.letterSpacing:     1.8
            font.family:            "Courier New"
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}
