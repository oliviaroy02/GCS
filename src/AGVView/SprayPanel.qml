// //C:\NestLink\GCS\src\AGVView\SprayPanel.qml
// import QtQuick
// import QtQuick.Controls
// import QtQuick.Layouts

// Rectangle {
//     anchors.fill:   parent
//     color:          "#0d0d0d"

//     property string _accent: "#1ff18f" //"#ff6b35"
//     property int    _sectionSpacing: 12

//     Flickable {
//         anchors.fill:       parent
//         contentHeight:      panelCol.height + 24
//         clip:               true

//         Column {
//             id:         panelCol
//             width:      parent.width
//             padding:    16
//             spacing:    _sectionSpacing

//             // ── A. Spray Type ──────────────────────────────────────
//             AGVPanelSelection {
//                 width:          parent.width - 32
//                 label:          "A   SPRAY TYPE"
//                 accent:         _accent
//                 options:        ["Herbicide", "Pesticide", "Fungicide", "Liquid Fertilizer", "Custom"]
//             }

//             AGVDivider { width: parent.width - 32 }

//             // ── B. Spray Mode ──────────────────────────────────────
//             AGVPanelSelection {
//                 width:          parent.width - 32
//                 label:          "B   SPRAY MODE"
//                 accent:         _accent
//                 options:        ["Manual", "Autonomous", "A-B Mode"]
//             }

//             AGVDivider { width: parent.width - 32 }

//             // ── C. Spray Parameters ────────────────────────────────
//             AGVSectionHeader { width: parent.width - 32; label: "C   SPRAY PARAMETERS"; accent: _accent }

//             AGVSliderRow {
//                 width:      parent.width - 32
//                 label:      "Pump Speed"
//                 unit:       "%"
//                 minVal:     0
//                 maxVal:     100
//                 initVal:    50
//             }

//             AGVToggleRow {
//                 width:      parent.width - 32
//                 label:      "Variable Spray"
//             }

//             AGVDivider { width: parent.width - 32 }

//             // ── D. Field & Navigation ──────────────────────────────
//             AGVSectionHeader { width: parent.width - 32; label: "D   FIELD & NAVIGATION"; accent: _accent }

//             AGVActionButton { width: parent.width - 32; label: "Select Saved Field" }
//             AGVActionButton { width: parent.width - 32; label: "Create New Field" }
//             AGVActionButton { width: parent.width - 32; label: "Auto Path Planning" }

//             AGVDivider { width: parent.width - 32 }

//             // ── E. Advanced Settings ───────────────────────────────
//             AGVSectionHeader { width: parent.width - 32; label: "E   ADVANCED SETTINGS"; accent: _accent }
//             AGVActionButton { width: parent.width - 32; label: "Spray Logging & Report" }
//         }
//     }
// }


//1st iteration
// C:\NestLink\GCS\src\AGVView\SprayPanel.qml
// import QtQuick
// import QtQuick.Controls

// Rectangle {
//     anchors.fill:   parent
//     color:          "#0d0d0d"

//     readonly property string _accent: "#1ff18f"

//     Row {
//         anchors.fill:    parent
//         anchors.margins: 12
//         spacing:         10

//         // ── A. Spray Type ─────────────────────────────────────
//         Rectangle {
//             width:  (parent.width - 40) / 5
//             height: parent.height
//             color:  Qt.rgba(1,1,1,0.02)
//             radius: 6
//             border.color: Qt.rgba(31/255,241/255,143/255,0.15)
//             border.width: 1

//             Column {
//                 anchors.fill:    parent
//                 anchors.margins: 10
//                 spacing:         4

//                 Row {
//                     width: parent.width; height: 22; spacing: 6
//                     Rectangle { width: 3; height: 14; radius: 2; color: _accent; anchors.verticalCenter: parent.verticalCenter }
//                     Text { text: "SPRAY TYPE"; color: _accent; font.pixelSize: 9; font.weight: Font.Bold; font.letterSpacing: 1.2; anchors.verticalCenter: parent.verticalCenter }
//                 }
//                 Rectangle { width: parent.width; height: 1; color: Qt.rgba(1,1,1,0.06) }

