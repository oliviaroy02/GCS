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
    property var  th
    property string _ac:           "#1ff18f"

    // Safe fallback so th is never undefined at init
    property var _th: th ? th : ({
        bg:           "#0d0d0d",
        bgAlt:        "#1a1a1a",
        bgDeep:       "#060e09",
        surface:      Qt.rgba(255,255,255,0.03),
        surfaceHov:   Qt.rgba(255,255,255,0.06),
        border:       Qt.rgba(255,255,255,0.07),
        borderStrong: Qt.rgba(255,255,255,0.12),
        text:         "#ffffff",
        textSub:      Qt.rgba(255,255,255,0.5),
        textDim:      Qt.rgba(255,255,255,0.35),
        accent:       "#1ff18f",
        accentBg:     Qt.rgba(31/255,241/255,143/255,0.08),
        accentBorder: Qt.rgba(31/255,241/255,143/255,0.22),
        sliderTrack:  Qt.rgba(255,255,255,0.1),
        handleBg:     "#0f1a14"
    })

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

    // ── Public aliases (consumed by right panel in AGVView) ──────────────────
    property alias st_crop:        state.crop
    property alias st_fieldSetup:  state.fieldSetup
    property alias st_rowSpacing:  state.rowSpacing
    property alias st_seedSpacing: state.seedSpacing
    property alias st_depthCtrl:   state.depthCtrl
    property alias st_seedRate:    state.seedRate
    property alias st_multiRow:    state.multiRow
    property alias st_blockage:    state.blockage
    property alias st_missedSeed:  state.missedSeed
    property alias st_hopper:      state.hopper

    function _cardBg(active, hov) {
        if (!root._th) return "transparent"
        if (active) return root._th.accentBg
        if (hov)    return root._th.surfaceHov
        return root._th.surface
    }
    
    function _cardBorder(active) {
        if (!root._th) return "transparent"
        return active ? root._th.accent : root._th.border
    }

    property bool _ready: state.crop >= 0 && state.fieldSetup >= 0

    Item {
        anchors.fill: parent

        // Main content area
        Row {
            anchors.top:    parent.top
            anchors.left:   parent.left
            anchors.right:  parent.right
            anchors.bottom: actionBar.top
            spacing: 0
            // width: parent.width
            // height: parent.height - actionBar.height
            // padding: 10

            // A. Crop Selection
            Rectangle {
                width:  (parent.width - 16) /3
                height: parent.height
                color:  state.crop >= 0 ? root._th.accentBg   : root._th.surface
                border.color: state.crop >= 0 ? root._th.accentBorder : root._th.border
                border.width: 1; radius: 10; clip: true
                Behavior on color        { ColorAnimation { duration: 250 } }
                Behavior on border.color { ColorAnimation { duration: 250 } }

                Column {
                    id: colA
                    // width: parent.width
                    anchors.fill: parent
                    anchors.margins: 12
                    spacing: 8

                    // Header
                    Row {
                        width: parent.width; 
                        spacing: 8;  //height: 22
                        Rectangle { width: 3; height: 18; radius: 2; color: root._th.accent; anchors.verticalCenter: parent.verticalCenter }
                        Text { text: "🌱"; font.pixelSize: 16; anchors.verticalCenter: parent.verticalCenter }
                        Text {
                            text: "CROP SELECTION"
                            color: state.crop >= 0 ? root._th.accent : root._th.textSub
                            font.pixelSize: 11; font.weight: Font.ExtraBold
                            font.letterSpacing: 1.2; font.family: "Courier New"
                            anchors.verticalCenter: parent.verticalCenter
                            Behavior on color { ColorAnimation { duration: 200 } }
                        }
                        // Rectangle {
                        //     width: 6; height: 6; radius: 3; color: root._th.accent
                        //     anchors.verticalCenter: parent.verticalCenter
                        //     visible: state.crop >= 0
                        // }
                    }

                    Grid {
                        width: parent.width; height: parent.height
                        columns: 2; columnSpacing: 6; rowSpacing: 6

                        Repeater {
                            model: [
                                { icon: "🧅", label: "Onion"},
                                { icon: "🌾", label: "Wheat"},
                                { icon: "🫘", label: "Soyabean"},
                                { icon: "⚙️", label: "Custom"}
                            ]
                            // delegate: Rectangle {
                            //     property bool act: st.crop === index
                            //     property bool hov: false
                            //     width:  (parent.width  - 6) / 2
                            //     height: (parent.height - 6) / 2
                            //     radius: 8
                            //     color:        root._cardBg(act, hov)
                            //     border.color: root._cardBorder(act)
                            //     border.width: act ? 2 : 1
                            //     Behavior on color        { ColorAnimation { duration: 120 } }
                            //     Behavior on border.color { ColorAnimation { duration: 120 } }

                            //     Column {
                            //         anchors.centerIn: parent; spacing: 4
                            //         Text { anchors.horizontalCenter: parent.horizontalCenter; text: modelData.icon; font.pixelSize: 22 }
                            //         Text {
                            //             anchors.horizontalCenter: parent.horizontalCenter
                            //             text: modelData.label
                            //             color: act ? root._th.text : root._th.textSub
                            //             font.pixelSize: 11; font.weight: act ? Font.DemiBold : Font.Normal
                            //             Behavior on color { ColorAnimation { duration: 120 } }
                            //         }
                            //         Text {
                            //             anchors.horizontalCenter: parent.horizontalCenter
                            //             text: modelData.sub; color: root._th.textDim; font.pixelSize: 9
                            //         }
                            //     }

                            //     MouseArea {
                            //         anchors.fill: parent; hoverEnabled: true
                            //         cursorShape: root.locked ? Qt.ForbiddenCursor : Qt.PointingHandCursor
                            //         onEntered: parent.hov = true
                            //         onExited:  parent.hov = false
                            //         onClicked: { if (!root.locked) st.crop = (st.crop === index ? -1 : index) }
                            //     }
                            // }

                            delegate: BigOptionBtn {
                                width: (parent.width - 6) / 2   // 2 items, 1 gap of 6px
                                optIcon: modelData.icon
                                optLabel: modelData.label
                                active: state.crop === index
                                // th: agvView.th
                                lk: root.locked
                                // th: agvView.th
                                ac: _ac
                                onTapped: state.crop = (state.crop === index ? -1 : index)
                            }
                        }
                    }

                    // AGVChipGroup
                    //     width: parent.width
                    //     label: "CROP SELECTION"; icon: "🌱"
                    //     options: ["Onion", "Wheat", "Soyabean", "Custom"]
                    //     selected: state.crop; locked: root.locked; accent: _accentcent
                    //     onSelectionChanged: (i) => state.crop = i
                    // }
                }
            }

            // // B ── Sowing Parameters
            // Rectangle {
            //     width:  (parent.width - 2 * 10 - 3 * 8) * 0.24
            //     height: parent.height - 20
            //     color:  Qt.rgba(255,255,255,0.025)
            //     border.color: Qt.rgba(255,255,255,0.07); border.width: 1; radius: 10; clip: true

            //     Flickable {
            //         anchors.fill: parent; anchors.margins: 12
            //         contentHeight: colB.implicitHeight; clip: true

            //         Column {
            //             id: colB
            //             width: parent.width; spacing: 0

            //             Row {
            //                 spacing: 7; height: 28
            //                 Rectangle { width: 3; height: 14; radius: 2; color: _accent; anchors.verticalCenter: parent.verticalCenter }
            //                 Text { text: "📐"; font.pixelSize: 12; anchors.verticalCenter: parent.verticalCenter }
            //                 Text {
            //                     text: "SOWING PARAMETERS"; color: _accent
            //                     font.pixelSize: 8; font.weight: Font.ExtraBold; font.letterSpacing: 2; font.family: "Courier New"
            //                     anchors.verticalCenter: parent.verticalCenter
            //                 }
            //             }

            //             // Row Spacing
            //             SliderParam { width: parent.width; icon: "↔️"; label: "Row Spacing";  unit: " cm";    sliderMin: 5;  sliderMax: 100; sliderValue: state.rowSpacing;  locked: root.locked; accent: _accent; onValueMoved: (v) => state.rowSpacing  = v }
            //             SliderParam { width: parent.width; icon: "·⃣";  label: "Seed Spacing"; unit: " cm";    sliderMin: 2;  sliderMax: 50;  sliderValue: state.seedSpacing; locked: root.locked; accent: _accent; onValueMoved: (v) => state.seedSpacing = v }
            //             SliderParam { width: parent.width; icon: "⬇️"; label: "Depth Control"; unit: " mm";   sliderMin: 10; sliderMax: 150; sliderValue: state.depthCtrl;   locked: root.locked; accent: _accent; onValueMoved: (v) => state.depthCtrl   = v }
            //             SliderParam { width: parent.width; icon: "⚖️"; label: "Seed Rate";     unit: " KG/Ac"; sliderMin: 1;  sliderMax: 50;  sliderValue: state.seedRate;    locked: root.locked; accent: _accent; onValueMoved: (v) => state.seedRate    = v }

            //             Item { height: 8; width: 1 }
            //             Rectangle { width: parent.width; height: 1; color: Qt.rgba(255,255,255,0.07) }
            //             Item { height: 8; width: 1 }

            //             // Multi Row Mode toggle
            //             Row {
            //                 width: parent.width; height: 30
            //                 Row { spacing: 6; anchors.verticalCenter: parent.verticalCenter
            //                     Text { text: "⋮⋮"; font.pixelSize: 12 }
            //                     Text { text: "Multi Row Mode"; color: Qt.rgba(255,255,255,0.6); font.pixelSize: 10 }
            //                 }
            //                 Rectangle {
            //                     anchors.right: parent.right; anchors.verticalCenter: parent.verticalCenter
            //                     width: 38; height: 19; radius: 10
            //                     color: state.multiRow ? Qt.rgba(31,241,143,0.4) : Qt.rgba(255,255,255,0.1)
            //                     border.color: state.multiRow ? _accent : Qt.rgba(255,255,255,0.12); border.width: 1
            //                     Behavior on color        { ColorAnimation { duration: 150 } }
            //                     Behavior on border.color { ColorAnimation { duration: 150 } }
            //                     Rectangle {
            //                         width: 15; height: 15; radius: 8; y: 2
            //                         x: state.multiRow ? parent.width - width - 2 : 2
            //                         color: state.multiRow ? _accent : "#555555"
            //                         Behavior on x     { NumberAnimation { duration: 150; easing.type: Easing.InOutQuad } }
            //                         Behavior on color { ColorAnimation  { duration: 150 } }
            //                     }
            //                     MouseArea { anchors.fill: parent; cursorShape: Qt.PointingHandCursor; onClicked: if (!root.locked) state.multiRow = !state.multiRow }
            //                 }
            //             }
            //         }
            //     }
            // }

            // C ── Field Setup
            Rectangle {
                width:  (parent.width - 16) / 3
                height: parent.height
                color:  state.fieldSetup >= 0 ? root._th.accentBg   : root._th.surface
                border.color: state.fieldSetup >= 0 ? root._th.accentBorder : root._th.border
                border.width: 1; radius: 10; clip: true
                Behavior on color        { ColorAnimation { duration: 250 } }
                Behavior on border.color { ColorAnimation { duration: 250 } }

                Column {
                    id: colC
                    // width: parent.width; spacing: 10
                    anchors.fill: parent; anchors.margins: 12; spacing: 8

                    Row {
                        spacing: 8; width: parent.width //height: 22
                        Rectangle { width: 3; height: 18; radius: 2; color: root._th.accent; anchors.verticalCenter: parent.verticalCenter }
                        Text { text: "🗺️"; font.pixelSize: 16; anchors.verticalCenter: parent.verticalCenter }
                        Text {
                            text: "FIELD SETUP"
                            color: state.fieldSetup >= 0 ? root._th.accent : root._th.textSub
                            font.pixelSize: 12; font.weight: Font.ExtraBold; font.letterSpacing: 2; font.family: "Courier New"
                            anchors.verticalCenter: parent.verticalCenter
                            Behavior on color { ColorAnimation { duration: 200 } }
                        }

                        // Rectangle {
                        //     width: 6; height: 6; radius: 3; color: root._th.accent
                        //     anchors.verticalCenter: parent.verticalCenter
                        //     visible: state.fieldSetup >= 0
                        // }
                    }

                    // AGVOptionCards 
                    //     width: parent.width; accent: _accent; locked: root.locked
                    //     selected: state.fieldSetup
                    //     options: [
                    //         { icon: "🔲", label: "Field Boundary Mapping", sub: "Define field perimeter"  },
                    //         { icon: "↩️", label: "Auto Headland Setup",    sub: "Configure turning zones" },
                    //         { icon: "🚫", label: "Skip Area Selection",    sub: "Mark no-go zones"        }
                    //     ]
                    //     onSelectionChanged: (i) => state.fieldSetup = i
                    // }

                    Grid {
                        width: parent.width; //height: parent.height - 30
                        columns: 2; columnSpacing: 6; rowSpacing: 6

                        Repeater {
                            model: [
                                { icon: "🔲", label: "Boundary"},
                                { icon: "↩️", label: "Headland"},
                                { icon: "🚫", label: "Skip Areas"},
                                { icon: "📐", label: "Grid Lines"}
                            ]
                            // delegate: Rectangle {
                            //     property bool act: st.fieldSetup === index
                            //     property bool hov: false
                            //     width:  (parent.width  - 6) / 2
                            //     height: (parent.height - 6) / 2
                            //     radius: 8
                            //     color:        root._cardBg(act, hov)
                            //     border.color: root._cardBorder(act)
                            //     border.width: act ? 2 : 1
                            //     Behavior on color        { ColorAnimation { duration: 120 } }
                            //     Behavior on border.color { ColorAnimation { duration: 120 } }

                            //     Column {
                            //         anchors.centerIn: parent; spacing: 4
                            //         Text { anchors.horizontalCenter: parent.horizontalCenter; text: modelData.icon; font.pixelSize: 22 }
                            //         Text {
                            //             anchors.horizontalCenter: parent.horizontalCenter
                            //             text: modelData.label
                            //             color: act ? root._th.text : root._th.textSub
                            //             font.pixelSize: 11; font.weight: act ? Font.DemiBold : Font.Normal
                            //             Behavior on color { ColorAnimation { duration: 120 } }
                            //         }
                            //         Text {
                            //             anchors.horizontalCenter: parent.horizontalCenter
                            //             text: modelData.sub; color: root._th.textDim; font.pixelSize: 9
                            //         }
                            //     }

                            //     MouseArea {
                            //         anchors.fill: parent; hoverEnabled: true
                            //         cursorShape: root.locked ? Qt.ForbiddenCursor : Qt.PointingHandCursor
                            //         onEntered: parent.hov = true
                            //         onExited:  parent.hov = false
                            //         onClicked: { if (!root.locked) st.fieldSetup = (st.fieldSetup === index ? -1 : index) }
                            //     }
                            // }
                            delegate: BigOptionBtn {
                                width: (parent.width - 6) / 2   // 2 items, 1 gap of 6px
                                optIcon: modelData.icon
                                optLabel: modelData.label
                                active: state.fieldSetup === index
                                // th: agvView.th
                                lk: root.locked
                                ac: _accent
                                onTapped: state.fieldSetup = (state.fieldSetup === index ? -1 : index)
                            }
                        }
                    }
                }
            }

            // D ── Seed Monitoring
            Rectangle {
                width: (parent.width - 16) / 3
                height: parent.height
                color: root._th.surface
                border.color: root._th.border; border.width: 1; radius: 10; clip: true

                Column {
                    anchors.fill: parent; anchors.margins: 12; spacing: 8

                    Row {
                        width: parent.width; spacing: 8; height: 22
                        Rectangle { width: 3; height: 18; radius: 2; color: root._th.accent; anchors.verticalCenter: parent.verticalCenter }
                        Text { text: "🔬"; font.pixelSize: 16; anchors.verticalCenter: parent.verticalCenter }
                        Text {
                            text: "SEED MONITORING"; color: root._th.textSub
                            font.pixelSize: 12; font.weight: Font.ExtraBold; font.letterSpacing: 2; font.family: "Courier New"
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }

                    ToggleRow { width: parent.width; icon: "🚨"; label: "Blockage Detection";   value: state.blockage;   locked: root.locked; accent: _accent; onToggled: (v) => state.blockage   = v }
                    ToggleRow { width: parent.width; icon: "⚠️"; label: "Missed Seed Alert";    value: state.missedSeed; locked: root.locked; accent: _accent; onToggled: (v) => state.missedSeed = v }
                    ToggleRow { width: parent.width; icon: "📦"; label: "Hopper Level Indicator"; value: state.hopper;   locked: root.locked; accent: _accent; onToggled: (v) => state.hopper     = v }

                    // Item { height: 8; width: 1 }
                    // Rectangle { width: parent.width; height: 1; color: Qt.rgba(255,255,255,0.07) }
                    // Item { height: 8; width: 1 }

                    // Rectangle {
                    //     width: parent.width; height: 34; radius: 7
                    //     color: calMouse.containsMouse ? Qt.rgba(255,255,255,0.05) : Qt.rgba(255,255,255,0.03)
                    //     border.color: Qt.rgba(255,255,255,0.08); border.width: 1
                    //     Behavior on color { ColorAnimation { duration: 80 } }
                    //     Row {
                    //         anchors.left: parent.left; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter; spacing: 7
                    //         Text { text: "🔧"; font.pixelSize: 14 }
                    //         Text { text: "Calibration Mode"; color: Qt.rgba(255,255,255,0.6); font.pixelSize: 11 }
                    //     }
                    //     Text { anchors.right: parent.right; anchors.rightMargin: 10; anchors.verticalCenter: parent.verticalCenter; text: "›"; color: _accent; font.pixelSize: 14 }
                    //     MouseArea { id: calMouse; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor; onClicked: console.log("calibration mode") }
                    // }

                    // Item { height: 8; width: 1 }
                    // Rectangle { width: parent.width; height: 1; color: Qt.rgba(255,255,255,0.07) }
                    // Item { height: 8; width: 1 }

                    // AGVStatRow { width: parent.width; label: "Hopper Level"; value: root.missionActive ? "78%"   : "--"; accent: _accent }
                    // AGVStatRow { width: parent.width; label: "Seeds Sown";   value: root.missionActive ? "2,480" : "--"; accent: _accent }
                    // AGVStatRow { width: parent.width; label: "Row Count";    value: root.missionActive ? "14"    : "--"; accent: _accent }
                }
            }
        }

        Rectangle { width: 1; height: parent.height; color: Qt.rgba(255,255,255,0.06) }

        // Action bar
        AGVActionBar {
            id: actionBar
            anchors.left:   parent.left
            anchors.right:  parent.right
            anchors.bottom: parent.bottom
            height: 60
            // width: parent.width
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
            Text { text: label; color: Qt.rgba(255,255,255,0.6); font.pixelSize: 10 }
        }

        Rectangle {
            anchors.right: parent.right; anchors.verticalCenter: parent.verticalCenter
            width: 38; height: 19; radius: 10
            color: value ? Qt.rgba(31,241,143,0.4) : Qt.rgba(255,255,255,0.1)
            border.color: value ? accent : Qt.rgba(255,255,255,0.12); border.width: 1
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
