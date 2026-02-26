// //C:\NestLink\GCS\src\AGVView\SowPanel.qml
// import QtQuick

// Rectangle {
//     anchors.fill:   parent
//     color:          "#0d0d0d"

//     property bool   missionActive: false
//     property bool   locked:        false
//     property string _accent: "#1ff18f" //"#ff6b35"
//     signal missionStartRequested
//     signal missionStopRequested

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
//                 label:      "A   CROP SELECTION"
//                 accent:     _accent
//                 options:    ["Onion", "Wheat", "Soyabean", "Custom"]
//             }

//             AGVDivider { width: parent.width - 32 }

//             AGVSectionHeader { width: parent.width - 32; label: "B   SOWING PARAMETERS"; accent: _accent }

//             AGVSliderRow { width: parent.width - 32; label: "Row Spacing";     unit: "cm";     minVal: 5;   maxVal: 100; initVal: 30 }
//             AGVSliderRow { width: parent.width - 32; label: "Seed Spacing";    unit: "cm";     minVal: 2;   maxVal: 50;  initVal: 10 }
//             AGVSliderRow { width: parent.width - 32; label: "Depth Control";   unit: "mm";     minVal: 10;  maxVal: 150; initVal: 40 }
//             AGVSliderRow { width: parent.width - 32; label: "Seed Rate";       unit: "KG/Ac";  minVal: 1;   maxVal: 50;  initVal: 10 }
//             AGVToggleRow { width: parent.width - 32; label: "Multi Row Mode" }

//             AGVDivider { width: parent.width - 32 }

//             AGVSectionHeader { width: parent.width - 32; label: "C   FIELD SETUP"; accent: _accent }
//             AGVActionButton { width: parent.width - 32; label: "Field Boundary Mapping" }
//             AGVActionButton { width: parent.width - 32; label: "Auto Headland Setup" }
//             AGVActionButton { width: parent.width - 32; label: "Skip Area Selection" }

//             AGVDivider { width: parent.width - 32 }

//             AGVSectionHeader { width: parent.width - 32; label: "D   SEED SYSTEM MONITORING"; accent: _accent }
//             AGVToggleRow { width: parent.width - 32; label: "Blockage Detection" }
//             AGVToggleRow { width: parent.width - 32; label: "Missed Seed Alert" }
//             AGVActionButton { width: parent.width - 32; label: "Calibration Mode" }
//             AGVToggleRow { width: parent.width - 32; label: "Hopper Level Indicator" }

//             AGVDivider { width: parent.width - 32 }

//             AGVSectionHeader { width: parent.width - 32; label: "E   EXECUTION"; accent: _accent }

//             Row {
//                 width:      parent.width - 32
//                 spacing:    8

//                 // Start Mission
//                 Rectangle {
//                     width:  (parent.width - 8) / 2
//                     height: 34
//                     radius: 4
//                     color:  startMouse.pressed ? "#cc4400" : "#1ff18f" //"#ff6b35"

//                     Behavior on color { ColorAnimation { duration: 100 } }

//                     Text {
//                         anchors.centerIn:   parent
//                         text:               "▶  Start Mission"
//                         color:              "#ffffff"
//                         font.pixelSize:     12
//                         font.weight:        Font.Bold
//                     }
//                     MouseArea {
//                         id:             startMouse
//                         anchors.fill:   parent
//                         cursorShape:    Qt.PointingHandCursor
//                         onClicked:      console.log("Start Mission")
//                     }
//                 }

//                 // Pause/Resume
//                 Rectangle {
//                     width:  (parent.width - 8) / 2
//                     height: 34
//                     radius: 4
//                     color:  pauseMouse.pressed ? Qt.rgba(1,1,1,0.1) : Qt.rgba(1,1,1,0.05)
//                     border.color: Qt.rgba(1,1,1,0.2)
//                     border.width: 1

//                     Behavior on color { ColorAnimation { duration: 100 } }