//                 Repeater {
//                     model: ["Herbicide", "Pesticide", "Fungicide", "Liquid Fertilizer", "Custom"]
//                     delegate: Rectangle {
//                         width: parent.width
//                         height: (parent.parent.height - 40) / 5
//                         radius: 4
//                         color:  sel ? Qt.rgba(31/255,241/255,143/255,0.08) : ma.containsMouse ? Qt.rgba(1,1,1,0.03) : "transparent"
//                         property bool sel: false
//                         Behavior on color { ColorAnimation { duration: 80 } }
//                         Row {
//                             anchors.verticalCenter: parent.verticalCenter; anchors.left: parent.left; anchors.leftMargin: 8; spacing: 8
//                             Rectangle {
//                                 width: 8; height: 8; radius: parent.parent.sel ? 2 : 4
//                                 anchors.verticalCenter: parent.verticalCenter
//                                 color: parent.parent.sel ? _accent : "transparent"
//                                 border.color: parent.parent.sel ? _accent : Qt.rgba(1,1,1,0.25); border.width: 1
//                                 Behavior on color  { ColorAnimation  { duration: 120 } }
//                                 Behavior on radius { NumberAnimation { duration: 120 } }
//                             }
//                             Text { text: modelData; color: parent.parent.sel ? "#ffffff" : "#666666"; font.pixelSize: 11; Behavior on color { ColorAnimation { duration: 120 } } }
//                         }
//                         Text { anchors.right: parent.right; anchors.rightMargin: 8; anchors.verticalCenter: parent.verticalCenter; text: "✓"; color: _accent; font.pixelSize: 10; visible: parent.sel }
//                         MouseArea {
//                             id: ma; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor
//                             onClicked: { var c = parent.parent; for(var i=0;i<c.children.length;i++) c.children[i].sel=false; parent.sel=true }
//                         }
//                     }
//                 }
//             }
//         }

//         // ── B. Spray Mode ─────────────────────────────────────
//         Rectangle {
//             width:  (parent.width - 40) / 5
//             height: parent.height
//             color:  Qt.rgba(1,1,1,0.02)
//             radius: 6
//             border.color: Qt.rgba(31/255,241/255,143/255,0.15)
//             border.width: 1

//             Column {
//                 anchors.fill:    parent
//                 anchors.margins: 10
//                 spacing:         4

//                 Row {
//                     width: parent.width; height: 22; spacing: 6
//                     Rectangle { width: 3; height: 14; radius: 2; color: _accent; anchors.verticalCenter: parent.verticalCenter }
//                     Text { text: "SPRAY MODE"; color: _accent; font.pixelSize: 9; font.weight: Font.Bold; font.letterSpacing: 1.2; anchors.verticalCenter: parent.verticalCenter }
//                 }
//                 Rectangle { width: parent.width; height: 1; color: Qt.rgba(1,1,1,0.06) }

//                 Repeater {
//                     model: ["Manual", "Autonomous", "A-B Mode"]
//                     delegate: Rectangle {
//                         width: parent.width
//                         height: (parent.parent.height - 40) / 3
//                         radius: 4
//                         color:  sel ? Qt.rgba(31/255,241/255,143/255,0.08) : ma.containsMouse ? Qt.rgba(1,1,1,0.03) : "transparent"
//                         property bool sel: false
//                         Behavior on color { ColorAnimation { duration: 80 } }
//                         Row {
//                             anchors.verticalCenter: parent.verticalCenter; anchors.left: parent.left; anchors.leftMargin: 8; spacing: 8
//                             Rectangle {
//                                 width: 8; height: 8; radius: parent.parent.sel ? 2 : 4
//                                 anchors.verticalCenter: parent.verticalCenter
//                                 color: parent.parent.sel ? _accent : "transparent"
//                                 border.color: parent.parent.sel ? _accent : Qt.rgba(1,1,1,0.25); border.width: 1
//                                 Behavior on color  { ColorAnimation  { duration: 120 } }
//                                 Behavior on radius { NumberAnimation { duration: 120 } }
//                             }
//                             Text { text: modelData; color: parent.parent.sel ? "#ffffff" : "#666666"; font.pixelSize: 11; Behavior on color { ColorAnimation { duration: 120 } } }
//                         }
//                         Text { anchors.right: parent.right; anchors.rightMargin: 8; anchors.verticalCenter: parent.verticalCenter; text: "✓"; color: _accent; font.pixelSize: 10; visible: parent.sel }
//                         MouseArea {
//                             id: ma; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor
//                             onClicked: { var c = parent.parent; for(var i=0;i<c.children.length;i++) c.children[i].sel=false; parent.sel=true }
//                         }
//                     }
//                 }
//             }
//         }

//         // ── C. Spray Parameters ───────────────────────────────
//         Rectangle {
//             width:  (parent.width - 40) / 5
//             height: parent.height
//             color:  Qt.rgba(1,1,1,0.02)
//             radius: 6
//             border.color: Qt.rgba(31/255,241/255,143/255,0.15)
//             border.width: 1

