// C:\NestLink\GCS\src\AGVView\HarvestPanel.qml
import QtQuick
import QtQuick.Controls

Item {
    id: root

    property bool missionActive: false
    property bool locked:        false
    property var  th             // receives agvView.th
    property bool darkTheme:     true
    property string _ac:           "#1ff18f"
    property string accent:       "#1ff18f"
    property string accentBg:     Qt.rgba(31/255,241/255,143/255,0.08)
    property string surface:      Qt.rgba(0,0,0,0.04)
    property string surfaceHov:   Qt.rgba(0,0,0,0.08)
    

    signal missionStartRequested()
    signal missionStopRequested()

    // ── State ────────────────────────────────────────────────────────────────
    QtObject {
        id: st
        property int  detectMode: -1
        property int  weedType:   -1
        property int  opMode:     -1
        property real bladeSpeed: 1500
        property real cutDepth:   50
        function clear() { detectMode=-1; weedType=-1; opMode=-1; bladeSpeed=1500; cutDepth=50 }
    }

    // Expose to AGVView right panel
    property alias st_detectMode: st.detectMode
    property alias st_weedType:   st.weedType
    property alias st_opMode:     st.opMode
    property alias st_bladeSpeed: st.bladeSpeed
    property alias st_cutDepth:   st.cutDepth
    property bool  _ready: st.detectMode >= 0 && st.weedType >= 0 && st.opMode >= 0

    // ── Helpers ──────────────────────────────────────────────────────────────
    function _cardColor(active, hov) {
        if (active) return accentBg
        if (hov)    return surfaceHov
        return surface
    }
    function _borderColor(active) {
        return active ? accent : root.th.border
    }

    // ── Content area (above action bar) ─────────────────────────────────────
    Item {
        id: contentArea
        anchors.left:   parent.left
        anchors.right:  parent.right
        anchors.top:    parent.top
        anchors.bottom: actionBar.top

        Row {
            anchors.fill:    parent
            anchors.margins: 10
            spacing: 8

            // ═══════════════════════════════════════════════════════════════
            // A  DETECTION MODE  (2×2 grid)
            // ═══════════════════════════════════════════════════════════════
            Rectangle {
                width:  (parent.width - 16) / 3
                height: parent.height
                radius: 10
                color:   st.detectMode >= 0 ? Qt.rgba(31/255,241/255,143/255,0.04) : "#0d0d0d" //st.detectMode >= 0 ? accentBg   : root.th.surface
                border.color: st.detectMode >= 0 ? Qt.rgba(31/255,241/255,143/255,0.35) : Qt.rgba(255,255,255,0.07)  //st.detectMode >= 0 ? accentBorder : root.th.border
                border.width: 1
                Behavior on color        { ColorAnimation { duration: 200 } }
                Behavior on border.color { ColorAnimation { duration: 200 } }

                Column {
                    anchors.fill:    parent
                    anchors.margins: 12
                    spacing: 8

                    // Section header
                    Row {
                        width: parent.width
                        spacing: 8
                        Rectangle { width: 3; height: 18; radius: 2; color: accent; anchors.verticalCenter: parent.verticalCenter }
                        Text { text: "👁️"; font.pixelSize: 16; anchors.verticalCenter: parent.verticalCenter }
                        Text {
                            text: "DETECTION MODE"
                            color: st.detectMode >= 0 ? accent : Qt.rgba(255,255,255,0.5)
                            font.pixelSize: 11; font.weight: Font.ExtraBold
                            font.letterSpacing: 1.2; font.family: "Courier New"
                            anchors.verticalCenter: parent.verticalCenter
                            Behavior on color { ColorAnimation { duration: 200 } }
                        }
                        Rectangle {
                            width: 6; height: 6; radius: 3; color: accent
                            anchors.verticalCenter: parent.verticalCenter
                            visible: st.detectMode >= 0
                        }
                    }

                    // 2×2 option cards
                    Grid {
                        width: parent.width
                        height: parent.height - 34
                        columns: 2
                        columnSpacing: 6
                        rowSpacing:    6

                        Repeater {
                            model: [
                                { icon: "🤖", label: "AI Vision",     sub: "Camera detection"   },
                                { icon: "🗺️", label: "Pre-Mapped",    sub: "Zone boundaries"    },
                                { icon: "✋", label: "Manual Select", sub: "User-defined areas" }
                            ]
                            // delegate: Rectangle {
                            //     property bool act: st.detectMode === index
                            //     property bool hov: false
                            //     width:  (parent.width  - 6) / 2
                            //     height: (parent.height - 6) / 2
                            //     radius: 8
                            //     color: root._cardColor(act, hov)
                            //     border.color: root._borderColor(act)
                            //     border.width: act ? 2 : 1
                            //     Behavior on color        { ColorAnimation { duration: 100 } }
                            //     Behavior on border.color { ColorAnimation { duration: 100 } }

                            //     Column {
                            //         anchors.centerIn: parent
                            //         spacing: 4
                            //         Text { anchors.horizontalCenter: parent.horizontalCenter; text: modelData.icon; font.pixelSize: 20 }
                            //         Text {
                            //             anchors.horizontalCenter: parent.horizontalCenter
                            //             text: modelData.label
                            //             color: act ? root.th.text : root.th.textSub
                            //             font.pixelSize: 11; font.weight: act ? Font.DemiBold : Font.Normal
                            //             Behavior on color { ColorAnimation { duration: 100 } }
                            //         }
                            //         Text { anchors.horizontalCenter: parent.horizontalCenter; text: modelData.sub; color: root.th.textDim; font.pixelSize: 9 }
                            //     }

                            //     MouseArea {
                            //         anchors.fill: parent; hoverEnabled: true
                            //         cursorShape: root.locked ? Qt.ForbiddenCursor : Qt.PointingHandCursor
                            //         onEntered: parent.hov = true
                            //         onExited:  parent.hov = false
                            //         onClicked: { if (!root.locked) st.detectMode = (st.detectMode === index ? -1 : index) }
                            //     }
                            // }

                            delegate: BigOptionBtn {
                                width: (parent.width - 6) / 2   // 2 items, 1 gap of 6px
                                optIcon: modelData.icon
                                optLabel: modelData.label
                                active: st.detectMode === index
                                lk: root.locked
                                // th: agvView.th
                                ac: _ac
                                onTapped: st.detectMode = (st.sprayType === index ? -1 : index)
                            }
                        }
                    }
                }
            }

            // ═══════════════════════════════════════════════════════════════
            // B  WEED TYPE  (2×2 grid)
            // ═══════════════════════════════════════════════════════════════
            Rectangle {
                width:  (parent.width - 16) / 3
                height: parent.height
                radius: 10
                color:  st.weedType >= 0 ? Qt.rgba(31/255,241/255,143/255,0.04) : "#0d0d0d"
                border.color: st.weedType >= 0 ? Qt.rgba(31/255,241/255,143/255,0.35) : Qt.rgba(255,255,255,0.07)
                border.width: 1
                Behavior on color        { ColorAnimation { duration: 200 } }
                Behavior on border.color { ColorAnimation { duration: 200 } }

                Column {
                    anchors.fill:    parent
                    anchors.margins: 12
                    spacing: 8

                    Row {
                        width: parent.width
                        spacing: 8
                        Rectangle { width: 3; height: 18; radius: 2; color: accent; anchors.verticalCenter: parent.verticalCenter }
                        Text { text: "🌿"; font.pixelSize: 16; anchors.verticalCenter: parent.verticalCenter }
                        Text {
                            text: "WEED TYPE"
                            color: st.weedType >= 0 ? accent : Qt.rgba(255,255,255,0.5)
                            font.pixelSize: 11; font.weight: Font.ExtraBold
                            font.letterSpacing: 1.2; font.family: "Courier New"
                            anchors.verticalCenter: parent.verticalCenter
                            Behavior on color { ColorAnimation { duration: 200 } }
                        }
                        Rectangle {
                            width: 6; height: 6; radius: 3; color: accent
                            anchors.verticalCenter: parent.verticalCenter
                            visible: st.weedType >= 0
                        }
                    }

                    Grid {
                        width: parent.width
                        height: parent.height - 34
                        columns: 2
                        columnSpacing: 6
                        rowSpacing:    6

                        Repeater {
                            model: [
                                { icon: "🌾", label: "Grass Weeds"},
                                { icon: "🍀", label: "Broadleaf"},
                                { icon: "🌵", label: "Woody Weeds"}
                            ]
                            // delegate: Rectangle {
                            //     property bool act: st.weedType === index
                            //     property bool hov: false
                            //     width:  (parent.width  - 6) / 2
                            //     height: (parent.height - 6) / 2
                            //     radius: 8
                            //     color: root._cardColor(act, hov)
                            //     border.color: root._borderColor(act)
                            //     border.width: act ? 2 : 1
                            //     Behavior on color        { ColorAnimation { duration: 100 } }
                            //     Behavior on border.color { ColorAnimation { duration: 100 } }

                            //     Column {
                            //         anchors.centerIn: parent
                            //         spacing: 4
                            //         Text { anchors.horizontalCenter: parent.horizontalCenter; text: modelData.icon; font.pixelSize: 20 }
                            //         Text {
                            //             anchors.horizontalCenter: parent.horizontalCenter
                            //             text: modelData.label
                            //             color: act ? root.th.text : root.th.textSub
                            //             font.pixelSize: 11; font.weight: act ? Font.DemiBold : Font.Normal
                            //             Behavior on color { ColorAnimation { duration: 100 } }
                            //         }
                            //         Text { anchors.horizontalCenter: parent.horizontalCenter; text: modelData.sub; color: root.th.textDim; font.pixelSize: 9 }
                            //     }

                            //     MouseArea {
                            //         anchors.fill: parent; hoverEnabled: true
                            //         cursorShape: root.locked ? Qt.ForbiddenCursor : Qt.PointingHandCursor
                            //         onEntered: parent.hov = true
                            //         onExited:  parent.hov = false
                            //         onClicked: { if (!root.locked) st.weedType = (st.weedType === index ? -1 : index) }
                            //     }
                            // }
                            delegate: BigOptionBtn {
                                width: (parent.width - 6) / 2   // 2 items, 1 gap of 6px
                                optIcon: modelData.icon
                                optLabel: modelData.label
                                active: st.weedType === index
                                lk: root.locked
                                // th: agvView.th
                                ac: _ac
                                onTapped: st.weedType = (st.weedType === index ? -1 : index)
                            }
                        }
                    }
                }
            }

            // ═══════════════════════════════════════════════════════════════
            // C  OPERATION MODE  (2×2 grid)
            // ═══════════════════════════════════════════════════════════════
            Rectangle {
                width:  (parent.width - 16) / 3
                height: parent.height
                radius: 10
                color:  st.opMode >= 0 ? Qt.rgba(31/255,241/255,143/255,0.04) : "#0d0d0d"
                border.color: st.opMode >= 0 ? Qt.rgba(31/255,241/255,143/255,0.35) : Qt.rgba(255,255,255,0.07)
                border.width: 1
                Behavior on color        { ColorAnimation { duration: 200 } }
                Behavior on border.color { ColorAnimation { duration: 200 } }

                Column {
                    anchors.fill:    parent
                    anchors.margins: 12
                    spacing: 8

                    Row {
                        width: parent.width
                        spacing: 8
                        Rectangle { width: 3; height: 18; radius: 2; color: accent; anchors.verticalCenter: parent.verticalCenter }
                        Text { text: "⚙️"; font.pixelSize: 16; anchors.verticalCenter: parent.verticalCenter }
                        Text {
                            text: "OPERATION MODE"
                            color: st.opMode >= 0 ? accent : Qt.rgba(255,255,255,0.5)
                            font.pixelSize: 11; font.weight: Font.ExtraBold
                            font.letterSpacing: 1.2; font.family: "Courier New"
                            anchors.verticalCenter: parent.verticalCenter
                            Behavior on color { ColorAnimation { duration: 200 } }
                        }
                        Rectangle {
                            width: 6; height: 6; radius: 3; color: accent
                            anchors.verticalCenter: parent.verticalCenter
                            visible: st.opMode >= 0
                        }
                    }

                    Grid {
                        width: parent.width
                        height: parent.height - 34
                        columns: 2
                        columnSpacing: 6
                        rowSpacing:    6

                        Repeater {
                            model: [
                                { icon: "〰️", label: "Surface Cut"},
                                { icon: "🎯", label: "Root Removal"},
                                { icon: "⬛", label: "Full Surface"},
                                { icon: "🔄", label: "Selective"}
                            ]
                            // delegate: Rectangle {
                            //     property bool act: st.opMode === index
                            //     property bool hov: false
                            //     width:  (parent.width  - 6) / 2
                            //     height: (parent.height - 6) / 2
                            //     radius: 8
                            //     color: root._cardColor(act, hov)
                            //     border.color: root._borderColor(act)
                            //     border.width: act ? 2 : 1
                            //     Behavior on color        { ColorAnimation { duration: 100 } }
                            //     Behavior on border.color { ColorAnimation { duration: 100 } }

                            //     Column {
                            //         anchors.centerIn: parent
                            //         spacing: 4
                            //         Text { anchors.horizontalCenter: parent.horizontalCenter; text: modelData.icon; font.pixelSize: 20 }
                            //         Text {
                            //             anchors.horizontalCenter: parent.horizontalCenter
                            //             text: modelData.label
                            //             color: act ? root.th.text : root.th.textSub
                            //             font.pixelSize: 11; font.weight: act ? Font.DemiBold : Font.Normal
                            //             Behavior on color { ColorAnimation { duration: 100 } }
                            //         }
                            //         Text { anchors.horizontalCenter: parent.horizontalCenter; text: modelData.sub; color: root.th.textDim; font.pixelSize: 9 }
                            //     }

                            //     MouseArea {
                            //         anchors.fill: parent; hoverEnabled: true
                            //         cursorShape: root.locked ? Qt.ForbiddenCursor : Qt.PointingHandCursor
                            //         onEntered: parent.hov = true
                            //         onExited:  parent.hov = false
                            //         onClicked: { if (!root.locked) st.opMode = (st.opMode === index ? -1 : index) }
                            //     }
                            // }
                            delegate: BigOptionBtn {
                                width: (parent.width - 6) / 2   // 2 items, 1 gap of 6px
                                optIcon: modelData.icon
                                optLabel: modelData.label
                                active: st.opMode === index
                                lk: root.locked
                                // th: agvView.th
                                ac: _ac
                                onTapped: st.opMode = (st.opMode === index ? -1 : index)
                            }
                        }
                    }
                }
            }
        }
    }

    // ── Action Bar ───────────────────────────────────────────────────────────
    AGVActionBar {
        id:             actionBar
        anchors.left:   parent.left
        anchors.right:  parent.right
        anchors.bottom: parent.bottom

        ready:         root._ready
        missionActive: root.missionActive
        locked:        root.locked
        startLabel:    "START HARVEST"
        stopLabel:     "STOP HARVEST"

        onStartClicked: root.missionStartRequested()
        onStopClicked:  root.missionStopRequested()
        onClearClicked:          st.clear()
    }
}
