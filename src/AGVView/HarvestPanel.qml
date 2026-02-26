// //C:\NestLink\GCS\src\AGVView\HarvestPanel.qml
// import QtQuick

// Rectangle {
//     anchors.fill:   parent
//     color:          "#0d0d0d"

//     property string _accent: "#1ff18f" //"#ff6b35"

//     Flickable {
//         anchors.fill:       parent
//         contentHeight:      panelCol.height + 24
//         clip:               true

//         Column {
//             id:         panelCol
//             width:      parent.width
//             padding:    16
//             spacing:    12

//             AGVPanelSelection {
//                 width:      parent.width - 32
//                 label:      "A   DETECTION MODE"
//                 accent:     _accent
//                 options:    ["AI Vision Mode", "Pre-Mapped Seed Zones", "Manual Area Selection"]
//             }

//             AGVDivider { width: parent.width - 32 }

//             AGVPanelSelection {
//                 width:      parent.width - 32
//                 label:      "B   WEED TYPE SELECTION"
//                 accent:     _accent
//                 options:    ["Grass Weeds", "Broadleaf", "Custom"]
//             }

//             AGVDivider { width: parent.width - 32 }

//             AGVPanelSelection {
//                 width:      parent.width - 32
//                 label:      "C   OPERATION MODE"
//                 accent:     _accent
//                 options:    ["Surface Cutting", "Precision Root Removal", "Full Surface"]
//             }

//             AGVDivider { width: parent.width - 32 }

//             AGVSectionHeader { width: parent.width - 32; label: "D   TOOL CONTROL"; accent: _accent }

//             AGVSliderRow {
//                 width:      parent.width - 32
//                 label:      "Blade Speed"
//                 unit:       "RPM"
//                 minVal:     0
//                 maxVal:     3000
//                 initVal:    1500
//             }

//             AGVSliderRow {
//                 width:      parent.width - 32
//                 label:      "Extraction Depth"
//                 unit:       "mm"
//                 minVal:     0
//                 maxVal:     200
//                 initVal:    50
//             }
//         }
//     }
// }

// // C:\NestLink\GCS\src\AGVView\HarvestPanel.qml
// import QtQuick
// import QtQuick.Controls

// Rectangle {
//     anchors.fill:   parent
//     color:          "#0d0d0d"

//     property bool   missionActive: false
//     property bool   locked:        false
//     readonly property string _accent: "#1ff18f"
//     signal missionStartRequested
//     signal missionStopRequested

//     Row {
//         anchors.fill:    parent
//         anchors.margins: 12
//         spacing:         10

//         // ── A. Detection Mode ─────────────────────────────────
//         Rectangle {
//             width:  (parent.width - 30) / 4
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
//                     Text { text: "DETECTION MODE"; color: _accent; font.pixelSize: 9; font.weight: Font.Bold; font.letterSpacing: 1.2; anchors.verticalCenter: parent.verticalCenter }
//                 }
//                 Rectangle { width: parent.width; height: 1; color: Qt.rgba(1,1,1,0.06) }

//                 Repeater {
//                     model: ["AI Vision Mode", "Pre-Mapped Seed Zones", "Manual Area Selection"]
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

//         // ── B. Weed Type ──────────────────────────────────────
//         Rectangle {
//             width:  (parent.width - 30) / 4
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
//                     Text { text: "WEED TYPE SELECTION"; color: _accent; font.pixelSize: 9; font.weight: Font.Bold; font.letterSpacing: 1.2; anchors.verticalCenter: parent.verticalCenter }
//                 }
//                 Rectangle { width: parent.width; height: 1; color: Qt.rgba(1,1,1,0.06) }

//                 Repeater {
//                     model: ["Grass Weeds", "Broadleaf", "Custom"]
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

//         // ── C. Operation Mode ─────────────────────────────────
//         Rectangle {
//             width:  (parent.width - 30) / 4
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
//                     Text { text: "OPERATION MODE"; color: _accent; font.pixelSize: 9; font.weight: Font.Bold; font.letterSpacing: 1.2; anchors.verticalCenter: parent.verticalCenter }
//                 }
//                 Rectangle { width: parent.width; height: 1; color: Qt.rgba(1,1,1,0.06) }

//                 Repeater {
//                     model: ["Surface Cutting", "Precision Root Removal", "Full Surface"]
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