//             Column {
//                 anchors.fill:    parent
//                 anchors.margins: 10
//                 spacing:         10

//                 Row {
//                     width: parent.width; height: 22; spacing: 6
//                     Rectangle { width: 3; height: 14; radius: 2; color: _accent; anchors.verticalCenter: parent.verticalCenter }
//                     Text { text: "SPRAY PARAMETERS"; color: _accent; font.pixelSize: 9; font.weight: Font.Bold; font.letterSpacing: 1.2; anchors.verticalCenter: parent.verticalCenter }
//                 }
//                 Rectangle { width: parent.width; height: 1; color: Qt.rgba(1,1,1,0.06) }

//                 Column {
//                     width: parent.width; spacing: 6
//                     Row {
//                         width: parent.width
//                         Text { text: "Pump Speed"; color: "#888888"; font.pixelSize: 11; width: parent.width * 0.6 }
//                         Text { anchors.right: parent.right; text: Math.round(pumpSlider.value) + " %"; color: _accent; font.pixelSize: 11; font.weight: Font.Medium }
//                     }
//                     Slider {
//                         id: pumpSlider; width: parent.width; from: 0; to: 100; value: 50; height: 20
//                         background: Rectangle {
//                             x: pumpSlider.leftPadding; y: pumpSlider.topPadding + pumpSlider.availableHeight/2 - height/2
//                             width: pumpSlider.availableWidth; height: 3; radius: 2; color: Qt.rgba(1,1,1,0.1)
//                             Rectangle { width: pumpSlider.visualPosition * parent.width; height: parent.height; radius: 2; color: _accent }
//                         }
//                         handle: Rectangle {
//                             x: pumpSlider.leftPadding + pumpSlider.visualPosition * (pumpSlider.availableWidth - width)
//                             y: pumpSlider.topPadding + pumpSlider.availableHeight/2 - height/2
//                             width: 14; height: 14; radius: 7
//                             color: pumpSlider.pressed ? _accent : "#1a1a1a"; border.color: _accent; border.width: 2
//                         }
//                     }
//                 }

//                 Rectangle { width: parent.width; height: 1; color: Qt.rgba(1,1,1,0.06) }

//                 Item {
//                     width: parent.width; height: 30
//                     Text { anchors.left: parent.left; anchors.verticalCenter: parent.verticalCenter; text: "Variable Spray"; color: "#888888"; font.pixelSize: 11 }
//                     Rectangle {
//                         id: sprayTrack
//                         anchors.right: parent.right; anchors.verticalCenter: parent.verticalCenter
//                         width: 36; height: 18; radius: 9
//                         color: sprayOn ? Qt.rgba(31/255,241/255,143/255,0.5) : Qt.rgba(1,1,1,0.1)
//                         property bool sprayOn: false
//                         Behavior on color { ColorAnimation { duration: 150 } }
//                         Rectangle {
//                             width: 14; height: 14; radius: 7; y: 2
//                             x: sprayTrack.sprayOn ? parent.width - width - 2 : 2
//                             color: sprayTrack.sprayOn ? _accent : "#555555"
//                             Behavior on x     { NumberAnimation { duration: 150; easing.type: Easing.InOutQuad } }
//                             Behavior on color { ColorAnimation  { duration: 150 } }
//                         }
//                         MouseArea { anchors.fill: parent; cursorShape: Qt.PointingHandCursor; onClicked: sprayTrack.sprayOn = !sprayTrack.sprayOn }
//                     }
//                 }
//             }
//         }

//         // ── D. Field & Navigation ─────────────────────────────
//         Rectangle {
//             width:  (parent.width - 40) / 5
//             height: parent.height
//             color:  Qt.rgba(1,1,1,0.02)
//             radius: 6
//             border.color: Qt.rgba(31/255,241/255,143/255,0.15)
//             border.width: 1

//             Column {
//                 anchors.fill:    parent
//                 anchors.margins: 10
//                 spacing:         6

//                 Row {
//                     width: parent.width; height: 22; spacing: 6
//                     Rectangle { width: 3; height: 14; radius: 2; color: _accent; anchors.verticalCenter: parent.verticalCenter }
//                     Text { text: "FIELD & NAVIGATION"; color: _accent; font.pixelSize: 9; font.weight: Font.Bold; font.letterSpacing: 1.2; anchors.verticalCenter: parent.verticalCenter }
//                 }
//                 Rectangle { width: parent.width; height: 1; color: Qt.rgba(1,1,1,0.06) }

