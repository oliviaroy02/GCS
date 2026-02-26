// // C:\NestLink\GCS\src\AGVView\AGVOptionCards.qml
// import QtQuick

// Item {
//     id: root

//     property var    options:  []   // [{icon, label, sub}]
//     property int    selected: -1
//     property bool   locked:   false
//     property string accent:   "#1ff18f"

//     signal selectionChanged(int index)

//     implicitHeight: col.implicitHeight

//     Column {
//         id: col
//         anchors.left: parent.left
//         anchors.right: parent.right
//         spacing: 4

//         Repeater {
//             model: root.options

//             delegate: Rectangle {
//                 id: card
//                 readonly property string optIcon:  modelData ? (modelData.icon  || "") : ""
//                 readonly property string optLabel: modelData ? (modelData.label || "") : ""
//                 readonly property string optSub:   modelData ? (modelData.sub   || "") : ""
//                 readonly property bool   hasSub:   optSub !== ""
//                 property bool active:  root.selected === index
//                 property bool hovered: false

//                 width: parent.width
//                 height: 52
//                 radius: 7

//                 color:        active  ? "rgba(31,241,143,0.09)" : hovered ? "rgba(255,255,255,0.04)" : "rgba(255,255,255,0.02)"
//                 border.color: active  ? root.accent : hovered ? "rgba(31,241,143,0.3)" : "rgba(255,255,255,0.07)"
//                 border.width: 1
//                 opacity: root.locked && !active ? 0.35 : 1

//                 Behavior on color        { ColorAnimation { duration: 150 } }
//                 Behavior on border.color { ColorAnimation { duration: 150 } }

//                 // Icon + labels
//                 Row {
//                     anchors.left:           parent.left
//                     anchors.leftMargin:     10
//                     anchors.verticalCenter: parent.verticalCenter
//                     spacing: 8

//                     Text {
//                         text: card.optIcon //modelData.icon
//                         font.pixelSize: 15
//                         anchors.verticalCenter: parent.verticalCenter
//                     }

//                     Column {
//                         anchors.verticalCenter: parent.verticalCenter
//                         spacing: 2

//                         Text {
//                             text: card.optLabel //modelData.label
//                             color: card.active ? "#ffffff" : "rgba(255,255,255,0.6)"
//                             font.pixelSize: 11
//                             font.weight: card.active ? Font.DemiBold : Font.Normal
//                             Behavior on color { ColorAnimation { duration: 150 } }
//                         }

//                         Text {
//                             text: card.optSub //modelData.sub
//                             color: "rgba(255,255,255,0.38)"
//                             font.pixelSize: 9
//                             visible: card.hasSub //modelData.sub !== undefined && modelData.sub !== ""
//                         }
//                     }
//                 }

//                 // Radio circle
//                 Rectangle {
//                     anchors.right:          parent.right
//                     anchors.rightMargin:    10
//                     anchors.verticalCenter: parent.verticalCenter
//                     width: 18; height: 18; radius: 9
//                     color:        card.active ? root.accent : "transparent"
//                     border.color: card.active ? root.accent : "rgba(255,255,255,0.12)"
//                     border.width: 1
//                     Behavior on color        { ColorAnimation { duration: 150 } }
//                     Behavior on border.color { ColorAnimation { duration: 150 } }

//                     Text {
//                         anchors.centerIn: parent
//                         text: "✓"
//                         color: "#050f09"
//                         font.pixelSize: 9
//                         font.weight: Font.Black
//                         visible: card.active
//                     }
//                 }

//                 MouseArea {
//                     anchors.fill: parent
//                     hoverEnabled: true
//                     cursorShape: (root.locked && !card.active) ? Qt.ForbiddenCursor : Qt.PointingHandCursor
//                     onEntered: card.hovered = true
//                     onExited:  card.hovered = false
//                     onClicked: {
//                         if (root.locked && !card.active) return
//                         root.selectionChanged(card.active ? -1 : index)
//                     }
//                 }
//             }
//         }
//     }
// }


// C:\NestLink\GCS\src\AGVView\AGVOptionCards.qml
import QtQuick

Item {
    id: root

    property var    options:  []   // [{icon, label, sub}]
    property int    selected: -1
    property bool   locked:   false
    property string accent:   "#1ff18f"

    signal selectionChanged(int index)

    implicitHeight: col.implicitHeight

    Column {
        id: col
        anchors.left: parent.left
        anchors.right: parent.right
        spacing: 4

        Repeater {
            model: root.options

            delegate: Rectangle {
                id: card

                // Cache modelData fields so child bindings never access
                // modelData directly — prevents null-eval warnings during
                // delegate construction when modelData is transiently null.
                readonly property string optIcon:  modelData ? (modelData.icon  || "") : ""
                readonly property string optLabel: modelData ? (modelData.label || "") : ""
                readonly property string optSub:   modelData ? (modelData.sub   || "") : ""
                readonly property bool   hasSub:   optSub !== ""

                property bool active:  root.selected === index
                property bool hovered: false

                width: parent.width
                height: 52
                radius: 7

                color:        active  ? "rgba(31,241,143,0.09)" : hovered ? "rgba(255,255,255,0.04)" : "rgba(255,255,255,0.02)"
                border.color: active  ? root.accent : hovered ? "rgba(31,241,143,0.3)" : "rgba(255,255,255,0.07)"
                border.width: 1
                opacity: root.locked && !active ? 0.35 : 1

                Behavior on color        { ColorAnimation { duration: 150 } }
                Behavior on border.color { ColorAnimation { duration: 150 } }

                // Icon + labels
                Row {
                    anchors.left:           parent.left
                    anchors.leftMargin:     10
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 8

                    Text {
                        text:           card.optIcon
                        font.pixelSize: 15
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    Column {
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: 2

                        Text {
                            text:        card.optLabel
                            color:       card.active ? "#ffffff" : "white"      //rgba(255,255,255,0.6)"
                            font.pixelSize: 11
                            font.weight: card.active ? Font.DemiBold : Font.Normal
                        }

                        // Text {
                        //     text:           card.optSub
                        //     color:          "rgba(255,255,255,0.38)"
                        //     font.pixelSize: 9
                        //     visible:        card.hasSub
                        // }
                    }
                }

                // Radio circle
                Rectangle {
                    anchors.right:          parent.right
                    anchors.rightMargin:    10
                    anchors.verticalCenter: parent.verticalCenter
                    width: 18; height: 18; radius: 9
                    color:        card.active ? root.accent : "transparent"
                    border.color: card.active ? root.accent : "rgba(255,255,255,0.12)"
                    border.width: 1
                    Behavior on color        { ColorAnimation { duration: 150 } }
                    Behavior on border.color { ColorAnimation { duration: 150 } }

                    Text {
                        anchors.centerIn: parent
                        text: "✓"
                        color: "#050f09"
                        font.pixelSize: 9
                        font.weight: Font.Black
                        visible: card.active
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: (root.locked && !card.active) ? Qt.ForbiddenCursor : Qt.PointingHandCursor
                    onEntered: card.hovered = true
                    onExited:  card.hovered = false
                    onClicked: {
                        if (root.locked && !card.active) return
                        root.selectionChanged(card.active ? -1 : index)
                    }
                }
            }
        }
    }
}