//         // ── D. Tool Control ───────────────────────────────────
//         Rectangle {
//             width:  (parent.width - 30) / 4
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
//                     Text { text: "TOOL CONTROL"; color: _accent; font.pixelSize: 9; font.weight: Font.Bold; font.letterSpacing: 1.2; anchors.verticalCenter: parent.verticalCenter }
//                 }
//                 Rectangle { width: parent.width; height: 1; color: Qt.rgba(1,1,1,0.06) }

//                 Column {
//                     width: parent.width; spacing: 6
//                     Row {
//                         width: parent.width
//                         Text { text: "Blade Speed"; color: "#888888"; font.pixelSize: 11; width: parent.width * 0.6 }
//                         Text { anchors.right: parent.right; text: Math.round(bladeSlider.value) + " RPM"; color: _accent; font.pixelSize: 11; font.weight: Font.Medium }
//                     }
//                     Slider {
//                         id: bladeSlider; width: parent.width; from: 0; to: 3000; value: 1500; height: 20
//                         background: Rectangle {
//                             x: bladeSlider.leftPadding; y: bladeSlider.topPadding + bladeSlider.availableHeight/2 - height/2
//                             width: bladeSlider.availableWidth; height: 3; radius: 2; color: Qt.rgba(1,1,1,0.1)
//                             Rectangle { width: bladeSlider.visualPosition * parent.width; height: parent.height; radius: 2; color: _accent }
//                         }
//                         handle: Rectangle {
//                             x: bladeSlider.leftPadding + bladeSlider.visualPosition * (bladeSlider.availableWidth - width)
//                             y: bladeSlider.topPadding + bladeSlider.availableHeight/2 - height/2
//                             width: 14; height: 14; radius: 7
//                             color: bladeSlider.pressed ? _accent : "#1a1a1a"; border.color: _accent; border.width: 2
//                         }
//                     }
//                 }

//                 Rectangle { width: parent.width; height: 1; color: Qt.rgba(1,1,1,0.06) }

//                 Column {
//                     width: parent.width; spacing: 6
//                     Row {
//                         width: parent.width
//                         Text { text: "Extraction Depth"; color: "#888888"; font.pixelSize: 11; width: parent.width * 0.6 }
//                         Text { anchors.right: parent.right; text: Math.round(depthSlider.value) + " mm"; color: _accent; font.pixelSize: 11; font.weight: Font.Medium }
//                     }
//                     Slider {
//                         id: depthSlider; width: parent.width; from: 0; to: 200; value: 50; height: 20
//                         background: Rectangle {
//                             x: depthSlider.leftPadding; y: depthSlider.topPadding + depthSlider.availableHeight/2 - height/2
//                             width: depthSlider.availableWidth; height: 3; radius: 2; color: Qt.rgba(1,1,1,0.1)
//                             Rectangle { width: depthSlider.visualPosition * parent.width; height: parent.height; radius: 2; color: _accent }
//                         }
//                         handle: Rectangle {
//                             x: depthSlider.leftPadding + depthSlider.visualPosition * (depthSlider.availableWidth - width)
//                             y: depthSlider.topPadding + depthSlider.availableHeight/2 - height/2
//                             width: 14; height: 14; radius: 7
//                             color: depthSlider.pressed ? _accent : "#1a1a1a"; border.color: _accent; border.width: 2
//                         }
//                     }
//                 }
//             }
//         }
//     }
// }

// C:\NestLink\GCS\src\AGVView\HarvestPanel.qml
import QtQuick
import QtQuick.Controls