//                 Repeater {
//                     model: ["Select Saved Field", "Create New Field", "Auto Path Planning"]
//                     delegate: Rectangle {
//                         width: parent.width
//                         height: (parent.parent.height - 50) / 3
//                         radius: 4
//                         color: bm.pressed ? Qt.rgba(31/255,241/255,143/255,0.15) : bm.containsMouse ? Qt.rgba(1,1,1,0.05) : "transparent"
//                         border.color: bm.containsMouse ? Qt.rgba(31/255,241/255,143/255,0.4) : Qt.rgba(1,1,1,0.08); border.width: 1
//                         Behavior on color        { ColorAnimation { duration: 80 } }
//                         Behavior on border.color { ColorAnimation { duration: 80 } }
//                         Text {
//                             anchors.verticalCenter: parent.verticalCenter; anchors.left: parent.left; anchors.leftMargin: 10
//                             text: modelData; font.pixelSize: 11
//                             color: bm.containsMouse ? _accent : "#777777"
//                             Behavior on color { ColorAnimation { duration: 80 } }
//                         }
//                         Text { anchors.right: parent.right; anchors.rightMargin: 10; anchors.verticalCenter: parent.verticalCenter; text: "›"; color: _accent; font.pixelSize: 14; visible: bm.containsMouse }
//                         MouseArea { id: bm; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor; onClicked: console.log(modelData) }
//                     }
//                 }
//             }
//         }

//         // ── E. Advanced Settings ──────────────────────────────
//         Rectangle {
//             width:  (parent.width - 40) / 5
//             height: parent.height
//             color:  Qt.rgba(1,1,1,0.02)
//             radius: 6
//             border.color: Qt.rgba(31/255,241/255,143/255,0.15)
//             border.width: 1

//             Column {
//                 anchors.fill:    parent
//                 anchors.margins: 10
//                 spacing:         6

//                 Row {
//                     width: parent.width; height: 22; spacing: 6
//                     Rectangle { width: 3; height: 14; radius: 2; color: _accent; anchors.verticalCenter: parent.verticalCenter }
//                     Text { text: "ADVANCED SETTINGS"; color: _accent; font.pixelSize: 9; font.weight: Font.Bold; font.letterSpacing: 1.2; anchors.verticalCenter: parent.verticalCenter }
//                 }
//                 Rectangle { width: parent.width; height: 1; color: Qt.rgba(1,1,1,0.06) }

//                 Rectangle {
//                     width: parent.width; height: 36; radius: 4
//                     color: logM.pressed ? Qt.rgba(31/255,241/255,143/255,0.15) : logM.containsMouse ? Qt.rgba(1,1,1,0.05) : "transparent"
//                     border.color: logM.containsMouse ? Qt.rgba(31/255,241/255,143/255,0.4) : Qt.rgba(1,1,1,0.08); border.width: 1
//                     Behavior on color        { ColorAnimation { duration: 80 } }
//                     Behavior on border.color { ColorAnimation { duration: 80 } }
//                     Text {
//                         anchors.verticalCenter: parent.verticalCenter; anchors.left: parent.left; anchors.leftMargin: 10
//                         text: "Spray Logging & Report"; font.pixelSize: 11
//                         color: logM.containsMouse ? _accent : "#777777"
//                         Behavior on color { ColorAnimation { duration: 80 } }
//                     }
//                     Text { anchors.right: parent.right; anchors.rightMargin: 10; anchors.verticalCenter: parent.verticalCenter; text: "›"; color: _accent; font.pixelSize: 14; visible: logM.containsMouse }
//                     MouseArea { id: logM; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor }
//                 }
//             }
//         }
//     }
// }

//===========================================================
//===========================================================
//===========================================================
//===========================================================
//===========================================================
//===========================================================
// C:\NestLink\GCS\src\AGVView\SprayPanel.qml
import QtQuick
import QtQuick.Controls