//                     Text {
//                         anchors.centerIn:   parent
//                         text:               "⏸  Pause / Resume"
//                         color:              "#aaaaaa"
//                         font.pixelSize:     12
//                         font.weight:        Font.Medium
//                     }
//                     MouseArea {
//                         id:             pauseMouse
//                         anchors.fill:   parent
//                         cursorShape:    Qt.PointingHandCursor
//                         onClicked:      console.log("Pause Resume")
//                     }
//                 }
//             }
//         }
//     }
// }


// C:\NestLink\GCS\src\AGVView\SowPanel.qml
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
        property int  crop:         -1
        property real rowSpacing:    30
        property real seedSpacing:   10
        property real depthCtrl:     40
        property real seedRate:      10
        property bool multiRow:      false
        property int  fieldSetup:   -1
        property bool blockage:      true
        property bool missedSeed:    true
        property bool hopper:        true

        function clear() { crop = -1; fieldSetup = -1; rowSpacing = 30; seedSpacing = 10; depthCtrl = 40; seedRate = 10; multiRow = false }
    }

    property bool _ready: state.crop >= 0 && state.fieldSetup >= 0

    Column {
        anchors.fill: parent
        spacing: 0

        Row {
            width: parent.width
            height: parent.height - actionBar.height
            spacing: 8
            padding: 10

            // A ── Crop Selection
            Rectangle {
                width:  (parent.width - 2 * 10 - 3 * 8) * 0.18
                height: parent.height - 20
                color:  state.crop >= 0 ? Qt.rgba(31,241,143,0.04) : Qt.rgba(255,255,255,0.025)
                border.color: state.crop >= 0 ? Qt.rgba(31,241,143,0.3) : Qt.rgba(255,255,255,0.07)
                border.width: 1; radius: 10; clip: true
                Behavior on color        { ColorAnimation { duration: 250 } }
                Behavior on border.color { ColorAnimation { duration: 250 } }

                Flickable {
                    anchors.fill: parent; anchors.margins: 12
                    contentHeight: colA.implicitHeight; clip: true

                    Column {
                        id: colA
                        width: parent.width

                        AGVChipGroup {
                            width: parent.width
                            label: "CROP SELECTION"; icon: "🌱"
                            options: ["Onion", "Wheat", "Soyabean", "Custom"]
                            selected: state.crop; locked: root.locked; accent: _accent
                            onSelectionChanged: (i) => state.crop = i
                        }
                    }
                }
            }

            // B ── Sowing Parameters
            Rectangle {
                width:  (parent.width - 2 * 10 - 3 * 8) * 0.24
                height: parent.height - 20
                color:  Qt.rgba(255,255,255,0.025)
                border.color: Qt.rgba(255,255,255,0.07); border.width: 1; radius: 10; clip: true

                Flickable {
                    anchors.fill: parent; anchors.margins: 12
                    contentHeight: colB.implicitHeight; clip: true

                    Column {
                        id: colB
                        width: parent.width; spacing: 0

                        Row {
                            spacing: 7; height: 28
                            Rectangle { width: 3; height: 14; radius: 2; color: _accent; anchors.verticalCenter: parent.verticalCenter }
                            Text { text: "📐"; font.pixelSize: 12; anchors.verticalCenter: parent.verticalCenter }
                            Text {
                                text: "SOWING PARAMETERS"; color: _accent
                                font.pixelSize: 8; font.weight: Font.ExtraBold; font.letterSpacing: 2; font.family: "Courier New"
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }

                        // Row Spacing
                        SliderParam { width: parent.width; icon: "↔️"; label: "Row Spacing";  unit: " cm";    sliderMin: 5;  sliderMax: 100; sliderValue: state.rowSpacing;  locked: root.locked; accent: _accent; onValueMoved: (v) => state.rowSpacing  = v }
                        SliderParam { width: parent.width; icon: "·⃣";  label: "Seed Spacing"; unit: " cm";    sliderMin: 2;  sliderMax: 50;  sliderValue: state.seedSpacing; locked: root.locked; accent: _accent; onValueMoved: (v) => state.seedSpacing = v }
                        SliderParam { width: parent.width; icon: "⬇️"; label: "Depth Control"; unit: " mm";   sliderMin: 10; sliderMax: 150; sliderValue: state.depthCtrl;   locked: root.locked; accent: _accent; onValueMoved: (v) => state.depthCtrl   = v }
                        SliderParam { width: parent.width; icon: "⚖️"; label: "Seed Rate";     unit: " KG/Ac"; sliderMin: 1;  sliderMax: 50;  sliderValue: state.seedRate;    locked: root.locked; accent: _accent; onValueMoved: (v) => state.seedRate    = v }

                        Item { height: 8; width: 1 }
                        Rectangle { width: parent.width; height: 1; color: Qt.rgba(255,255,255,0.07) }
                        Item { height: 8; width: 1 }

                        // Multi Row Mode toggle
                        Row {
                            width: parent.width; height: 30
                            Row { spacing: 6; anchors.verticalCenter: parent.verticalCenter
                                Text { text: "⋮⋮"; font.pixelSize: 12 }
                                Text { text: "Multi Row Mode"; color: Qt.rgba(255,255,255,0.6); font.pixelSize: 10 }
                            }
                            Rectangle {
                                anchors.right: parent.right; anchors.verticalCenter: parent.verticalCenter
                                width: 38; height: 19; radius: 10
                                color: state.multiRow ? Qt.rgba(31,241,143,0.4) : rgba(255,255,255,0.1)
                                border.color: state.multiRow ? _accent : Qt.rgba(255,255,255,0.12); border.width: 1
                                Behavior on color        { ColorAnimation { duration: 150 } }
                                Behavior on border.color { ColorAnimation { duration: 150 } }
                                Rectangle {
                                    width: 15; height: 15; radius: 8; y: 2
                                    x: state.multiRow ? parent.width - width - 2 : 2
                                    color: state.multiRow ? _accent : "#555555"
                                    Behavior on x     { NumberAnimation { duration: 150; easing.type: Easing.InOutQuad } }
                                    Behavior on color { ColorAnimation  { duration: 150 } }
                                }
                                MouseArea { anchors.fill: parent; cursorShape: Qt.PointingHandCursor; onClicked: if (!root.locked) state.multiRow = !state.multiRow }
                            }
                        }
                    }
                }
            }

            // C ── Field Setup
            Rectangle {
                width:  (parent.width - 2 * 10 - 3 * 8) * 0.24
                height: parent.height - 20
                color:  state.fieldSetup >= 0 ? Qt.rgba(31,241,143,0.04) : Qt.rgba(255,255,255,0.025)
                border.color: state.fieldSetup >= 0 ? Qt.rgba(31,241,143,0.3) : Qt.rgba(255,255,255,0.07)
                border.width: 1; radius: 10; clip: true
                Behavior on color        { ColorAnimation { duration: 250 } }
                Behavior on border.color { ColorAnimation { duration: 250 } }

                Flickable {
                    anchors.fill: parent; anchors.margins: 12
                    contentHeight: colC.implicitHeight; clip: true

                    Column {
                        id: colC
                        width: parent.width; spacing: 10

                        Row {
                            spacing: 7; height: 28
                            Rectangle { width: 3; height: 14; radius: 2; color: _accent; anchors.verticalCenter: parent.verticalCenter }
                            Text { text: "🗺️"; font.pixelSize: 12; anchors.verticalCenter: parent.verticalCenter }
                            Text {
                                text: "FIELD SETUP"
                                color: state.fieldSetup >= 0 ? _accent : Qt.rgba(255,255,255,0.38)
                                font.pixelSize: 8; font.weight: Font.ExtraBold; font.letterSpacing: 2; font.family: "Courier New"
                                anchors.verticalCenter: parent.verticalCenter
                                Behavior on color { ColorAnimation { duration: 200 } }
                            }
                        }

                        AGVOptionCards {
                            width: parent.width; accent: _accent; locked: root.locked
                            selected: state.fieldSetup
                            options: [
                                { icon: "🔲", label: "Field Boundary Mapping", sub: "Define field perimeter"  },
                                { icon: "↩️", label: "Auto Headland Setup",    sub: "Configure turning zones" },
                                { icon: "🚫", label: "Skip Area Selection",    sub: "Mark no-go zones"        }
                            ]
                            onSelectionChanged: (i) => state.fieldSetup = i
                        }
                    }
                }
            }

            // D ── Seed Monitoring
            Rectangle {
                width: parent.width - 2 * 10 - 3 * 8
                       - (parent.width - 2 * 10 - 3 * 8) * 0.18
                       - (parent.width - 2 * 10 - 3 * 8) * 0.24
                       - (parent.width - 2 * 10 - 3 * 8) * 0.24
                       - 3 * 8
                height: parent.height - 20
                color: rgba(255,255,255,0.025)
                border.color: rgba(255,255,255,0.07); border.width: 1; radius: 10; clip: true

                Flickable {
                    anchors.fill: parent; anchors.margins: 12
                    contentHeight: colD.implicitHeight; clip: true

                    Column {
                        id: colD
                        width: parent.width; spacing: 0

                        Row {
                            spacing: 7; height: 28
                            Rectangle { width: 3; height: 14; radius: 2; color: _accent; anchors.verticalCenter: parent.verticalCenter }
                            Text { text: "🔬"; font.pixelSize: 12; anchors.verticalCenter: parent.verticalCenter }
                            Text {
                                text: "SEED MONITORING"; color: _accent
                                font.pixelSize: 8; font.weight: Font.ExtraBold; font.letterSpacing: 2; font.family: "Courier New"
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }

                        ToggleRow { width: parent.width; icon: "🚨"; label: "Blockage Detection";   value: state.blockage;   locked: root.locked; accent: _accent; onToggled: (v) => state.blockage   = v }
                        ToggleRow { width: parent.width; icon: "⚠️"; label: "Missed Seed Alert";    value: state.missedSeed; locked: root.locked; accent: _accent; onToggled: (v) => state.missedSeed = v }
                        ToggleRow { width: parent.width; icon: "📦"; label: "Hopper Level Indicator"; value: state.hopper;   locked: root.locked; accent: _accent; onToggled: (v) => state.hopper     = v }

                        Item { height: 8; width: 1 }
                        Rectangle { width: parent.width; height: 1; color: rgba(255,255,255,0.07) }
                        Item { height: 8; width: 1 }

                        Rectangle {
                            width: parent.width; height: 34; radius: 7
                            color: calMouse.containsMouse ? rgba(255,255,255,0.05) : rgba(255,255,255,0.03)
                            border.color: rgba(255,255,255,0.08); border.width: 1
                            Behavior on color { ColorAnimation { duration: 80 } }
                            Row {
                                anchors.left: parent.left; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter; spacing: 7
                                Text { text: "🔧"; font.pixelSize: 14 }
                                Text { text: "Calibration Mode"; color: rgba(255,255,255,0.6); font.pixelSize: 11 }
                            }
                            Text { anchors.right: parent.right; anchors.rightMargin: 10; anchors.verticalCenter: parent.verticalCenter; text: "›"; color: _accent; font.pixelSize: 14 }
                            MouseArea { id: calMouse; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor; onClicked: console.log("calibration mode") }
                        }

                        Item { height: 8; width: 1 }
                        Rectangle { width: parent.width; height: 1; color: rgba(255,255,255,0.07) }
                        Item { height: 8; width: 1 }

                        AGVStatRow { width: parent.width; label: "Hopper Level"; value: root.missionActive ? "78%"   : "--"; accent: _accent }
                        AGVStatRow { width: parent.width; label: "Seeds Sown";   value: root.missionActive ? "2,480" : "--"; accent: _accent }
                        AGVStatRow { width: parent.width; label: "Row Count";    value: root.missionActive ? "14"    : "--"; accent: _accent }
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
            startLabel: "START SOWING"
            stopLabel:  "STOP SOWING"
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
                    Text { text: "📡"; font.pixelSize: 14; anchors.verticalCenter: parent.verticalCenter }
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

    // ── Private inline helpers (used only in SowPanel) ─────────────────────
    component SliderParam: Item {
        property string icon:        ""
        property string label:       ""
        property string unit:        ""
        property real   sliderMin:   0
        property real   sliderMax:   100
        property real   sliderValue: 50
        property bool   locked:      false
        property string accent:      "#1ff18f"
        signal valueMoved(real v)

        height: labelRow.height + 6 + sl.height + 10
        width: parent.width

        Row {
            id: labelRow
            width: parent.width; height: 20; anchors.top: parent.top
            Text { text: icon + "  " + label; color: Qt.rgba(255,255,255,0.6); font.pixelSize: 10; anchors.verticalCenter: parent.verticalCenter; width: parent.width * 0.65 }
            Rectangle {
                anchors.right: parent.right; anchors.verticalCenter: parent.verticalCenter
                width: 70; height: 22; radius: 5
                color: Qt.rgba(31,241,143,0.08); border.color: Qt.rgba(31,241,143,0.2); border.width: 1
                Text {
                    anchors.centerIn: parent
                    text: Math.round(sliderValue) + unit
                    color: accent; font.pixelSize: 10; font.weight: Font.Bold; font.family: "Courier New"
                }
            }
        }

        Slider {
            id: sl
            anchors.top: labelRow.bottom; anchors.topMargin: 6
            width: parent.width; from: sliderMin; to: sliderMax; value: sliderValue; height: 20
            enabled: !locked
            onValueChanged: valueMoved(value)
            background: Rectangle {
                x: sl.leftPadding; y: sl.topPadding + sl.availableHeight/2 - height/2
                width: sl.availableWidth; height: 3; radius: 2; color: Qt.rgba(255,255,255,0.1)
                Rectangle { width: sl.visualPosition * parent.width; height: parent.height; radius: 2; color: accent }
            }
            handle: Rectangle {
                x: sl.leftPadding + sl.visualPosition * (sl.availableWidth - width)
                y: sl.topPadding + sl.availableHeight/2 - height/2
                width: 16; height: 16; radius: 8
                color: sl.pressed ? accent : "#111a14"; border.color: accent; border.width: 2
            }
        }
    }

    component ToggleRow: Item {
        property string icon:   ""
        property string label:  ""
        property bool   value:  false
        property bool   locked: false
        property string accent: "#1ff18f"
        signal toggled(bool v)

        height: 30; width: parent.width

        Row {
            anchors.left: parent.left; anchors.verticalCenter: parent.verticalCenter; spacing: 6
            Text { text: icon; font.pixelSize: 12 }
            Text { text: label; color: rgba(255,255,255,0.6); font.pixelSize: 10 }
        }

        Rectangle {
            anchors.right: parent.right; anchors.verticalCenter: parent.verticalCenter
            width: 38; height: 19; radius: 10
            color: value ? rgba(31,241,143,0.4) : rgba(255,255,255,0.1)
            border.color: value ? accent : rgba(255,255,255,0.12); border.width: 1
            Behavior on color        { ColorAnimation { duration: 150 } }
            Behavior on border.color { ColorAnimation { duration: 150 } }
            Rectangle {
                width: 15; height: 15; radius: 8; y: 2
                x: value ? parent.width - width - 2 : 2
                color: value ? accent : "#555555"
                Behavior on x     { NumberAnimation { duration: 150; easing.type: Easing.InOutQuad } }
                Behavior on color { ColorAnimation  { duration: 150 } }
            }
            MouseArea { anchors.fill: parent; cursorShape: Qt.PointingHandCursor; onClicked: if (!locked) toggled(!value) }
        }
    }
}