Rectangle {
    id: root
    anchors.fill: parent
    color: "#0d0d0d"

    property bool   missionActive: false
    property bool   locked:        false
    property string _accent:       "#1ff18f"

    signal missionStartRequested
    signal missionStopRequested

    QtObject {
        id: state
        property int  detectMode: -1
        property int  weedType:   -1
        property int  opMode:     -1
        property real bladeSpeed: 1500
        property real depth:      50

        function clear() { detectMode = -1; weedType = -1; opMode = -1; bladeSpeed = 1500; depth = 50 }
    }

    property bool _ready: state.detectMode >= 0 && state.weedType >= 0 && state.opMode >= 0

    Column {
        anchors.fill: parent
        spacing: 0

        Row {
            width: parent.width
            height: parent.height - actionBar.height
            spacing: 8
            padding: 10

            // A ── Detection + Weed Type
            Rectangle {
                width:  (parent.width - 2 * 10 - 3 * 8) * 0.25
                height: parent.height - 20
                color:  (state.detectMode >= 0 && state.weedType >= 0) ? Qt.rgba(31,241,143,0.04) : Qt.rgba(255,255,255,0.025)
                border.color: (state.detectMode >= 0 && state.weedType >= 0) ? Qt.rgba(31,241,143,0.3) : Qt.rgba(255,255,255,0.07)
                border.width: 1; radius: 10; clip: true
                Behavior on color        { ColorAnimation { duration: 250 } }
                Behavior on border.color { ColorAnimation { duration: 250 } }

                Flickable {
                    anchors.fill: parent; anchors.margins: 12
                    contentHeight: colA.implicitHeight; clip: true

                    Column {
                        id: colA
                        width: parent.width; spacing: 0

                        AGVChipGroup {
                            width: parent.width
                            label: "DETECTION MODE"; icon: "👁️"
                            options: ["AI Vision Mode", "Pre-Mapped Zones", "Manual Selection"]
                            selected: state.detectMode; locked: root.locked; accent: _accent
                            onSelectionChanged: (i) => state.detectMode = i
                        }

                        Item { height: 10; width: 1 }
                        Rectangle { width: parent.width; height: 1; color: Qt.rgba(255,255,255,0.07) }
                        Item { height: 10; width: 1 }

                        AGVChipGroup {
                            width: parent.width
                            label: "WEED TYPE"; icon: "🌿"
                            options: ["Grass Weeds", "Broadleaf", "Custom"]
                            selected: state.weedType; locked: root.locked; accent: _accent
                            onSelectionChanged: (i) => state.weedType = i
                        }
                    }
                }
            }

            // B ── Operation Mode
            Rectangle {
                width:  (parent.width - 2 * 10 - 3 * 8) * 0.28
                height: parent.height - 20
                color:  state.opMode >= 0 ? Qt.rgba(31,241,143,0.04) : Qt.rgba(255,255,255,0.025)
                border.color: state.opMode >= 0 ? Qt.rgba(31,241,143,0.3) : rgba(255,255,255,0.07)
                border.width: 1; radius: 10; clip: true
                Behavior on color        { ColorAnimation { duration: 250 } }
                Behavior on border.color { ColorAnimation { duration: 250 } }

                Flickable {
                    anchors.fill: parent; anchors.margins: 12
                    contentHeight: colB.implicitHeight; clip: true

                    Column {
                        id: colB
                        width: parent.width; spacing: 10

                        Row {
                            spacing: 7; height: 28
                            Rectangle { width: 3; height: 14; radius: 2; color: _accent; anchors.verticalCenter: parent.verticalCenter }
                            Text { text: "⚙️"; font.pixelSize: 12; anchors.verticalCenter: parent.verticalCenter }
                            Text {
                                text: "OPERATION MODE"
                                color: state.opMode >= 0 ? _accent : Qt.rgba(255,255,255,0.38)
                                font.pixelSize: 8; font.weight: Font.ExtraBold; font.letterSpacing: 2; font.family: "Courier New"
                                anchors.verticalCenter: parent.verticalCenter
                                Behavior on color { ColorAnimation { duration: 200 } }
                            }
                        }

                        AGVOptionCards {
                            width: parent.width; accent: _accent; locked: root.locked
                            selected: state.opMode
                            options: [
                                { icon: "〰️", label: "Surface Cutting",        sub: "Remove weeds at surface level" },
                                { icon: "🎯", label: "Precision Root Removal",  sub: "Target root system precisely"  },
                                { icon: "⬛", label: "Full Surface",            sub: "Complete area treatment"       }
                            ]
                            onSelectionChanged: (i) => state.opMode = i
                        }
                    }
                }
            }

            // C ── Tool Control
            Rectangle {
                width:  (parent.width - 2 * 10 - 3 * 8) * 0.22
                height: parent.height - 20
                color:  Qt.rgba(255,255,255,0.025)
                border.color: Qt.rgba(255,255,255,0.07); border.width: 1; radius: 10; clip: true

                Flickable {
                    anchors.fill: parent; anchors.margins: 12
                    contentHeight: colC.implicitHeight; clip: true

                    Column {
                        id: colC
                        width: parent.width; spacing: 0

                        Row {
                            spacing: 7; height: 28
                            Rectangle { width: 3; height: 14; radius: 2; color: _accent; anchors.verticalCenter: parent.verticalCenter }
                            Text { text: "🔧"; font.pixelSize: 12; anchors.verticalCenter: parent.verticalCenter }
                            Text {
                                text: "TOOL CONTROL"; color: _accent
                                font.pixelSize: 8; font.weight: Font.ExtraBold; font.letterSpacing: 2; font.family: "Courier New"
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }

                        // Blade Speed
                        Row {
                            width: parent.width; height: 20
                            Text { text: "⚡  Blade Speed"; color: rgba(255,255,255,0.6); font.pixelSize: 10; anchors.verticalCenter: parent.verticalCenter; width: parent.width * 0.65 }
                            Rectangle {
                                anchors.right: parent.right; anchors.verticalCenter: parent.verticalCenter
                                width: 62; height: 22; radius: 5
                                color: rgba(31,241,143,0.08); border.color: rgba(31,241,143,0.2); border.width: 1
                                Text {
                                    anchors.centerIn: parent
                                    text: Math.round(state.bladeSpeed) + " RPM"
                                    color: _accent; font.pixelSize: 10; font.weight: Font.Bold; font.family: "Courier New"
                                }
                            }
                        }

                        Item { height: 6; width: 1 }

                        Slider {
                            id: bladeSlider
                            width: parent.width; from: 0; to: 3000; value: state.bladeSpeed; height: 20
                            enabled: !root.locked
                            onValueChanged: state.bladeSpeed = value
                            background: Rectangle {
                                x: bladeSlider.leftPadding; y: bladeSlider.topPadding + bladeSlider.availableHeight/2 - height/2
                                width: bladeSlider.availableWidth; height: 3; radius: 2; color: Qt.rgba(255,255,255,0.1)
                                Rectangle { width: bladeSlider.visualPosition * parent.width; height: parent.height; radius: 2; color: _accent }
                            }
                            handle: Rectangle {
                                x: bladeSlider.leftPadding + bladeSlider.visualPosition * (bladeSlider.availableWidth - width)
                                y: bladeSlider.topPadding + bladeSlider.availableHeight/2 - height/2
                                width: 16; height: 16; radius: 8
                                color: bladeSlider.pressed ? _accent : "#111a14"; border.color: _accent; border.width: 2
                            }
                        }

                        Item { height: 12; width: 1 }
                        Rectangle { width: parent.width; height: 1; color: Qt.rgba(255,255,255,0.07) }
                        Item { height: 12; width: 1 }

                        // Extraction Depth
                        Row {
                            width: parent.width; height: 20
                            Text { text: "📏  Extraction Depth"; color: Qt.rgba(255,255,255,0.6); font.pixelSize: 10; anchors.verticalCenter: parent.verticalCenter; width: parent.width * 0.65 }
                            Rectangle {
                                anchors.right: parent.right; anchors.verticalCenter: parent.verticalCenter
                                width: 62; height: 22; radius: 5
                                color: Qt.rgba(31,241,143,0.08); border.color: Qt.rgba(31,241,143,0.2); border.width: 1
                                Text {
                                    anchors.centerIn: parent
                                    text: Math.round(state.depth) + " mm"
                                    color: _accent; font.pixelSize: 10; font.weight: Font.Bold; font.family: "Courier New"
                                }
                            }
                        }

                        Item { height: 6; width: 1 }

                        Slider {
                            id: depthSlider
                            width: parent.width; from: 0; to: 200; value: state.depth; height: 20
                            enabled: !root.locked
                            onValueChanged: state.depth = value
                            background: Rectangle {
                                x: depthSlider.leftPadding; y: depthSlider.topPadding + depthSlider.availableHeight/2 - height/2
                                width: depthSlider.availableWidth; height: 3; radius: 2; color: rgba(255,255,255,0.1)
                                Rectangle { width: depthSlider.visualPosition * parent.width; height: parent.height; radius: 2; color: _accent }
                            }
                            handle: Rectangle {
                                x: depthSlider.leftPadding + depthSlider.visualPosition * (depthSlider.availableWidth - width)
                                y: depthSlider.topPadding + depthSlider.availableHeight/2 - height/2
                                width: 16; height: 16; radius: 8
                                color: depthSlider.pressed ? _accent : "#111a14"; border.color: _accent; border.width: 2
                            }
                        }
                    }
                }
            }

            // D ── Session Status
            Rectangle {
                width: parent.width - 2 * 10 - 3 * 8
                       - (parent.width - 2 * 10 - 3 * 8) * 0.25
                       - (parent.width - 2 * 10 - 3 * 8) * 0.28
                       - (parent.width - 2 * 10 - 3 * 8) * 0.22
                       - 3 * 8
                height: parent.height - 20
                color: Qt.rgba(255,255,255,0.025)
                border.color: Qt.rgba(255,255,255,0.07); border.width: 1; radius: 10; clip: true

                Flickable {
                    anchors.fill: parent; anchors.margins: 12
                    contentHeight: colD.implicitHeight; clip: true

                    Column {
                        id: colD
                        width: parent.width; spacing: 0

                        Row {
                            spacing: 7; height: 28
                            Rectangle { width: 3; height: 14; radius: 2; color: _accent; anchors.verticalCenter: parent.verticalCenter }
                            Text { text: "📊"; font.pixelSize: 12; anchors.verticalCenter: parent.verticalCenter }
                            Text {
                                text: "SESSION STATUS"; color: _accent
                                font.pixelSize: 8; font.weight: Font.ExtraBold; font.letterSpacing: 2; font.family: "Courier New"
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }

                        AGVStatRow { width: parent.width; label: "Area Cleared";   value: root.missionActive ? "546 m²" : "--"; accent: _accent }
                        AGVStatRow { width: parent.width; label: "Weeds Removed";  value: root.missionActive ? "128"    : "--"; accent: _accent }
                        AGVStatRow { width: parent.width; label: "Time Elapsed";   value: root.missionActive ? "12:34"  : "--"; accent: _accent }
                        AGVStatRow { width: parent.width; label: "Coverage";       value: root.missionActive ? "18%"    : "--"; accent: _accent }

                        Rectangle { width: parent.width; height: 1; color: Qt.rgba(255,255,255,0.07); anchors.topMargin: 4 }
                        Item { height: 6; width: 1 }

                        AGVStatRow { width: parent.width; label: "Blade RPM";  value: root.missionActive ? Math.round(state.bladeSpeed).toString() : "--"; accent: _accent }
                        AGVStatRow { width: parent.width; label: "Cut Depth";  value: root.missionActive ? (Math.round(state.depth) + " mm")       : "--"; accent: _accent }

                        Item { height: 8; width: 1 }
                        Rectangle { width: parent.width; height: 1; color: Qt.rgba(255,255,255,0.07) }
                        Item { height: 8; width: 1 }

                        Rectangle {
                            width: parent.width; height: 30; radius: 7
                            color: Qt.rgba(31,241,143,0.05); border.color: Qt.rgba(31,241,143,0.15); border.width: 1
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
            startLabel: "START HARVEST"
            stopLabel:  "STOP HARVEST"
            accent: _accent

            onStartClicked:     root.missionStartRequested()
            onStopClicked:      root.missionStopRequested()
            onClearClicked:     state.clear()
            onEmergencyClicked: root.missionStopRequested()

            Rectangle {
                property bool hovered: false
                width: 120; height: 38; radius: 7
                color:        hovered ? Qt.rgba(255,255,255,0.06) : Qt.rgba(255,255,255,0.03)
                border.color: Qt.rgba(255,255,255,0.1); border.width: 1
                Behavior on color { ColorAnimation { duration: 150 } }
                Row {
                    anchors.centerIn: parent; spacing: 6
                    Text { text: "🔍"; font.pixelSize: 14; anchors.verticalCenter: parent.verticalCenter }
                    Text { text: "Calibrate"; color: Qt.rgba(255,255,255,0.6); font.pixelSize: 11; font.weight: Font.DemiBold; anchors.verticalCenter: parent.verticalCenter }
                }
                MouseArea {
                    anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor
                    onEntered: parent.hovered = true; onExited: parent.hovered = false
                    onClicked: console.log("calibrate")
                }
            }
        }
    }
}