Rectangle {
    id: root
    anchors.fill:   parent
    color:          "#0d0d0d"

    property bool   missionActive: false
    property bool   locked:        false
    property string _accent:       "#1ff18f"

    signal missionStartRequested
    signal missionStopRequested

    // ── State ─────────────────────────────────────────────────────────────────
    QtObject {
        id: state
        property int  sprayType:   -1
        property int  sprayMode:   -1
        property real pumpSpeed:    50
        property bool varSpray:     false
        property int  fieldAction: -1
        property bool logging:      true

        function clear() {
            sprayType   = -1; sprayMode = -1
            fieldAction = -1; pumpSpeed = 50; varSpray = false
        }
    }

    property bool _ready: state.sprayType >= 0 && state.sprayMode >= 0 && state.fieldAction >= 0

    // ── Layout ────────────────────────────────────────────────────────────────
    Column {
        anchors.fill: parent
        spacing: 0

        // Content row
        Row {
            width: parent.width
            height: parent.height - actionBar.height
            spacing: 8
            padding: 10

            // A+B ── Spray Type & Mode
            Rectangle {
                width:  (parent.width - 2 * 10 - 3 * 8) * 0.24
                height: parent.height - 20
                color:  (state.sprayType >= 0 && state.sprayMode >= 0) ? Qt.rgba(31,241,143,0.04) : Qt.rgba(255,255,255,0.025)
                border.color: (state.sprayType >= 0 && state.sprayMode >= 0) ? Qt.rgba(31,241,143,0.3) : Qt.rgba(255,255,255,0.07)
                border.width: 1
                radius: 10
                clip: true
                Behavior on color        { ColorAnimation { duration: 250 } }
                Behavior on border.color { ColorAnimation { duration: 250 } }

                Flickable {
                    anchors.fill: parent
                    anchors.margins: 12
                    contentHeight: panelAB.implicitHeight
                    clip: true

                    Column {
                        id: panelAB
                        width: parent.width
                        spacing: 0

                        AGVChipGroup {
                            width: parent.width
                            label: "SPRAY TYPE"; icon: "💧"
                            options: ["Herbicide", "Pesticide", "Fungicide", "Liquid Fert.", "Custom"]
                            selected: state.sprayType
                            locked: root.locked
                            accent: _accent
                            onSelectionChanged: (i) => state.sprayType = i
                        }

                        // Divider
                        Rectangle { width: parent.width; height: 1; color: Qt.rgba(31/255,241/255,143/255,0.07);
                            // margin: 10
                            anchors.topMargin: 10
                        }

                        Item { width: 1; height: 10 }

                        AGVChipGroup {
                            width: parent.width
                            label: "SPRAY MODE"; icon: "⚙️"
                            options: ["Manual", "Autonomous", "A-B Mode"]
                            selected: state.sprayMode
                            locked: root.locked
                            accent: _accent
                            onSelectionChanged: (i) => state.sprayMode = i
                        }
                    }
                }
            }

            // C ── Spray Parameters
            Rectangle {
                width:  (parent.width - 2 * 10 - 3 * 8) * 0.20
                height: parent.height - 20
                color:  Qt.rgba(31/255,241/255,143/255,0.025)
                border.color: Qt.rgba(31/255,241/255,143/255,0.07); border.width: 1
                radius: 10
                clip: true

                Flickable {
                    anchors.fill: parent
                    anchors.margins: 12
                    contentHeight: panelC.implicitHeight
                    clip: true

                    Column {
                        id: panelC
                        width: parent.width
                        spacing: 0

                        // Section header
                        Row {
                            spacing: 7; height: 28
                            Rectangle { width: 3; height: 14; radius: 2; color: _accent; anchors.verticalCenter: parent.verticalCenter }
                            Text { text: "🔧"; font.pixelSize: 12; anchors.verticalCenter: parent.verticalCenter }
                            Text {
                                text: "SPRAY PARAMETERS"; color: _accent
                                font.pixelSize: 8; font.weight: Font.ExtraBold; font.letterSpacing: 2; font.family: "Courier New"
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }

                        // Pump Speed
                        Row {
                            width: parent.width; height: 20
                            Text { text: "⟳  Pump Speed"; color: Qt.rgba(255,255,255,0.6); font.pixelSize: 10; anchors.verticalCenter: parent.verticalCenter; width: parent.width * 0.7 }
                            Rectangle {
                                anchors.right: parent.right; anchors.verticalCenter: parent.verticalCenter
                                width: 52; height: 22; radius: 5
                                color: Qt.rgba(31/255, 241/255, 143/255, 0.04); border.color: Qt.rgba(31/255, 241/255, 143/255, 0.04); border.width: 1
                                Text {
                                    anchors.centerIn: parent
                                    text: Math.round(state.pumpSpeed) + "%"
                                    color: _accent; font.pixelSize: 11; font.weight: Font.Bold; font.family: "Courier New"
                                }
                            }
                        }

                        Item { height: 6; width: 1 }

                        Slider {
                            id: pumpSlider
                            width: parent.width; from: 0; to: 100; value: state.pumpSpeed; height: 20
                            enabled: !root.locked
                            onValueChanged: state.pumpSpeed = value
                            background: Rectangle {
                                x: pumpSlider.leftPadding; y: pumpSlider.topPadding + pumpSlider.availableHeight/2 - height/2
                                width: pumpSlider.availableWidth; height: 3; radius: 2; color: Qt.rgba(255,255,255,0.1)
                                Rectangle { width: pumpSlider.visualPosition * parent.width; height: parent.height; radius: 2; color: _accent }
                            }
                            handle: Rectangle {
                                x: pumpSlider.leftPadding + pumpSlider.visualPosition * (pumpSlider.availableWidth - width)
                                y: pumpSlider.topPadding + pumpSlider.availableHeight/2 - height/2
                                width: 16; height: 16; radius: 8
                                color: pumpSlider.pressed ? _accent : "#111a14"; border.color: _accent; border.width: 2
                            }
                        }

                        Item { height: 10; width: 1 }
                        Rectangle { width: parent.width; height: 1; color: Qt.rgba(255,255,255,0.07) }
                        Item { height: 10; width: 1 }

                        // Variable Spray toggle
                        Row {
                            width: parent.width; height: 30
                            Row {
                                spacing: 6; anchors.verticalCenter: parent.verticalCenter
                                Text { text: "〰️"; font.pixelSize: 12 }
                                Text { text: "Variable Spray"; color: Qt.rgba(255,255,255,0.6); font.pixelSize: 10 }
                            }
                            Rectangle {
                                id: varTrack
                                anchors.right: parent.right; anchors.verticalCenter: parent.verticalCenter
                                width: 38; height: 19; radius: 10
                                color: state.varSpray ? Qt.rgba(31,241,143,0.4) : Qt.rgba(255,255,255,0.1)
                                border.color: state.varSpray ? _accent : Qt.rgba(255,255,255,0.12); border.width: 1
                                Behavior on color        { ColorAnimation { duration: 150 } }
                                Behavior on border.color { ColorAnimation { duration: 150 } }
                                Rectangle {
                                    width: 15; height: 15; radius: 8; y: 2
                                    x: state.varSpray ? parent.width - width - 2 : 2
                                    color: state.varSpray ? _accent : "#555555"
                                    Behavior on x     { NumberAnimation { duration: 150; easing.type: Easing.InOutQuad } }
                                    Behavior on color { ColorAnimation  { duration: 150 } }
                                }
                                MouseArea {
                                    anchors.fill: parent; cursorShape: Qt.PointingHandCursor
                                    onClicked: if (!root.locked) state.varSpray = !state.varSpray
                                }
                            }
                        }

                        Item { height: 10; width: 1 }
                        Rectangle { width: parent.width; height: 1; color: Qt.rgba(255,255,255,0.07) }
                        Item { height: 10; width: 1 }

                        // Live readout
                        Rectangle {
                            width: parent.width; height: 60; radius: 7
                            color: Qt.rgba(31/255, 241/255, 143/255, 0.04); border.color: Qt.rgba(31/255, 241/255, 143/255, 0.04); border.width: 1

                            Row {
                                anchors.fill: parent; anchors.margins: 10

                                Column {
                                    width: parent.width / 2; spacing: 3; anchors.verticalCenter: parent.verticalCenter
                                    Text { text: "FLOW RATE"; color: Qt.rgba(255,255,255,0.38); font.pixelSize: 8; font.letterSpacing: 1 }
                                    Row {
                                        spacing: 3
                                        Text { text: (state.pumpSpeed * 0.08).toFixed(1); color: _accent; font.pixelSize: 14; font.weight: Font.Bold; font.family: "Courier New" }
                                        Text { text: "L/min"; color: Qt.rgba(255,255,255,0.4); font.pixelSize: 10; anchors.bottom: parent.bottom; anchors.bottomMargin: 2 }
                                    }
                                }

                                Rectangle { width: 1; height: parent.height - 16; color: Qt.rgba(255,255,255,0.1); anchors.verticalCenter: parent.verticalCenter }

                                Column {
                                    width: parent.width / 2 - 20; spacing: 3; anchors.verticalCenter: parent.verticalCenter
                                    anchors.left: parent.left; anchors.leftMargin: parent.width / 2 + 10
                                    Text { text: "PRESSURE"; color: Qt.rgba(255,255,255,0.38); font.pixelSize: 8; font.letterSpacing: 1 }
                                    Row {
                                        spacing: 3
                                        Text { text: (state.pumpSpeed * 0.03 + 0.5).toFixed(1); color: _accent; font.pixelSize: 14; font.weight: Font.Bold; font.family: "Courier New" }
                                        Text { text: "bar"; color: Qt.rgba(255,255,255,0.4); font.pixelSize: 10; anchors.bottom: parent.bottom; anchors.bottomMargin: 2 }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            // D ── Field & Navigation
            Rectangle {
                width:  (parent.width - 2 * 10 - 3 * 8) * 0.26
                height: parent.height - 20
                color:  state.fieldAction >= 0 ? Qt.rgba(31,241,143,0.04) : Qt.rgba(255,255,255,0.025)
                border.color: state.fieldAction >= 0 ? Qt.rgba(31,241,143,0.3) : Qt.rgba(255,255,255,0.07)
                border.width: 1; radius: 10; clip: true
                Behavior on color        { ColorAnimation { duration: 250 } }
                Behavior on border.color { ColorAnimation { duration: 250 } }

                Flickable {
                    anchors.fill: parent; anchors.margins: 12
                    contentHeight: panelD.implicitHeight; clip: true

                    Column {
                        id: panelD
                        width: parent.width; spacing: 10

                        Row {
                            spacing: 7; height: 28
                            Rectangle { width: 3; height: 14; radius: 2; color: _accent; anchors.verticalCenter: parent.verticalCenter }
                            Text { text: "🗺️"; font.pixelSize: 12; anchors.verticalCenter: parent.verticalCenter }
                            Text {
                                text: "FIELD & NAVIGATION"
                                color: state.fieldAction >= 0 ? _accent : "white"
                                font.pixelSize: 8; font.weight: Font.ExtraBold; font.letterSpacing: 2; font.family: "Courier New"
                                anchors.verticalCenter: parent.verticalCenter
                                Behavior on color { ColorAnimation { duration: 200 } }
                            }
                        }

                        AGVOptionCards {
                            width: parent.width
                            accent: _accent
                            locked: root.locked
                            selected: state.fieldAction
                            options: [
                                { icon: "📂", label: "Select Saved Field",  sub: "Load existing boundary" },
                                { icon: "✏️", label: "Create New Field",    sub: "Draw field boundary"    },
                                { icon: "🛰️", label: "Auto Path Planning",  sub: "Generate optimal route" }
                            ]
                            onSelectionChanged: (i) => state.fieldAction = i
                        }
                    }
                }
            }

            // E ── Advanced + Status
            Rectangle {
                width: parent.width - 2 * 10 - 3 * 8
                       - (parent.width - 2 * 10 - 3 * 8) * 0.24
                       - (parent.width - 2 * 10 - 3 * 8) * 0.20
                       - (parent.width - 2 * 10 - 3 * 8) * 0.26
                       - 3 * 8   // remaining after other panels and their spacing consumed
                height: parent.height - 20
                color:  Qt.rgba(255,255,255,0.025)
                border.color: Qt.rgba(255,255,255,0.07); border.width: 1; radius: 10; clip: true

                // Simpler: just use Layout.fillWidth equivalent by computing leftover
                Component.onCompleted: {
                    // width is auto via Row stretch; nothing to do
                }

                Flickable {
                    anchors.fill: parent; anchors.margins: 12
                    contentHeight: panelE.implicitHeight; clip: true

                    Column {
                        id: panelE
                        width: parent.width; spacing: 0

                        Row {
                            spacing: 7; height: 28
                            Rectangle { width: 3; height: 14; radius: 2; color: _accent; anchors.verticalCenter: parent.verticalCenter }
                            Text { text: "⚗️"; font.pixelSize: 12; anchors.verticalCenter: parent.verticalCenter }
                            Text {
                                text: "ADVANCED SETTINGS"; color: _accent
                                font.pixelSize: 8; font.weight: Font.ExtraBold; font.letterSpacing: 2; font.family: "Courier New"
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }

                        // Logging toggle
                        Row {
                            width: parent.width; height: 30
                            Row { spacing: 6; anchors.verticalCenter: parent.verticalCenter
                                Text { text: "📋"; font.pixelSize: 12 }
                                Text { text: "Spray Logging"; color: Qt.rgba(255,255,255,0.6); font.pixelSize: 10 }
                            }
                            Rectangle {
                                id: logTrack
                                anchors.right: parent.right; anchors.verticalCenter: parent.verticalCenter
                                width: 38; height: 19; radius: 10
                                color: state.logging ? Qt.rgba(31,241,143,0.4) : Qt.rgba(255,255,255,0.1)
                                border.color: state.logging ? _accent : Qt.rgba(255,255,255,0.12); border.width: 1
                                Behavior on color        { ColorAnimation { duration: 150 } }
                                Behavior on border.color { ColorAnimation { duration: 150 } }
                                Rectangle {
                                    width: 15; height: 15; radius: 8; y: 2
                                    x: state.logging ? parent.width - width - 2 : 2
                                    color: state.logging ? _accent : "#555555"
                                    Behavior on x     { NumberAnimation { duration: 150; easing.type: Easing.InOutQuad } }
                                    Behavior on color { ColorAnimation  { duration: 150 } }
                                }
                                MouseArea { anchors.fill: parent; cursorShape: Qt.PointingHandCursor; onClicked: state.logging = !state.logging }
                            }
                        }

                        // PDF Report button
                        Rectangle {
                            width: parent.width; height: 34; radius: 7
                            color: reportMouse.containsMouse ? Qt.rgba(255,255,255,0.05) : Qt.rgba(255,255,255,0.03)
                            border.color: Qt.rgba(255,255,255,0.08); border.width: 1
                            Behavior on color { ColorAnimation { duration: 80 } }
                            Row {
                                anchors.left: parent.left; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter; spacing: 7
                                Text { text: "📊"; font.pixelSize: 14 }
                                Text { text: "Generate PDF Report"; color: Qt.rgba(255,255,255,0.6); font.pixelSize: 11 }
                            }
                            Text { anchors.right: parent.right; anchors.rightMargin: 10; anchors.verticalCenter: parent.verticalCenter; text: "›"; color: _accent; font.pixelSize: 14 }
                            MouseArea { id: reportMouse; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor; onClicked: console.log("generate report") }
                        }

                        Item { height: 10; width: 1 }
                        Rectangle { width: parent.width; height: 1; color: Qt.rgba(255,255,255,0.07) }
                        Item { height: 8; width: 1 }

                        AGVStatRow { width: parent.width; label: "Coverage";     value: root.missionActive ? "18%"   : "--"; accent: _accent }
                        
                        // Coverage bar
                        Rectangle {
                            width: parent.width; height: 4; radius: 2
                            color: Qt.rgba(255,255,255,0.08)
                            Rectangle {
                                width: root.missionActive ? parent.width * 0.18 : 0
                                height: parent.height; radius: 2; color: _accent
                                Behavior on width { NumberAnimation { duration: 600 } }
                            }
                        }

                        Item { height: 6; width: 1 }

                        AGVStatRow { width: parent.width; label: "Chemical Used"; value: root.missionActive ? "12.5 Lt" : "--"; accent: _accent }
                        AGVStatRow { width: parent.width; label: "Tank Level";    value: root.missionActive ? "75%"    : "--"; accent: _accent }

                        Item { height: 8; width: 1 }
                        Rectangle { width: parent.width; height: 1; color: Qt.rgba(255,255,255,0.07) }
                        Item { height: 8; width: 1 }

                        Rectangle {
                            width: parent.width; height: 30; radius: 7
                            color: Qt.rgba(31/255, 241/255, 143/255, 0.04); border.color: Qt.rgba(31/255, 241/255, 143/255, 0.04); border.width: 1
                            Row {
                                anchors.left: parent.left; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter; spacing: 6
                                Text { text: "✅"; font.pixelSize: 12 }
                                Text { text: "No Active Alerts"; color: Qt.rgba(255,255,255,0.38); font.pixelSize: 10 }
                            }
                        }
                    }
                }
            }
        }

        // Action bar
        AGVActionBar {
            id: actionBar
            width: parent.width
            ready: root._ready
            missionActive: root.missionActive
            locked: root.locked
            startLabel: "START SPRAY"
            stopLabel:  "STOP SPRAY"
            accent: _accent

            onStartClicked:     root.missionStartRequested()
            onStopClicked:      root.missionStopRequested()
            onClearClicked:     state.clear()
            onEmergencyClicked: root.missionStopRequested()

            // Extra left: Prime Pump
            Rectangle {
                property bool hovered: false
                width: 130; height: 38; radius: 7
                color:        hovered ? Qt.rgba(255,255,255,0.06) : Qt.rgba(255,255,255,0.03)
                border.color: Qt.rgba(255,255,255,0.1); border.width: 1
                Behavior on color { ColorAnimation { duration: 150 } }
                Row {
                    anchors.centerIn: parent; spacing: 6
                    Text { text: "⟳"; font.pixelSize: 14; color: Qt.rgba(255,255,255,0.6); anchors.verticalCenter: parent.verticalCenter }
                    Text { text: "Prime Pump"; color: Qt.rgba(255,255,255,0.6); font.pixelSize: 11; font.weight: Font.DemiBold; anchors.verticalCenter: parent.verticalCenter }
                }
                MouseArea {
                    anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor
                    onEntered: parent.hovered = true; onExited: parent.hovered = false
                    onClicked: console.log("prime pump")
                }
            }
        }
    }
}

