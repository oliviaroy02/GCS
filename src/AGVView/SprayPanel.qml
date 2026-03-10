// C:\NestLink\GCS\src\AGVView\SprayPanel.qml
import QtQuick
import QtQuick.Controls

Rectangle {
    id: root
    color: "#0d0d0d"

    property bool   missionActive: false
    property bool   locked:        false
    property string _ac:           "#1ff18f"
    property alias st_fieldAction: st.fieldAction
    property alias st_logging:     st.logging
    // property var th       // receives agvView.th
    // property bool darkTheme: true

    signal missionStartRequested
    signal missionStopRequested

    QtObject {
        id: st
        property int  sprayType:   -1
        property int  sprayMode:   -1
        property real pumpSpeed:    50
        property bool varSpray:     false
        property int  fieldAction: -1
        property bool logging:      true
        function clear() { sprayType=-1; sprayMode=-1; fieldAction=-1; pumpSpeed=50; varSpray=false }
    }

    property bool _ready: st.sprayType >= 0 && st.sprayMode >= 0 && st.fieldAction >= 0

    // Column {
    Item {
        anchors.fill: parent

        // Main content area
        Row {
            anchors.top:    parent.top
            anchors.left:   parent.left
            anchors.right:  parent.right
            anchors.bottom: actionBar.top   // ← key: stop at action bar top
            spacing: 0

            // A. Spray Type (30%)
            Rectangle {
                width: parent.width * 0.30
                height: parent.height
                color: st.sprayType >= 0 ? Qt.rgba(31/255,241/255,143/255,0.04) : "#0d0d0d"
                border.color: st.sprayType >= 0 ? Qt.rgba(31/255,241/255,143/255,0.35) : Qt.rgba(255,255,255,0.07)
                border.width: 1
                Behavior on color        { ColorAnimation { duration: 200 } }
                Behavior on border.color { ColorAnimation { duration: 200 } }

                Column {
                    anchors.fill: parent
                    anchors.margins: 12
                    spacing: 8

                    // Header
                    Row {
                        width: parent.width
                        spacing: 8
                        Rectangle { width: 3; height: 16; radius: 2; color: _ac; anchors.verticalCenter: parent.verticalCenter }
                        Text { text: "💧"; font.pixelSize: 16; anchors.verticalCenter: parent.verticalCenter }
                        Text {
                            text: "SPRAY TYPE"
                            color: st.sprayType >= 0 ? _ac : Qt.rgba(255,255,255,0.5)
                            font.pixelSize: 9; font.weight: Font.ExtraBold
                            font.letterSpacing: 1.5; font.family: "Courier New"
                            anchors.verticalCenter: parent.verticalCenter
                            Behavior on color { ColorAnimation { duration: 200 } }
                        }
                    }

                    // Options
                    Grid {
                        width: parent.width
                        columns: 2
                        spacing: 6

                        Repeater {
                            model: [
                                { icon: "🧴", label: "Herbicide" },
                                { icon: "🐛", label: "Pesticide" },
                                { icon: "🍄", label: "Fungicide" },
                                { icon: "💊", label: "Liquid Fert." }
                            ]
                            delegate: BigOptionBtn {
                                width: (parent.width - 6) / 2   // 2 items, 1 gap of 6px
                                optIcon: modelData.icon
                                optLabel: modelData.label
                                // th: agvView.th
                                active: st.sprayType === index
                                lk: root.locked
                                ac: _ac
                                onTapped: st.sprayType = (st.sprayType === index ? -1 : index)
                            }
                        }
                    }
                }
            }

            Rectangle { width: 1; height: parent.height; color: Qt.rgba(255,255,255,0.06) }

            // B. Spray Mode (30%)
            Rectangle {
                width: parent.width * 0.30
                height: parent.height
                color: st.sprayMode >= 0 ? Qt.rgba(31/255,241/255,143/255,0.04) : "#0d0d0d"
                border.color: st.sprayMode >= 0 ? Qt.rgba(31/255,241/255,143/255,0.35) : Qt.rgba(255,255,255,0.07)
                border.width: 1
                Behavior on color        { ColorAnimation { duration: 200 } }
                Behavior on border.color { ColorAnimation { duration: 200 } }

                Column {
                    anchors.fill: parent
                    anchors.margins: 12
                    spacing: 8

                    Row {
                        width: parent.width
                        spacing: 8
                        Rectangle { width: 3; height: 16; radius: 2; color: _ac; anchors.verticalCenter: parent.verticalCenter }
                        Text { text: "⚙️"; font.pixelSize: 16; anchors.verticalCenter: parent.verticalCenter }
                        Text {
                            text: "SPRAY MODE"
                            color: st.sprayMode >= 0 ? _ac : Qt.rgba(255,255,255,0.5)
                            font.pixelSize: 9; font.weight: Font.ExtraBold
                            font.letterSpacing: 1.5; font.family: "Courier New"
                            anchors.verticalCenter: parent.verticalCenter
                            Behavior on color { ColorAnimation { duration: 200 } }
                        }
                    }

                    // Options
                    Grid {
                        width: parent.width
                        columns: 2
                        spacing: 6

                        Repeater {
                            model: [
                                { icon: "🕹️", label: "Manual" },
                                { icon: "🤖", label: "Autonomous" },
                                { icon: "📍", label: "A-B Mode" }
                            ]
                            delegate: BigOptionBtn {
                                width: (parent.width - 6) / 2   // 2 items, 1 gap of 6px
                                optIcon: modelData.icon
                                optLabel: modelData.label
                                active: st.sprayMode === index
                                lk: root.locked
                                ac: _ac
                                // th: agvView.th
                                onTapped: st.sprayMode = (st.sprayMode === index ? -1 : index)
                            }
                        }
                    }
                }
            }

            Rectangle { width: 1; height: parent.height; color: Qt.rgba(255,255,255,0.06) }

            // C. Parameters
            Rectangle {
                width: parent.width * 0.40
                height: parent.height
                color: "#0d0d0d"
                border.color: Qt.rgba(255,255,255,0.07)
                border.width: 1

                Column {
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 8

                    // Header
                    Row {
                        width: parent.width
                        spacing: 8
                        Rectangle { width: 3; height: 14; radius: 2; color: _ac; anchors.verticalCenter: parent.verticalCenter }
                        Text { text: "🔧"; font.pixelSize: 14; anchors.verticalCenter: parent.verticalCenter }
                        Text {
                            text: "PARAMETERS"
                            color: Qt.rgba(255,255,255,0.5)
                            font.pixelSize: 9; font.weight: Font.ExtraBold
                            font.letterSpacing: 1.5; font.family: "Courier New"
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }

                    // 2x2 Grid - fills remaining height after header
                    Grid {
                        width: parent.width
                        height: parent.height - 30  // subtract header height + spacing
                        columns: 2
                        columnSpacing: 6
                        rowSpacing: 6

                        // Pump Speed card
                        Rectangle {
                            width:  (parent.width - 6) / 2
                            height: (parent.height - 6) / 2
                            radius: 8
                            color: Qt.rgba(255,255,255,0.03)
                            border.color: Qt.rgba(255,255,255,0.08); border.width: 1

                            Column {
                                anchors.fill: parent
                                anchors.margins: 8
                                spacing: 4

                                Text {
                                    text: "⟳  PUMP SPEED"
                                    color: Qt.rgba(255,255,255,0.4)
                                    font.pixelSize: 9; font.weight: Font.Bold
                                    font.letterSpacing: 1; font.family: "Courier New"
                                }

                                Text {
                                    text: Math.round(pumpSl.value) + "%"
                                    color: _ac
                                    font.pixelSize: 16; font.weight: Font.Bold; font.family: "Courier New"
                                }

                                Slider {
                                    id: pumpSl
                                    width: parent.width
                                    from: 0; to: 100; value: st.pumpSpeed
                                    height: 16
                                    enabled: !root.locked
                                    onValueChanged: st.pumpSpeed = value

                                    background: Rectangle {
                                        x: pumpSl.leftPadding
                                        y: pumpSl.topPadding + pumpSl.availableHeight/2 - height/2
                                        width: pumpSl.availableWidth; height: 3; radius: 2
                                        color: Qt.rgba(255,255,255,0.1)
                                        Rectangle {
                                            width: pumpSl.visualPosition * parent.width
                                            height: parent.height; radius: 2; color: _ac
                                        }
                                    }

                                    handle: Rectangle {
                                        x: pumpSl.leftPadding + pumpSl.visualPosition * (pumpSl.availableWidth - width)
                                        y: pumpSl.topPadding  + pumpSl.availableHeight/2 - height/2
                                        width: 12; height: 12; radius: 6
                                        color: pumpSl.pressed ? _ac : "#0f1a14"
                                        border.color: _ac; border.width: 2
                                        Behavior on color { ColorAnimation { duration: 100 } }
                                    }
                                }
                            }
                        }

                        // Flow Rate card
                        Rectangle {
                            width:  (parent.width - 6) / 2
                            height: (parent.height - 6) / 2
                            radius: 8
                            color: Qt.rgba(31/255,241/255,143/255,0.05)
                            border.color: Qt.rgba(31/255,241/255,143/255,0.15); border.width: 1

                            Column {
                                anchors.fill: parent
                                anchors.margins: 8
                                spacing: 4

                                Text {
                                    text: "💧  FLOW RATE"
                                    color: Qt.rgba(255,255,255,0.4)
                                    font.pixelSize: 9; font.weight: Font.Bold
                                    font.letterSpacing: 1; font.family: "Courier New"
                                }

                                Row {
                                    spacing: 3
                                    Text {
                                        text: (st.pumpSpeed * 0.08).toFixed(1)
                                        color: _ac; font.pixelSize: 16; font.weight: Font.Bold; font.family: "Courier New"
                                    }
                                    Text {
                                        text: "L/min"; color: Qt.rgba(255,255,255,0.4); font.pixelSize: 9
                                        anchors.bottom: parent.bottom; anchors.bottomMargin: 1
                                    }
                                }
                            }
                        }

                        // Variable Spray card
                        Rectangle {
                            width:  (parent.width - 6) / 2
                            height: (parent.height - 6) / 2
                            radius: 8
                            color: st.varSpray ? Qt.rgba(31/255,241/255,143/255,0.06) : Qt.rgba(255,255,255,0.03)
                            border.color: st.varSpray ? Qt.rgba(31/255,241/255,143/255,0.3) : Qt.rgba(255,255,255,0.08)
                            border.width: 1
                            Behavior on color        { ColorAnimation { duration: 150 } }
                            Behavior on border.color { ColorAnimation { duration: 150 } }

                            Column {
                                anchors.fill: parent
                                anchors.margins: 8
                                spacing: 4

                                Text {
                                    text: "〰️  VARIABLE SPRAY"
                                    color: Qt.rgba(255,255,255,0.4)
                                    font.pixelSize: 9; font.weight: Font.Bold
                                    font.letterSpacing: 1; font.family: "Courier New"
                                }

                                Rectangle {
                                    width: 38; height: 20; radius: 10
                                    color: st.varSpray ? Qt.rgba(31/255,241/255,143/255,0.4) : Qt.rgba(255,255,255,0.1)
                                    border.color: st.varSpray ? _ac : Qt.rgba(255,255,255,0.12); border.width: 1
                                    Behavior on color        { ColorAnimation { duration: 150 } }
                                    Behavior on border.color { ColorAnimation { duration: 150 } }

                                    Rectangle {
                                        width: 14; height: 14; radius: 7; y: 3
                                        x: st.varSpray ? parent.width - width - 3 : 3
                                        color: st.varSpray ? _ac : "#666666"
                                        Behavior on x     { NumberAnimation { duration: 150; easing.type: Easing.InOutQuad } }
                                        Behavior on color { ColorAnimation  { duration: 150 } }
                                    }
                                    MouseArea {
                                        anchors.fill: parent; cursorShape: Qt.PointingHandCursor
                                        onClicked: if (!root.locked) st.varSpray = !st.varSpray
                                    }
                                }
                            }
                        }

                        // Pressure card
                        Rectangle {
                            width:  (parent.width - 6) / 2
                            height: (parent.height - 6) / 2
                            radius: 8
                            color: Qt.rgba(31/255,241/255,143/255,0.05)
                            border.color: Qt.rgba(31/255,241/255,143/255,0.15); border.width: 1

                            Column {
                                anchors.fill: parent
                                anchors.margins: 8
                                spacing: 4

                                Text {
                                    text: "🔵  PRESSURE"
                                    color: Qt.rgba(255,255,255,0.4)
                                    font.pixelSize: 9; font.weight: Font.Bold
                                    font.letterSpacing: 1; font.family: "Courier New"
                                }

                                Row {
                                    spacing: 3
                                    Text {
                                        text: (st.pumpSpeed * 0.03 + 0.5).toFixed(1)
                                        color: _ac; font.pixelSize: 16; font.weight: Font.Bold; font.family: "Courier New"
                                    }
                                    Text {
                                        text: "bar"; color: Qt.rgba(255,255,255,0.4); font.pixelSize: 9
                                        anchors.bottom: parent.bottom; anchors.bottomMargin: 1
                                    }
                                }
                            }
                        }
                    }
                }
            }

            Rectangle { width: 1; height: parent.height; color: Qt.rgba(255,255,255,0.06) }

            // // D. Field & Navigation (24%)
            // Rectangle {
            //     width: parent.width * 0.24
            //     height: parent.height
            //     color: st.fieldAction >= 0 ? Qt.rgba(31/255,241/255,143/255,0.04) : "#0d0d0d"
            //     border.color: st.fieldAction >= 0 ? Qt.rgba(31/255,241/255,143/255,0.35) : Qt.rgba(255,255,255,0.07)
            //     border.width: 1
            //     Behavior on color        { ColorAnimation { duration: 200 } }
            //     Behavior on border.color { ColorAnimation { duration: 200 } }

            //     Column {
            //         anchors.fill: parent
            //         anchors.margins: 12
            //         spacing: 8

            //         Row {
            //             width: parent.width
            //             spacing: 8
            //             Rectangle { width: 3; height: 16; radius: 2; color: _ac; anchors.verticalCenter: parent.verticalCenter }
            //             Text { text: "🗺️"; font.pixelSize: 16; anchors.verticalCenter: parent.verticalCenter }
            //             Text {
            //                 text: "FIELD & NAV"
            //                 color: st.fieldAction >= 0 ? _ac : Qt.rgba(255,255,255,0.5)
            //                 font.pixelSize: 9; font.weight: Font.ExtraBold
            //                 font.letterSpacing: 1.5; font.family: "Courier New"
            //                 anchors.verticalCenter: parent.verticalCenter
            //                 Behavior on color { ColorAnimation { duration: 200 } }
            //             }
            //         }

            //         Repeater {
            //             model: [
            //                 { icon: "📂", label: "Select Saved Field", sub: "Load boundary" },
            //                 { icon: "✏️", label: "Create New Field", sub: "Draw boundary" },
            //                 { icon: "🛰️", label: "Auto Path Planning", sub: "Optimal route" }
            //             ]
            //             delegate: Rectangle {
            //                 property bool act: st.fieldAction === index
            //                 width: parent.width
            //                 height: 50
            //                 radius: 8
            //                 color: act ? Qt.rgba(31/255,241/255,143/255,0.12) :
            //                        fm.containsMouse && !root.locked ? Qt.rgba(255,255,255,0.06) :
            //                        Qt.rgba(255,255,255,0.02)
            //                 border.color: act ? _ac : Qt.rgba(255,255,255,0.08)
            //                 border.width: act ? 2 : 1
            //                 opacity: root.locked && !act ? 0.35 : 1
            //                 Behavior on color        { ColorAnimation { duration: 100 } }
            //                 Behavior on border.color { ColorAnimation { duration: 100 } }

            //                 Row {
            //                     anchors.left: parent.left
            //                     anchors.leftMargin: 12
            //                     anchors.verticalCenter: parent.verticalCenter
            //                     spacing: 10

            //                     Text {
            //                         text: modelData.icon
            //                         font.pixelSize: 20
            //                         anchors.verticalCenter: parent.verticalCenter
            //                     }

            //                     Column {
            //                         anchors.verticalCenter: parent.verticalCenter
            //                         spacing: 2

            //                         Text {
            //                             text: modelData.label
            //                             color: act ? "#ffffff" : Qt.rgba(255,255,255,0.7)
            //                             font.pixelSize: 12
            //                             font.weight: act ? Font.DemiBold : Font.Normal
            //                             Behavior on color { ColorAnimation { duration: 100 } }
            //                         }

            //                         Text {
            //                             text: modelData.sub
            //                             color: Qt.rgba(255,255,255,0.35)
            //                             font.pixelSize: 9
            //                         }
            //                     }
            //                 }

            //                 Rectangle {
            //                     anchors.right: parent.right
            //                     anchors.rightMargin: 12
            //                     anchors.verticalCenter: parent.verticalCenter
            //                     width: 20; height: 20; radius: 10
            //                     color: act ? _ac : "transparent"
            //                     border.color: act ? _ac : Qt.rgba(255,255,255,0.2)
            //                     border.width: 1
            //                     Behavior on color { ColorAnimation { duration: 100 } }

            //                     Text {
            //                         anchors.centerIn: parent
            //                         text: "✓"
            //                         color: act ? "#0f1a14" : Qt.rgba(255,255,255,0.15)
            //                         font.pixelSize: 10
            //                         font.weight: Font.Bold
            //                     }
            //                 }

            //                 MouseArea {
            //                     id: fm
            //                     anchors.fill: parent
            //                     hoverEnabled: true
            //                     cursorShape: root.locked ? Qt.ForbiddenCursor : Qt.PointingHandCursor
            //                     enabled: !root.locked
            //                     onClicked: st.fieldAction = (st.fieldAction === index ? -1 : index)
            //                 }
            //             }
            //         }
            //     }
            // }

            // Rectangle { width: 1; height: parent.height; color: Qt.rgba(255,255,255,0.06) }

            // // E. Advanced (remaining width)
            // Rectangle {
            //     width: parent.width - (parent.width * 0.20) - (parent.width * 0.18) - (parent.width * 0.22) - (parent.width * 0.24) - 4
            //     height: parent.height
            //     color: "#0d0d0d"
            //     border.color: Qt.rgba(255,255,255,0.07)
            //     border.width: 1

            //     Column {
            //         anchors.fill: parent
            //         anchors.margins: 12
            //         spacing: 8

            //         Row {
            //             width: parent.width
            //             spacing: 8
            //             Rectangle { width: 3; height: 16; radius: 2; color: _ac; anchors.verticalCenter: parent.verticalCenter }
            //             Text { text: "⚗️"; font.pixelSize: 16; anchors.verticalCenter: parent.verticalCenter }
            //             Text {
            //                 text: "ADVANCED"
            //                 color: Qt.rgba(255,255,255,0.5)
            //                 font.pixelSize: 9; font.weight: Font.ExtraBold
            //                 font.letterSpacing: 1.5; font.family: "Courier New"
            //                 anchors.verticalCenter: parent.verticalCenter
            //             }
            //         }

            //         // Spray Logging
            //         Rectangle {
            //             width: parent.width
            //             height: 48
            //             radius: 8
            //             color: Qt.rgba(255,255,255,0.03)
            //             border.color: Qt.rgba(255,255,255,0.08)
            //             border.width: 1

            //             Row {
            //                 anchors.left: parent.left
            //                 anchors.leftMargin: 12
            //                 anchors.verticalCenter: parent.verticalCenter
            //                 spacing: 10

            //                 Text {
            //                     text: "📋"
            //                     font.pixelSize: 18
            //                 }

            //                 Column {
            //                     anchors.verticalCenter: parent.verticalCenter
            //                     spacing: 2

            //                     Text {
            //                         text: "Spray Logging"
            //                         color: Qt.rgba(255,255,255,0.8)
            //                         font.pixelSize: 12
            //                         font.weight: Font.DemiBold
            //                     }

            //                     Text {
            //                         text: "Record session data"
            //                         color: Qt.rgba(255,255,255,0.35)
            //                         font.pixelSize: 9
            //                     }
            //                 }
            //             }

            //             Rectangle {
            //                 anchors.right: parent.right
            //                 anchors.rightMargin: 12
            //                 anchors.verticalCenter: parent.verticalCenter
            //                 width: 44; height: 24; radius: 12
            //                 color: st.logging ? Qt.rgba(31/255,241/255,143/255,0.4) : Qt.rgba(255,255,255,0.1)
            //                 border.color: st.logging ? _ac : Qt.rgba(255,255,255,0.12)
            //                 border.width: 1
            //                 Behavior on color        { ColorAnimation { duration: 150 } }
            //                 Behavior on border.color { ColorAnimation { duration: 150 } }

            //                 Rectangle {
            //                     width: 18; height: 18; radius: 9; y: 3
            //                     x: st.logging ? parent.width - width - 3 : 3
            //                     color: st.logging ? _ac : "#666666"
            //                     Behavior on x     { NumberAnimation { duration: 150; easing.type: Easing.InOutQuad } }
            //                     Behavior on color { ColorAnimation  { duration: 150 } }
            //                 }

            //                 MouseArea {
            //                     anchors.fill: parent
            //                     cursorShape: Qt.PointingHandCursor
            //                     onClicked: st.logging = !st.logging
            //                 }
            //             }
            //         }

            //         // PDF Report
            //         Rectangle {
            //             width: parent.width
            //             height: 44
            //             radius: 8
            //             color: rM.containsMouse ? Qt.rgba(255,255,255,0.06) : Qt.rgba(255,255,255,0.02)
            //             border.color: rM.containsMouse ? Qt.rgba(31/255,241/255,143/255,0.3) : Qt.rgba(255,255,255,0.08)
            //             border.width: 1
            //             Behavior on color        { ColorAnimation { duration: 80 } }
            //             Behavior on border.color { ColorAnimation { duration: 80 } }

            //             Row {
            //                 anchors.left: parent.left
            //                 anchors.leftMargin: 12
            //                 anchors.verticalCenter: parent.verticalCenter
            //                 spacing: 10

            //                 Text {
            //                     text: "📊"
            //                     font.pixelSize: 18
            //                 }

            //                 Text {
            //                     text: "Generate PDF Report"
            //                     color: rM.containsMouse ? "#ffffff" : Qt.rgba(255,255,255,0.65)
            //                     font.pixelSize: 12
            //                     Behavior on color { ColorAnimation { duration: 80 } }
            //                 }
            //             }

            //             Text {
            //                 anchors.right: parent.right
            //                 anchors.rightMargin: 12
            //                 anchors.verticalCenter: parent.verticalCenter
            //                 text: "›"
            //                 color: _ac
            //                 font.pixelSize: 18
            //             }

            //             MouseArea {
            //                 id: rM
            //                 anchors.fill: parent
            //                 hoverEnabled: true
            //                 cursorShape: Qt.PointingHandCursor
            //             }
            //         }

            //         Rectangle { width: parent.width; height: 1; color: Qt.rgba(255,255,255,0.06) }

            //         // Stats
            //         Repeater {
            //             model: [
            //                 { lbl: "Coverage", val: root.missionActive ? "18%" : "--" },
            //                 { lbl: "Chemical Used", val: root.missionActive ? "12.5 Lt" : "--" },
            //                 { lbl: "Tank Level", val: root.missionActive ? "75%" : "--" }
            //             ]
            //             delegate: Row {
            //                 width: parent.width
            //                 height: 26

            //                 Text {
            //                     text: modelData.lbl
            //                     color: Qt.rgba(255,255,255,0.45)
            //                     font.pixelSize: 11
            //                     anchors.verticalCenter: parent.verticalCenter
            //                     width: parent.width * 0.55
            //                 }

            //                 Text {
            //                     anchors.right: parent.right
            //                     anchors.verticalCenter: parent.verticalCenter
            //                     text: modelData.val
            //                     color: _ac
            //                     font.pixelSize: 13
            //                     font.weight: Font.Bold
            //                     font.family: "Courier New"
            //                 }
            //             }
            //         }
            //     }
            // }
        }

        Rectangle { width: 1; height: parent.height; color: Qt.rgba(255,255,255,0.06) }

        // Action Bar (60px height)
        AGVActionBar {
            id: actionBar
            anchors.left:   parent.left
            anchors.right:  parent.right
            anchors.bottom: parent.bottom
            // width: parent.width
            height: 60
            // anchors.bottom: parent.bottom
            ready: root._ready
            missionActive: root.missionActive
            locked: root.locked
            startLabel: "START SPRAY"
            stopLabel: "STOP SPRAY"
            accent: _ac
            onStartClicked: root.missionStartRequested()
            onStopClicked: root.missionStopRequested()
            onClearClicked: st.clear()
            onEmergencyClicked: root.missionStopRequested()

            Rectangle {
                property bool hov: false
                width: 140
                height: 42
                radius: 8
                color: hov ? Qt.rgba(255,255,255,0.08) : Qt.rgba(255,255,255,0.03)
                border.color: Qt.rgba(255,255,255,0.12)
                border.width: 1
                Behavior on color { ColorAnimation { duration: 120 } }

                Row {
                    anchors.centerIn: parent
                    spacing: 8

                    Text {
                        text: "⟳"
                        font.pixelSize: 18
                        color: Qt.rgba(255,255,255,0.7)
                    }

                    Text {
                        text: "Prime Pump"
                        color: Qt.rgba(255,255,255,0.7)
                        font.pixelSize: 13
                        font.weight: Font.DemiBold
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onEntered: parent.hov = true
                    onExited: parent.hov = false
                    onClicked: console.log("prime pump")
                }
            }
        }
    }
}
