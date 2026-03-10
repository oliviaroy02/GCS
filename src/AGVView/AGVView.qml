// C:\NestLink\GCS\src\AGVView\AGVView.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import QGroundControl
import QGroundControl.Controls
import QGroundControl.FlightMap
import QGroundControl.Toolbar
import QGroundControl.FlyView

/// AGV Control View - With Full Toolbar
Item {
    id: agvView
    anchors.fill: parent

    property var _activeVehicle:        QGroundControl.multiVehicleManager.activeVehicle
    property var guidedController:      globals.guidedControllerFlyView
    property var planController:        globals.planMasterControllerFlyView
    property var _guidedValueSlider: guidedValueSlider
    property bool showMap: false
    property bool _userPannedMap: false
    // property bool darkTheme: true

    QGCPalette { id: qgcPal; colorGroupEnabled: true }

    // readonly property var th: darkTheme ? {
    //     bg:           "#0d0d0d",
    //     bgAlt:        "#1a1a1a",
    //     bgDeep:       "#060e09",
    //     surface:      Qt.rgba(255,255,255,0.03),
    //     surfaceHov:   Qt.rgba(255,255,255,0.06),
    //     border:       Qt.rgba(255,255,255,0.07),
    //     borderStrong: Qt.rgba(255,255,255,0.12),
    //     text:         "#ffffff",
    //     textSub:      Qt.rgba(255,255,255,0.5),
    //     textDim:      Qt.rgba(255,255,255,0.35),
    //     accent:       "#1ff18f",
    //     accentBg:     Qt.rgba(31/255,241/255,143/255,0.08),
    //     accentBorder: Qt.rgba(31/255,241/255,143/255,0.22),
    //     sliderTrack:  Qt.rgba(255,255,255,0.1),
    //     handleBg:     "#0f1a14"
    // } : {
    //     bg:           "#f0f4f2",
    //     bgAlt:        "#ffffff",
    //     bgDeep:       "#e0ede6",
    //     surface:      Qt.rgba(0,0,0,0.04),
    //     surfaceHov:   Qt.rgba(0,0,0,0.08),
    //     border:       Qt.rgba(0,0,0,0.10),
    //     borderStrong: Qt.rgba(0,0,0,0.18),
    //     text:         "#0a1a0f",
    //     textSub:      Qt.rgba(0,0,0,0.55),
    //     textDim:      Qt.rgba(0,0,0,0.38),
    //     accent:       "#0db868",
    //     accentBg:     Qt.rgba(13/255,184/255,104/255,0.10),
    //     accentBorder: Qt.rgba(13/255,184/255,104/255,0.30),
    //     sliderTrack:  Qt.rgba(0,0,0,0.12),
    //     handleBg:     "#e8f5ee"
    // }

    // readonly property var th: darkTheme ? {
    //     bg:           "#0d0d0d",
    //     bgAlt:        "#1a1a1a",
    //     bgDeep:       "#060e09",
    //     surface:      Qt.rgba(255,255,255,0.03),
    //     surfaceHov:   Qt.rgba(255,255,255,0.06),
    //     border:       Qt.rgba(255,255,255,0.07),
    //     borderStrong: Qt.rgba(255,255,255,0.12),
    //     text:         "#ffffff",
    //     textSub:      Qt.rgba(255,255,255,0.5),
    //     textDim:      Qt.rgba(255,255,255,0.35),
    //     accent:       "#1ff18f",
    //     accentBg:     Qt.rgba(31/255,241/255,143/255,0.08),
    //     accentBorder: Qt.rgba(31/255,241/255,143/255,0.22),
    //     sliderTrack:  Qt.rgba(255,255,255,0.1),
    //     handleBg:     "#0f1a14",
    //     cameraBg:     "#000000",
    //     videoPlaceholderBg: "#1a1a1a",
    //     videoPlaceholderText: "#666666",
    //     camBtnBg:     Qt.rgba(0,0,0,0.5),
    //     camBtnBorder: Qt.rgba(1,1,1,0.2),
    //     camBtnText:   "#aaaaaa",
    //     dpadBg:       Qt.rgba(0,0,0,0.55),
    //     dpadBorder:   Qt.rgba(1,1,1,0.15),
    //     dpadText:     "#888888",
    //     handleColor:  Qt.rgba(255,255,255,0.10),
    //     tabBarBg:     "#060e09",
    //     tabBarBorder: Qt.rgba(255,255,255,0.08),
    //     divider:      Qt.rgba(255,255,255,0.06),
    //     cardBg:       Qt.rgba(255,255,255,0.02),
    //     cardBorder:   Qt.rgba(255,255,255,0.06),
    //     cardBgHov:    Qt.rgba(255,255,255,0.06),
    //     cardBorderHov:Qt.rgba(31/255,241/255,143/255,0.3),
    //     toggleOff:    Qt.rgba(255,255,255,0.1),
    //     toggleOffBorder: Qt.rgba(255,255,255,0.12),
    //     toggleKnobOff:"#666666",
    //     statBg:       Qt.rgba(255,255,255,0.02),
    //     statBorder:   Qt.rgba(255,255,255,0.06),
    //     alertBg:      Qt.rgba(31,241,143,0.05),
    //     alertBorder:  Qt.rgba(31,241,143,0.15),
    //     roverBorder:  Qt.rgba(1,1,1,0.1),
    //     missionBadgeBg: Qt.rgba(31,241,143,0.08),
    //     missionBadgeBorder: Qt.rgba(31,241,143,0.25)
    // } : {
    //     bg:           "#f0f4f2",
    //     bgAlt:        "#ffffff",
    //     bgDeep:       "#e0ede6",
    //     surface:      Qt.rgba(0,0,0,0.04),
    //     surfaceHov:   Qt.rgba(0,0,0,0.08),
    //     border:       Qt.rgba(0,0,0,0.10),
    //     borderStrong: Qt.rgba(0,0,0,0.18),
    //     text:         "#0a1a0f",
    //     textSub:      Qt.rgba(0,0,0,0.55),
    //     textDim:      Qt.rgba(0,0,0,0.38),
    //     accent:       "#0db868",
    //     accentBg:     Qt.rgba(13/255,184/255,104/255,0.10),
    //     accentBorder: Qt.rgba(13/255,184/255,104/255,0.30),
    //     sliderTrack:  Qt.rgba(0,0,0,0.12),
    //     handleBg:     "#e8f5ee",
    //     cameraBg:     "#1a1a1a",
    //     videoPlaceholderBg: "#d8e8df",
    //     videoPlaceholderText: "#888888",
    //     camBtnBg:     Qt.rgba(0,0,0,0.25),
    //     camBtnBorder: Qt.rgba(0,0,0,0.2),
    //     camBtnText:   "#555555",
    //     dpadBg:       Qt.rgba(0,0,0,0.15),
    //     dpadBorder:   Qt.rgba(0,0,0,0.18),
    //     dpadText:     "#555555",
    //     handleColor:  Qt.rgba(0,0,0,0.12),
    //     tabBarBg:     "#d4e8dc",
    //     tabBarBorder: Qt.rgba(0,0,0,0.10),
    //     divider:      Qt.rgba(0,0,0,0.08),
    //     cardBg:       Qt.rgba(0,0,0,0.03),
    //     cardBorder:   Qt.rgba(0,0,0,0.08),
    //     cardBgHov:    Qt.rgba(0,0,0,0.07),
    //     cardBorderHov:Qt.rgba(13/255,184/255,104/255,0.4),
    //     toggleOff:    Qt.rgba(0,0,0,0.12),
    //     toggleOffBorder: Qt.rgba(0,0,0,0.15),
    //     toggleKnobOff:"#999999",
    //     statBg:       Qt.rgba(0,0,0,0.03),
    //     statBorder:   Qt.rgba(0,0,0,0.08),
    //     alertBg:      Qt.rgba(13,184,104,0.08),
    //     alertBorder:  Qt.rgba(13,184,104,0.25),
    //     roverBorder:  Qt.rgba(0,0,0,0.10),
    //     missionBadgeBg: Qt.rgba(13,184,104,0.10),
    //     missionBadgeBorder: Qt.rgba(13,184,104,0.30)
    // }

    GuidedValueSlider {
        id:                 guidedValueSlider
        anchors.right:      parent.right
        anchors.top:        parent.top
        anchors.bottom:     parent.bottom
        anchors.topMargin:  toolbar.height
        z:                  QGroundControl.zOrderTopMost
        visible:            false
    }

    FlyViewToolBar {
        id:                 toolbar
        guidedValueSlider:  _guidedValueSlider
        visible:            !QGroundControl.videoManager.fullScreen
    }

    // Main AGV Content
    
    Rectangle {
        id:             mainContent
        anchors.top:    toolbar.bottom
        anchors.left:   parent.left
        anchors.right:  parent.right
        anchors.bottom: parent.bottom
        color:          "#1a1a1a"

        // Rectangle {
        //     id: themeToggle
        //     anchors.top:         mainContent.top
        //     anchors.right:       mainContent.right
        //     anchors.topMargin:   8
        //     anchors.rightMargin: 8
        //     width:  36
        //     height: 36
        //     radius: 18
        //     z:      100
        //     color:  themeMa.containsMouse
        //             ? Qt.rgba(128/255,128/255,128/255,0.2)
        //             : Qt.rgba(128/255,128/255,128/255,0.10)
        //     border.color: agvView.darkTheme
        //                 ? Qt.rgba(255,255,255,0.15)
        //                 : Qt.rgba(0,0,0,0.15)
        //     border.width: 1
        //     Behavior on color { ColorAnimation { duration: 120 } }

        //     Text {
        //         anchors.centerIn: parent
        //         text:           agvView.darkTheme ? "☀️" : "🌙"
        //         font.pixelSize: 16
        //     }

        //     MouseArea {
        //         id:           themeMa
        //         anchors.fill: parent
        //         hoverEnabled: true
        //         cursorShape:  Qt.PointingHandCursor
        //         onClicked:    agvView.darkTheme = !agvView.darkTheme
        //     }
        // }

        Row {
            anchors.fill: parent
            spacing: 0

            //=================================================================
            // LEFT PANEL - Mission Data & Telemetry
            //=================================================================
            
            Rectangle {
                id:     leftPanel
                width:  280 //320
                height: parent.height
                color:  "#0d0d0d"
                border.color: Qt.rgba(1, 1, 1, 0.1)
                border.width: 1

                Flickable {
                    anchors.fill: parent
                    contentHeight: leftPanelContent.height
                    clip: true

                    Column {
                        id: leftPanelContent
                        width: parent.width
                        spacing: 0

                        // Mission Day Header
                        Rectangle {
                            width: parent.width
                            height: 60
                            color: "#0d0d0d"

                            Column {
                                anchors.left: parent.left
                                anchors.leftMargin: 20
                                anchors.verticalCenter: parent.verticalCenter
                                spacing: 5

                                Text {
                                    text: "MISSION DAY"
                                    color: "#666666"
                                    font.pixelSize: 11
                                    font.weight: Font.Bold
                                }

                                Text {
                                    text: "SOL #3039"
                                    color: "#1ff18f" //"#ff6b35"
                                    font.pixelSize: 18
                                    font.weight: Font.Bold
                                }
                            }

                            Text {
                                anchors.right: parent.right
                                anchors.rightMargin: 20
                                anchors.verticalCenter: parent.verticalCenter
                                text: Qt.formatTime(new Date(), "h:mm ap")
                                color: "#ffffff"
                                font.pixelSize: 14
                            }

                            Rectangle {
                                anchors.bottom: parent.bottom
                                width: parent.width
                                height: 1
                                color: Qt.rgba(1, 1, 1, 0.1)
                            }
                        }

                        // Sun Times
                        Rectangle {
                            width: parent.width
                            height: 80
                            color: "#0d0d0d"

                            Row {
                                anchors.centerIn: parent
                                spacing: 40

                                Column {
                                    spacing: 8
                                    Text {
                                        text: "SUNRISE"
                                        color: "#666666"
                                        font.pixelSize: 11
                                    }
                                    Text {
                                        text: "6:37 am"
                                        color: "#ffffff"
                                        font.pixelSize: 16
                                        font.weight: Font.Bold
                                    }
                                }

                                Column {
                                    spacing: 8
                                    Text {
                                        text: "SUNSET"
                                        color: "#666666"
                                        font.pixelSize: 11
                                    }
                                    Text {
                                        text: "6:35 pm"
                                        color: "#ffffff"
                                        font.pixelSize: 16
                                        font.weight: Font.Bold
                                    }
                                }
                            }

                            Rectangle {
                                anchors.bottom: parent.bottom
                                width: parent.width
                                height: 1
                                color: Qt.rgba(1, 1, 1, 0.1)
                            }
                        }

                        // Pressure Gauge
                        AGVTelemetryGauge {
                            width: parent.width
                            // th: agvView.th
                            title: "PRESSURE"
                            value: "827"
                            unit: "Pa"
                            gaugeValue: 0.65
                            gaugeColor: "#4caf50"
                        }

                        // Oxygen Gauge
                        AGVTelemetryGauge {
                            width: parent.width
                            title: "OXYGEN"
                            // th: agvView.th
                            value: "0.064"
                            unit: ""
                            gaugeValue: 0.32
                            gaugeColor: "#ff9800"
                        }

                        // Temperature Gauge
                        AGVTelemetryGauge {
                            width: parent.width
                            // th: agvView.th
                            title: "TEMPERATURE"
                            value: "-29.16"
                            unit: "°C"
                            gaugeValue: 0.45
                            gaugeColor: "#4caf50"
                        }

                        // Atmosphere
                        AGVTelemetryItem {
                            width: parent.width
                            // th: agvView.th
                            title: "ATMOSPHERE"
                            value: "Moderate sunny"
                        }

                        // Rover Status
                        Rectangle {
                            width: parent.width
                            height: 120
                            color: "#0d0d0d"

                            Column {
                                anchors.fill: parent
                                anchors.margins: 20
                                spacing: 12

                                Text {
                                    text: "ROVER STATUS"
                                    color: "#1ff18f" //"#ff6b35"
                                    font.pixelSize: 12
                                    font.weight: Font.Bold
                                }

                                Row {
                                    spacing: 30

                                    Column {
                                        spacing: 6
                                        Text { text: "CELL"; color: "#666666"; font.pixelSize: 10 }  //"#666666"
                                        Text { text: "65.25"; color: "#ffffff"; font.pixelSize: 13 }  //"#ffffff"
                                    }

                                    Column {
                                        spacing: 6
                                        Text { text: "GAS PRESS"; color: "#666666"; font.pixelSize: 10 }  //"#666666"
                                        Text { text: "12.48"; color: "#ffffff" ; font.pixelSize: 13 } //"#ffffff"
                                    }

                                    Column {
                                        spacing: 6
                                        Text { text: "MODE"; color: "#666666" ; font.pixelSize: 10 } //"#666666"
                                        Text { 
                                            text: _activeVehicle ? _activeVehicle.flightMode : "DRV"
                                            color: "#ffffff"
                                            font.pixelSize: 13
                                        }
                                    }
                                }
                            }

                            Rectangle {
                                anchors.bottom: parent.bottom
                                width: parent.width
                                height: 1
                                color: Qt.rgba(1, 1, 1, 0.1)
                            }
                        }

                        // Speed
                        AGVTelemetryItem {
                            width: parent.width
                            title: "SPEED"
                            value: _activeVehicle ? 
                                   _activeVehicle.groundSpeed.toFixed(0) + " km/hour" : 
                                   "0 km/hour"
                        }
                    }
                }
            }

            //=================================================================
            // RIGHT PANEL - Camera Feed & Controls
            //=================================================================

            Column {
                id: mainColumn
                width:  parent.width - leftPanel.width
                height: parent.height
                spacing: 0

                // Shared size state — single source of truth
                QtObject {
                    id: sizeState
                    property bool   camLocked: true
                    // Camera width — min 55%, max 80% of topRow width
                    property real camW:    mainColumn.width * 0.55
                    readonly property real camWMin: mainColumn.width * 0.55
                    readonly property real camWMax: mainColumn.width * 0.80

                    // Top row height — min 300px, max leaves at least 200px for bottom
                    property real topH:    mainColumn.height - 300
                    readonly property real topHMin: 200
                    readonly property real topHMax: mainColumn.height - 200
                }

                //=============================================================
                // TOP ROW: Camera Feed (LEFT) + Right Panel (NEW)
                //=============================================================
                
                Row {
                    id: topRow
                    width: parent.width
                    height: sizeState.topH //parent.height - 300  // Reserve 220px for bottom panel   parent.height - bottomPanel.height
                    spacing: 0

                    //=========================================================
                    // CAMERA FEED - Narrower (LEFT)
                    //=========================================================
                    
                    Rectangle {
                        id: cameraPanel
                        width:  sizeState.camW  //cameraWidth //parent.width * 0.55  // 62% of available width
                        height: parent.height
                        color:  "#000000"

                        // property real cameraWidth:  parent.width * 0.55
                        // property real cameraHeight: parent.height

                        // Rectangle {
                        //     id: rightHandle
                        //     anchors.right:  parent.right
                        //     anchors.top:    parent.top
                        //     anchors.bottom: parent.bottom
                        //     width: 6
                        //     z: 10
                        //     color: rightDrag.containsMouse || rightDrag.drag.active
                        //         ? Qt.rgba(31/255,241/255,143/255,0.4)
                        //         : Qt.rgba(255,255,255,0.08)
                        //     Behavior on color { ColorAnimation { duration: 100 } }

                        //     MouseArea {
                        //         id: rightDrag
                        //         anchors.fill: parent
                        //         hoverEnabled: true
                        //         cursorShape:  Qt.SizeHorCursor

                        //         property real startX: 0
                        //         property real startW: 0

                        //         onPressed: (mouse) => {
                        //             startX = mouse.x + rightHandle.x
                        //             startW = cameraPanel.width
                        //         }
                        //         onPositionChanged: (mouse) => {
                        //             if (pressed) {
                        //                 let delta = (mouse.x + rightHandle.x) - startX
                        //                 let newW  = Math.max(200, Math.min(cameraPanel.parent.width - 200, startW + delta))
                        //                 cameraPanel.width = newW
                        //             }
                        //         }
                        //     }
                        // }

                        // // Bottom drag handle
                        // Rectangle {
                        //     id: bottomHandle
                        //     anchors.left:   parent.left
                        //     anchors.right:  parent.right
                        //     anchors.bottom: parent.bottom
                        //     height: 6
                        //     z: 10
                        //     color: bottomDrag.containsMouse || bottomDrag.drag.active
                        //         ? Qt.rgba(31/255,241/255,143/255,0.4)
                        //         : Qt.rgba(255,255,255,0.08)
                        //     Behavior on color { ColorAnimation { duration: 100 } }

                        //     MouseArea {
                        //         id: bottomDrag
                        //         anchors.fill: parent
                        //         hoverEnabled: true
                        //         cursorShape:  Qt.SizeVerCursor

                        //         property real startY: 0
                        //         property real startH: 0

                        //         onPressed: (mouse) => {
                        //             startY = mouse.y + bottomHandle.y
                        //             startH = topRow.height
                        //         }
                        //         onPositionChanged: (mouse) => {
                        //             if (pressed) {
                        //                 let delta = (mouse.y + bottomHandle.y) - startY
                        //                 let newH  = Math.max(100, Math.min(mainContent.height - 100, startH + delta))
                        //                 topRow.height = newH
                        //             }
                        //         }
                        //     }
                        // }


                        // ── Right resize handle ──
                        Rectangle {
                            id:    rightHandle
                            anchors.right:  parent.right
                            anchors.top:    parent.top
                            anchors.bottom: parent.bottom
                            width: 5
                            z:     20
                            color: rightDrag.containsMouse || rightDrag.pressed
                                ? Qt.rgba(31/255,241/255,143/255,0.5)
                                : Qt.rgba(255,255,255,0.10)
                            Behavior on color { ColorAnimation { duration: 100 } }

                            MouseArea {
                                id:           rightDrag
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape:  Qt.SizeHorCursor

                                property real _startSceneX: 0
                                property real _startW:      0

                                onPressed:  (mouse) => {
                                    _startSceneX = mapToItem(mainColumn, mouse.x, 0).x
                                    _startW      = sizeState.camW
                                }
                                onPositionChanged: (mouse) => {
                                    if (!pressed) return
                                    let sceneX = mapToItem(mainColumn, mouse.x, 0).x
                                    let newW   = _startW + (sceneX - _startSceneX)
                                    sizeState.camW = Math.max(sizeState.camWMin, Math.min(sizeState.camWMax, newW))
                                }
                            }
                        }

                        // ── Bottom resize handle ──
                        Rectangle {
                            id:    bottomHandle
                            anchors.left:   parent.left
                            anchors.right:  parent.right
                            anchors.bottom: parent.bottom
                            height: 5
                            z:      20
                            color: bottomDrag.containsMouse || bottomDrag.pressed
                                ? Qt.rgba(31/255,241/255,143/255,0.5)
                                : Qt.rgba(255,255,255,0.10)
                            Behavior on color { ColorAnimation { duration: 100 } }

                            MouseArea {
                                id:           bottomDrag
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape:  Qt.SizeVerCursor

                                property real _startSceneY: 0
                                property real _startH:      0

                                onPressed:  (mouse) => {
                                    _startSceneY = mapToItem(mainColumn, 0, mouse.y).y
                                    _startH      = sizeState.topH
                                }
                                onPositionChanged: (mouse) => {
                                    if (!pressed) return
                                    let sceneY = mapToItem(mainColumn, 0, mouse.y).y
                                    let newH   = _startH + (sceneY - _startSceneY)
                                    sizeState.topH = Math.max(sizeState.topHMin, Math.min(sizeState.topHMax, newH))
                                }
                            }
                        }

                        // Camera Control Panel Header
                        Rectangle {
                            width:  parent.width
                            height: 40
                            color:  Qt.rgba(0, 0, 0, 0.7)
                            z:      10

                            Row {
                                anchors.left:        parent.left
                                anchors.leftMargin:  20
                                anchors.verticalCenter: parent.verticalCenter
                                spacing: 15

                                Text {
                                    text:           "CAMERA CONTROL PANEL"
                                    color:          "#ffffff"
                                    font.pixelSize: 13
                                    font.weight:    Font.Bold
                                }
                            }

                            // Resize Lock
                            Rectangle {
                                id: camLockBtn
                                anchors.top:   parent.top
                                anchors.right: parent.right
                                anchors.margins: 8
                                width: 28; height: 28; radius: 6
                                z: 10

                                color: lockBtnMa.containsMouse
                                    ? Qt.rgba(255,255,255,0.12)
                                    : Qt.rgba(255,255,255,0.06)
                                border.color: sizeState.camLocked
                                    ? Qt.rgba(255,255,255,0.15)
                                    : Qt.rgba(31/255,241/255,143/255,0.5)
                                border.width: 1
                                Behavior on color        { ColorAnimation { duration: 120 } }
                                Behavior on border.color { ColorAnimation { duration: 120 } }

                                Text {
                                    anchors.centerIn: parent
                                    text:           sizeState.camLocked ? "🔒" : "🔓"
                                    font.pixelSize: 13
                                }

                                MouseArea {
                                    id:           lockBtnMa
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    cursorShape:  Qt.PointingHandCursor
                                    onClicked:    sizeState.camLocked = !sizeState.camLocked
                                }
                            }

                            // Toggle arrow button
                            Rectangle {
                                anchors.right:          parent.right
                                anchors.rightMargin:    10
                                anchors.verticalCenter: parent.verticalCenter
                                width:                  32
                                height:                 32
                                radius:                 4
                                color:                  arrowMouse.containsMouse ? Qt.rgba(1,1,1,0.1) : "transparent"

                                Text {
                                    anchors.centerIn: parent
                                    text:             showMap ? "📹" : "🗺"
                                    font.pixelSize:   18
                                }

                                MouseArea {
                                    id:             arrowMouse
                                    anchors.fill:   parent
                                    hoverEnabled:   true
                                    cursorShape:    Qt.PointingHandCursor
                                    onClicked:      showMap = !showMap
                                }
                            }
                        }

                        // Map View
                        FlightMap {
                            id:             agvMap
                            anchors.fill:   parent
                            mapName:        "AGVMap"
                            allowGCSLocationCenter: true
                            visible:        showMap
                            z:              1

                            Component.onCompleted: {
                                if (_activeVehicle && _activeVehicle.coordinate.isValid) {
                                    center = _activeVehicle.coordinate
                                    zoomLevel = 17
                                    return
                                }

                                if (QGroundControl.qgcPositionManger.gcsPosition.isValid) {
                                    center = QGroundControl.qgcPositionManger.gcsPosition
                                    zoomLevel = 16
                                    return
                                }
                            }

                            Connections {
                                target: QGroundControl.multiVehicleManager
                                function onActiveVehicleChanged(activeVehicle) {
                                    if (activeVehicle && activeVehicle.coordinate.isValid) {
                                        agvMap.center    = activeVehicle.coordinate
                                        agvMap.zoomLevel = 17
                                    }
                                }
                            }

                            Connections {
                                target:     _activeVehicle
                                enabled:    _activeVehicle !== null
                                function onCoordinateChanged() {
                                    if (!_userPannedMap) {
                                        agvMap.center = _activeVehicle.coordinate
                                    }
                                }
                            }

                            MouseArea {
                                anchors.fill:   parent
                                propagateComposedEvents: true
                                onPressed:  (mouse) => { _userPannedMap = true;  mouse.accepted = false }
                            }
                        }

                        // Video View
                        Item {
                            anchors.fill:   parent
                            visible:        !showMap
                            z:              1

                            QGCVideoBackground {
                                anchors.fill:   parent
                                visible:        QGroundControl.videoManager.hasVideo
                            }

                            // Placeholder when no video
                            Rectangle {
                                anchors.fill:   parent
                                color:          "#1a1a1a"
                                visible:        !QGroundControl.videoManager.hasVideo

                                Column {
                                    anchors.centerIn: parent
                                    spacing:          15

                                    Text {
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        text:           "📹"
                                        font.pixelSize: 64
                                    }

                                    Text {
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        text:           "No Video Stream"
                                        color:          "#666666"
                                        font.pixelSize: 16
                                    }
                                }
                            }

                            // Camera controls overlay
                            Column {
                                anchors.right:          parent.right
                                anchors.bottom:         parent.bottom
                                anchors.rightMargin:    16
                                anchors.bottomMargin:   16
                                spacing:                8

                                // Zoom row
                                Row {
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    spacing: 6

                                    Rectangle {
                                        width: 36; height: 22; radius: 3
                                        color: zoomOutMouse.containsMouse ? Qt.rgba(1,1,1,0.1) : Qt.rgba(0,0,0,0.5)
                                        border.color: Qt.rgba(1,1,1,0.2); border.width: 1
                                        Text {
                                            anchors.centerIn: parent
                                            text: "O−"; color: "#aaaaaa"; font.pixelSize: 11; font.weight: Font.Medium
                                        }
                                        MouseArea {
                                            id: zoomOutMouse; anchors.fill: parent
                                            hoverEnabled: true; cursorShape: Qt.PointingHandCursor
                                            onClicked: console.log("zoom_out")
                                        }
                                    }

                                    Rectangle {
                                        width: 36; height: 22; radius: 3
                                        color: zoomInMouse.containsMouse ? Qt.rgba(1,1,1,0.1) : Qt.rgba(0,0,0,0.5)
                                        border.color: Qt.rgba(1,1,1,0.2); border.width: 1
                                        Text {
                                            anchors.centerIn: parent
                                            text: "O+"; color: "#aaaaaa"; font.pixelSize: 11; font.weight: Font.Medium
                                        }
                                        MouseArea {
                                            id: zoomInMouse; anchors.fill: parent
                                            hoverEnabled: true; cursorShape: Qt.PointingHandCursor
                                            onClicked: console.log("zoom_in")
                                        }
                                    }
                                }

                                // D-pad
                                Grid {
                                    columns: 3
                                    spacing: 4
                                    anchors.horizontalCenter: parent.horizontalCenter

                                    Item { width: 30; height: 30 }
                                    Rectangle {
                                        width: 30; height: 30; radius: 4
                                        color:        upMouse.pressed ? Qt.rgba(1,0.42,0.21,0.4) : upMouse.containsMouse ? Qt.rgba(1,1,1,0.08) : Qt.rgba(0,0,0,0.55)
                                        border.color: upMouse.containsMouse ? "#1ff18f" : Qt.rgba(1,1,1,0.15); border.width: 1
                                        Behavior on color        { ColorAnimation { duration: 80 } }
                                        Behavior on border.color { ColorAnimation { duration: 80 } }
                                        Text { anchors.centerIn: parent; text: "▲"; color: upMouse.containsMouse ? "#1ff18f" : "#888888"; font.pixelSize: 12 }
                                        MouseArea { id: upMouse; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor; onClicked: console.log("up") }
                                    }
                                    Item { width: 30; height: 30 }

                                    Rectangle {
                                        width: 30; height: 30; radius: 4
                                        color:        leftMouse.pressed ? Qt.rgba(1,0.42,0.21,0.4) : leftMouse.containsMouse ? Qt.rgba(1,1,1,0.08) : Qt.rgba(0,0,0,0.55)
                                        border.color: leftMouse.containsMouse ? "#1ff18f" : Qt.rgba(1,1,1,0.15); border.width: 1
                                        Behavior on color        { ColorAnimation { duration: 80 } }
                                        Behavior on border.color { ColorAnimation { duration: 80 } }
                                        Text { anchors.centerIn: parent; text: "◀"; color: leftMouse.containsMouse ? "#1ff18f": "#888888"; font.pixelSize: 12 }
                                        MouseArea { id: leftMouse; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor; onClicked: console.log("left") }
                                    }
                                    Rectangle {
                                        width: 30; height: 30; radius: 15
                                        color:        centerMouse.pressed ? Qt.rgba(1,0.42,0.21,0.6) : centerMouse.containsMouse ? Qt.rgba(1,0.42,0.21,0.2) : Qt.rgba(0,0,0,0.55)
                                        border.color: "#1ff18f"; border.width: 1
                                        Behavior on color { ColorAnimation { duration: 80 } }
                                        Text { anchors.centerIn: parent; text: "⊙"; color: "#1ff18f"; font.pixelSize: 13 }
                                        MouseArea { id: centerMouse; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor; onClicked: console.log("center") }
                                    }
                                    Rectangle {
                                        width: 30; height: 30; radius: 4
                                        color:        rightMouse.pressed ? Qt.rgba(1,0.42,0.21,0.4) : rightMouse.containsMouse ? Qt.rgba(1,1,1,0.08) : Qt.rgba(0,0,0,0.55)
                                        border.color: rightMouse.containsMouse ? "#1ff18f" : Qt.rgba(1,1,1,0.15); border.width: 1
                                        Behavior on color        { ColorAnimation { duration: 80 } }
                                        Behavior on border.color { ColorAnimation { duration: 80 } }
                                        Text { anchors.centerIn: parent; text: "▶"; color: rightMouse.containsMouse ? "#1ff18f" : "#888888"; font.pixelSize: 12 }
                                        MouseArea { id: rightMouse; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor; onClicked: console.log("right") }
                                    }

                                    Item { width: 30; height: 30 }
                                    Rectangle {
                                        width: 30; height: 30; radius: 4
                                        color:        downMouse.pressed ? Qt.rgba(1,0.42,0.21,0.4) : downMouse.containsMouse ? Qt.rgba(1,1,1,0.08) : Qt.rgba(0,0,0,0.55)
                                        border.color: downMouse.containsMouse ? "#1ff18f" : Qt.rgba(1,1,1,0.15); border.width: 1
                                        Behavior on color        { ColorAnimation { duration: 80 } }
                                        Behavior on border.color { ColorAnimation { duration: 80 } }
                                        Text { anchors.centerIn: parent; text: "▼"; color: downMouse.containsMouse ? "#1ff18f" : "#888888"; font.pixelSize: 12 }
                                        MouseArea { id: downMouse; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor; onClicked: console.log("down") }
                                    }
                                    Item { width: 30; height: 30 }
                                }
                            }
                        }
                    }

                    //=========================================================
                    // RIGHT PANEL (NEW) - Settings & Status
                    //=========================================================
                    
                    Rectangle {
                        id:     rightPanel
                        width:  parent.width - cameraPanel.width   //* 0.45  // 38% of available width
                        height: parent.height
                        color:  "#0d0d0d"
                        border.color: Qt.rgba(1, 1, 1, 0.1)
                        border.width: 1

                        Column {
                            id: rightPanelContent
                            // width: parent.width
                            anchors.fill: parent
                            spacing: 0
                            // padding: 12
                            
                            // ══════════════════════════════════════════════
                            // SPRAY sections — show only when Spray active
                            // ══════════════════════════════════════════════

                            // ── D. Field & Navigation ─────────────────────────────
                            Rectangle {
                                id: fieldBox
                                width:  parent.width
                                height: parent.height * 0.25
                                visible: missionState.activeTab === "spray"
                                color:  sprayPanelRef.st_fieldAction >= 0 ? Qt.rgba(31/255,241/255,143/255,0.04) : "#0d0d0d"
                                border.color: sprayPanelRef.st_fieldAction >= 0 ? Qt.rgba(31/255,241/255,143/255,0.35) : Qt.rgba(255,255,255,0.07)
                                border.width: 1
                                Behavior on color        { ColorAnimation { duration: 200 } }
                                Behavior on border.color { ColorAnimation { duration: 200 } }

                                Column {
                                    anchors.fill:    parent
                                    anchors.margins: 12
                                    spacing:         8

                                    // Header
                                    Row {
                                        width: parent.width
                                        spacing: 8
                                        Rectangle { width: 3; height: 19; radius: 2; color: "#1ff18f"; anchors.verticalCenter: parent.verticalCenter }
                                        Text { text: "🗺️"; font.pixelSize: 19; anchors.verticalCenter: parent.verticalCenter }
                                        Text {
                                            text: "FIELD & NAVIGATION"
                                            color: sprayPanelRef.st_fieldAction >= 0 ? "#1ff18f" : Qt.rgba(255,255,255,0.5)
                                            font.pixelSize: 12; font.weight: Font.ExtraBold
                                            font.letterSpacing: 1.5; font.family: "Courier New"
                                            anchors.verticalCenter: parent.verticalCenter
                                            Behavior on color { ColorAnimation { duration: 200 } }
                                        }
                                    }

                                    Grid {
                                        width: parent.width
                                        columns: 3
                                        spacing: 6

                                        Repeater {
                                            model: [
                                                { icon: "📂", label: "Saved Field",    sub: "Load boundary"  },
                                                { icon: "✏️", label: "New Field",      sub: "Draw boundary"  },
                                                { icon: "🛰️", label: "Auto Path Plan", sub: "Optimal route"  }
                                            ]
                                            delegate: Rectangle {
                                                property bool act: sprayPanelRef.st_fieldAction === index
                                                property bool hov: false
                                                width:  (parent.width - 12) / 3
                                                height: (parent.parent.height - 60)  // fill available height evenly
                                                radius: 8
                                                color: act ? Qt.rgba(31/255,241/255,143/255,0.12)
                                                    : hov  ? Qt.rgba(255,255,255,0.06)
                                                    : Qt.rgba(255,255,255,0.02)
                                                border.color: act ? "#1ff18f" : Qt.rgba(255,255,255,0.08)
                                                border.width: act ? 2 : 1
                                                Behavior on color        { ColorAnimation { duration: 100 } }
                                                Behavior on border.color { ColorAnimation { duration: 100 } }

                                                Row {
                                                    anchors.left:           parent.left
                                                    anchors.leftMargin:     12
                                                    anchors.verticalCenter: parent.verticalCenter
                                                    spacing: 10

                                                    Text {
                                                        text:           modelData.icon
                                                        font.pixelSize: 18
                                                        anchors.verticalCenter: parent.verticalCenter
                                                    }

                                                    Column {
                                                        anchors.verticalCenter: parent.verticalCenter
                                                        spacing: 3

                                                        Text {
                                                            text:        modelData.label
                                                            color:       act ? "#ffffff" : Qt.rgba(255,255,255,0.7)
                                                            font.pixelSize: 14
                                                            font.weight: act ? Font.DemiBold : Font.Normal
                                                            Behavior on color { ColorAnimation { duration: 100 } }
                                                        }
                                                        // Text 
                                                        //     text:           modelData.sub
                                                        //     color:          Qt.rgba(255,255,255,0.35)
                                                        //     font.pixelSize: 9
                                                        // }
                                                    }
                                                }

                                                // Radio circle
                                                // Rectangle {
                                                //     anchors.right:          parent.right
                                                //     anchors.rightMargin:    12
                                                //     anchors.verticalCenter: parent.verticalCenter
                                                //     width: 20; height: 20; radius: 10
                                                //     color:  act ? "#1ff18f" : "transparent"
                                                //     border.color: act ? "#1ff18f" : Qt.rgba(255,255,255,0.2); border.width: 1
                                                //     Behavior on color { ColorAnimation { duration: 100 } }
                                                //     Text {
                                                //         anchors.centerIn: parent
                                                //         text: "✓"; font.pixelSize: 10; font.weight: Font.Bold
                                                //         color: act ? "#0f1a14" : Qt.rgba(255,255,255,0.15)
                                                //     }
                                                // }

                                                MouseArea {
                                                    anchors.fill: parent
                                                    hoverEnabled: true
                                                    cursorShape:  Qt.PointingHandCursor
                                                    onEntered:    parent.hov = true
                                                    onExited:     parent.hov = false
                                                    onClicked:    sprayPanelRef.st_fieldAction = (sprayPanelRef.st_fieldAction === index ? -1 : index)
                                                }
                                            }
                                        }
                                    }
                                }
                            }

                            Rectangle { visible: missionState.activeTab === "spray"; width: parent.width; height: 1; color: Qt.rgba(255,255,255,0.06) }
                            // Rectangle { width: parent.width - 24; height: 1; color: Qt.rgba(1,1,1,0.06) }
                            Item {  visible: missionState.activeTab === "spray" ; height: 12; width: 1 }


                            // ── E. Advanced ───────────────────────────────────────
                            Rectangle {
                                width:  parent.width
                                height: parent.height * 0.36
                                visible: missionState.activeTab === "spray"
                                color:  "#0d0d0d"
                                border.color: Qt.rgba(255,255,255,0.07)
                                border.width: 1

                                Column {
                                    anchors.fill:    parent
                                    anchors.margins: 12
                                    spacing:         8

                                    // Header
                                    Row {
                                        width: parent.width
                                        spacing: 8
                                        Rectangle { width: 3; height: 19; radius: 2; color: "#1ff18f"; anchors.verticalCenter: parent.verticalCenter }
                                        Text { text: "⚗️"; font.pixelSize: 19; anchors.verticalCenter: parent.verticalCenter }
                                        Text {
                                            text: "ADVANCED SETTINGS"
                                            color: Qt.rgba(255,255,255,0.5)
                                            font.pixelSize: 12; font.weight: Font.ExtraBold
                                            font.letterSpacing: 1.5; font.family: "Courier New"
                                            anchors.verticalCenter: parent.verticalCenter
                                        }
                                    }

                                    // Spray Logging card
                                    Rectangle {
                                        width:  parent.width - 6
                                        height: (parent.height - 6)/3
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        radius: 8
                                        color:  sprayPanelRef.st_logging
                                                ? Qt.rgba(31/255,241/255,143/255,0.06)
                                                : Qt.rgba(255,255,255,0.03)
                                        border.color: sprayPanelRef.st_logging
                                                    ? Qt.rgba(31/255,241/255,143/255,0.3)
                                                    : Qt.rgba(255,255,255,0.08)
                                        border.width: 1
                                        Behavior on color        { ColorAnimation { duration: 150 } }
                                        Behavior on border.color { ColorAnimation { duration: 150 } }

                                        Row {
                                            // anchors.centerIn: parent
                                            // spacing: 6
                                            anchors.left:           parent.left
                                            anchors.leftMargin:     12
                                            anchors.verticalCenter: parent.verticalCenter
                                            spacing: 10

                                            Text {
                                                anchors.verticalCenter: parent.verticalCenter
                                                text: "📋"; 
                                                font.pixelSize: 20
                                            }
                                            Text {
                                                text:           "Spray Logging"
                                                color:          Qt.rgba(255,255,255,0.7)
                                                font.pixelSize: 12; 
                                                font.weight: Font.DemiBold
                                                anchors.verticalCenter: parent.verticalCenter
                                            }
                                        }

                                        // Toggle
                                        Rectangle {
                                            // anchors.horizontalCenter: parent.horizontalCenter
                                            anchors.right:          parent.right
                                            anchors.rightMargin:    12
                                            anchors.verticalCenter: parent.verticalCenter
                                            width: 38; height: 20; radius: 10
                                            color: sprayPanelRef.st_logging
                                                ? Qt.rgba(31/255,241/255,143/255,0.4)
                                                : Qt.rgba(255,255,255,0.1)
                                            border.color: sprayPanelRef.st_logging ? "#1ff18f" : Qt.rgba(255,255,255,0.12)
                                            border.width: 1
                                            Behavior on color        { ColorAnimation { duration: 150 } }
                                            Behavior on border.color { ColorAnimation { duration: 150 } }
                                            Rectangle {
                                                width: 14; height: 14; radius: 7; y: 3
                                                x: sprayPanelRef.st_logging ? parent.width - width - 3 : 3
                                                color: sprayPanelRef.st_logging ? "#1ff18f" : "#666666"
                                                Behavior on x     { NumberAnimation { duration: 150; easing.type: Easing.InOutQuad } }
                                                Behavior on color { ColorAnimation  { duration: 150 } }
                                            }
                                            MouseArea {
                                                anchors.fill: parent; cursorShape: Qt.PointingHandCursor
                                                onClicked: sprayPanelRef.st_logging = !sprayPanelRef.st_logging
                                            }
                                        }
                                    }

                                    Grid {
                                        width:   parent.width
                                        height:  parent.height - 30
                                        columns: 3
                                        columnSpacing: 6
                                        rowSpacing:    6

                                        // PDF Report card
                                        Rectangle {
                                            width:  (parent.width - 6) / 3
                                            height: (parent.height - 6) / 3
                                            radius: 8
                                            property bool hov: false
                                            color:  hov ? Qt.rgba(255,255,255,0.06) : Qt.rgba(255,255,255,0.02)
                                            border.color: hov
                                                        ? Qt.rgba(31/255,241/255,143/255,0.3)
                                                        : Qt.rgba(255,255,255,0.08)
                                            border.width: 1
                                            Behavior on color        { ColorAnimation { duration: 80 } }
                                            Behavior on border.color { ColorAnimation { duration: 80 } }

                                            Row {
                                                anchors.centerIn: parent
                                                spacing: 6
                                                Text {
                                                    // anchors.horizontalCenter: parent.horizontalCenter
                                                    text: "📊"; font.pixelSize: 20
                                                    anchors.verticalCenter: parent.verticalCenter
                                                }
                                                Text {
                                                    // anchors.horizontalCenter: parent.horizontalCenter
                                                    anchors.verticalCenter: parent.verticalCenter
                                                    text:           "PDF Report"
                                                    color:          parent.parent.hov ? "#ffffff" : Qt.rgba(255,255,255,0.65)
                                                    font.pixelSize: 12; font.weight: Font.DemiBold
                                                    // horizontalAlignment: Text.AlignHCenter
                                                    Behavior on color { ColorAnimation { duration: 80 } }
                                                }
                                                Text {
                                                    // anchors.horizontalCenter: parent.horizontalCenter
                                                    anchors.verticalCenter: parent.verticalCenter
                                                    text: "›"; color: "#1ff18f"; font.pixelSize: 14
                                                }
                                            }

                                            MouseArea {
                                                anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor
                                                onEntered: parent.hov = true; onExited: parent.hov = false
                                                onClicked: console.log("Generate PDF Report")
                                            }
                                        }

                                        // Coverage stat card
                                        Rectangle {
                                            width:  (parent.width - 6) / 3
                                            height: (parent.height - 6) / 3
                                            radius: 8
                                            color:  Qt.rgba(255,255,255,0.02)
                                            border.color: Qt.rgba(255,255,255,0.06); border.width: 1

                                            Row {
                                                anchors.centerIn: parent
                                                spacing: 6
                                                Text {
                                                    anchors.verticalCenter: parent.verticalCenter
                                                    text:           missionState.missionOwner !== "" ? "18%" : "--"
                                                    color:          "#1ff18f"
                                                    font.pixelSize: 16; font.weight: Font.Bold; font.family: "Courier New"
                                                }
                                                Text {
                                                    anchors.verticalCenter: parent.verticalCenter
                                                    text:           "Coverage"
                                                    color:          Qt.rgba(255,255,255,0.38)
                                                    font.pixelSize: 8; font.letterSpacing: 0.5
                                                    horizontalAlignment: Text.AlignHCenter
                                                }
                                            }
                                        }

                                        // Chemical Used stat card
                                        Rectangle {
                                            width:  (parent.width - 6) / 3
                                            height: (parent.height - 6) / 3
                                            radius: 8
                                            color:  Qt.rgba(255,255,255,0.02)
                                            border.color: Qt.rgba(255,255,255,0.06); border.width: 1

                                            Row {
                                                anchors.centerIn: parent
                                                spacing: 6
                                                Text {
                                                    anchors.verticalCenter: parent.verticalCenter
                                                    text:           missionState.missionOwner !== "" ? "12.5 Lt" : "--"
                                                    color:          "#1ff18f"
                                                    font.pixelSize: 16; font.weight: Font.Bold; font.family: "Courier New"
                                                }
                                                Text {
                                                    anchors.verticalCenter: parent.verticalCenter
                                                    text:           "Chemical Used"
                                                    color:          Qt.rgba(255,255,255,0.38)
                                                    font.pixelSize: 8; font.letterSpacing: 0.5
                                                    // horizontalAlignment: Text.AlignHCenter
                                                }
                                            }
                                        }
                                    }
                                }
                            }

                            Rectangle { visible: missionState.activeTab === "spray"; width: parent.width; height: 1; color: Qt.rgba(255,255,255,0.06) }
                            // Rectangle { width: parent.width - 24; height: 1; color: Qt.rgba(1,1,1,0.06) }
                            Item { visible: missionState.activeTab === "spray"; height: 12; width: 1 }

                            // Section: Mission Stats
                            AGVRightSection {
                                width: parent.width - 24
                                title: "MISSION STATS"
                                visible: missionState.activeTab === "spray"
                                icon: "📈"

                                Grid {
                                    id: missionStat
                                    width:   parent.width
                                    height:  parent.height - 30
                                    columns: 2
                                    columnSpacing: 6
                                    rowSpacing:    6

                                    AGVStatDisplay { width: parent.width; label: "Coverage"; value: "18%" }
                                    AGVStatDisplay { width: parent.width; label: "Chemical Used"; value: "12.5 Lt" }
                                    AGVStatDisplay { width: parent.width; label: "Tank Level"; value: "75%" }
                                    AGVStatDisplay { width: parent.width; label: "Time Elapsed"; value: "12:34" }
                                }
                            }

                            Rectangle { visible: missionState.activeTab === "spray"; width: parent.width - 24; height: 1; color: Qt.rgba(1,1,1,0.06) }
                            Item { visible: missionState.activeTab === "spray"; height: 12; width: 1 }

                            // Section: Fault Alerts
                            AGVRightSection {
                                width: parent.width - 24
                                title: "FAULT ALERTS"
                                icon: "⚠️"
                                visible: missionState.activeTab === "spray"

                                Rectangle {
                                    width: parent.width
                                    height: 36
                                    radius: 7
                                    color: Qt.rgba(31,241,143,0.05)
                                    border.color: Qt.rgba(31,241,143,0.15)
                                    border.width: 1

                                    Row {
                                        anchors.left: parent.left
                                        anchors.leftMargin: 12
                                        anchors.verticalCenter: parent.verticalCenter
                                        spacing: 8

                                        Text {
                                            text: "✅"
                                            font.pixelSize: 14
                                        }

                                        Text {
                                            text: "No Active Alerts"
                                            color: Qt.rgba(255,255,255,0.6)
                                            font.pixelSize: 11
                                        }
                                    }
                                }
                            }

                            // ══════════════════════════════════════════════
                            // HARVEST sections — show only when harvest active
                            // ══════════════════════════════════════════════

                            // Tool Control
                            Rectangle {
                                visible: missionState.activeTab === "harvest"
                                width:  parent.width
                                height: parent.height * 0.45
                                color:  "#0d0d0d"
                                border.color: Qt.rgba(255,255,255,0.07)
                                border.width: 1

                                Column {
                                    anchors.fill: parent; anchors.margins: 12; spacing: 10

                                    Row {
                                        width: parent.width; spacing: 8
                                        Rectangle { width: 3; height: 19; radius: 2; color: "#1ff18f"; anchors.verticalCenter: parent.verticalCenter }
                                        Text { text: "🔧"; font.pixelSize: 19; anchors.verticalCenter: parent.verticalCenter }
                                        Text {
                                            text: "TOOL CONTROL"; color: harvestPanelRef.st_fieldAction >= 0 ? "#1ff18f" : Qt.rgba(255,255,255,0.5)
                                            font.pixelSize: 12; font.weight: Font.ExtraBold
                                            font.letterSpacing: 1.5; font.family: "Courier New"
                                            anchors.verticalCenter: parent.verticalCenter
                                        }
                                    }

                                    // Blade Speed
                                    Rectangle {
                                        width: parent.width; height: (parent.height - 54) / 2
                                        radius: 8; color: Qt.rgba(255,255,255,0.03)
                                        border.color: Qt.rgba(255,255,255,0.07); border.width: 1

                                        Column {
                                            anchors.fill: parent; anchors.margins: 10; spacing: 6

                                            Row {
                                                width: parent.width
                                                Text { text: "⚡"; font.pixelSize: 14; anchors.verticalCenter: parent.verticalCenter }
                                                Item { width: 6; height: 1 }
                                                Text {
                                                    text: "Blade Speed"; color: Qt.rgba(255,255,255,0.5); font.pixelSize: 11
                                                    anchors.verticalCenter: parent.verticalCenter
                                                    width: parent.width - 90
                                                }
                                                Rectangle {
                                                    width: 70; height: 22; radius: 5; anchors.right: parent.right
                                                    color: Qt.rgba(31/255,241/255,143/255,0.08); border.color: Qt.rgba(31/255,241/255,143/255,0.22); border.width: 1
                                                    Text {
                                                        anchors.centerIn: parent
                                                        text: Math.round(harvestPanelRef.st_bladeSpeed) + " RPM"
                                                        color: "#1ff18f"; font.pixelSize: 10; font.weight: Font.Bold; font.family: "Courier New"
                                                    }
                                                }
                                            }

                                            Slider {
                                                id: bladeSl
                                                width: parent.width; from: 0; to: 3000; height: 20
                                                value: harvestPanelRef.st_bladeSpeed
                                                onValueChanged: harvestPanelRef.st_bladeSpeed = value
                                                background: Rectangle {
                                                    x: bladeSl.leftPadding; y: bladeSl.topPadding + bladeSl.availableHeight/2 - height/2
                                                    width: bladeSl.availableWidth; height: 3; radius: 2; color: Qt.rgba(255,255,255,0.1)
                                                    Rectangle { width: bladeSl.visualPosition * parent.width; height: 3; radius: 2; color: "#1ff18f" }
                                                }
                                                handle: Rectangle {
                                                    x: bladeSl.leftPadding + bladeSl.visualPosition * (bladeSl.availableWidth - width)
                                                    y: bladeSl.topPadding + bladeSl.availableHeight/2 - height/2
                                                    width: 14; height: 14; radius: 7
                                                    color: bladeSl.pressed ? "#1ff18f" : Qt.rgba(255,255,255,0.1)
                                                    border.color: "#1ff18f"; border.width: 2
                                                    Behavior on color { ColorAnimation { duration: 100 } }
                                                }
                                            }
                                        }
                                    }

                                    // Extraction Depth
                                    Rectangle {
                                        width: parent.width; height: (parent.height - 54) / 2
                                        radius: 8; color: Qt.rgba(255,255,255,0.03)
                                        border.color: Qt.rgba(255,255,255,0.07); border.width: 1

                                        Column {
                                            anchors.fill: parent; anchors.margins: 10; spacing: 6

                                            Row {
                                                width: parent.width
                                                Text { text: "📏"; font.pixelSize: 14; anchors.verticalCenter: parent.verticalCenter }
                                                Item { width: 6; height: 1 }
                                                Text {
                                                    text: "Extraction Depth"; color: Qt.rgba(255,255,255,0.5); font.pixelSize: 11
                                                    anchors.verticalCenter: parent.verticalCenter
                                                    width: parent.width - 72
                                                }
                                                Rectangle {
                                                    width: 58; height: 22; radius: 5; anchors.right: parent.right
                                                    color: Qt.rgba(31/255,241/255,143/255,0.08); border.color: Qt.rgba(31/255,241/255,143/255,0.22); border.width: 1
                                                    Text {
                                                        anchors.centerIn: parent
                                                        text: Math.round(harvestPanelRef.st_cutDepth) + " mm"
                                                        color: "#1ff18f"; font.pixelSize: 10; font.weight: Font.Bold; font.family: "Courier New"
                                                    }
                                                }
                                            }

                                            Slider {
                                                id: depthSl
                                                width: parent.width; from: 0; to: 200; height: 20
                                                value: harvestPanelRef.st_cutDepth
                                                onValueChanged: harvestPanelRef.st_cutDepth = value
                                                background: Rectangle {
                                                    x: depthSl.leftPadding; y: depthSl.topPadding + depthSl.availableHeight/2 - height/2
                                                    width: depthSl.availableWidth; height: 3; radius: 2; color: Qt.rgba(255,255,255,0.1)
                                                    Rectangle { width: depthSl.visualPosition * parent.width; height: 3; radius: 2; color: "#1ff18f" }
                                                }
                                                handle: Rectangle {
                                                    x: depthSl.leftPadding + depthSl.visualPosition * (depthSl.availableWidth - width)
                                                    y: depthSl.topPadding + depthSl.availableHeight/2 - height/2
                                                    width: 14; height: 14; radius: 7
                                                    color: depthSl.pressed ? "#1ff18f" : Qt.rgba(255,255,255,0.1)
                                                    border.color: "#1ff18f"; border.width: 2
                                                    Behavior on color { ColorAnimation { duration: 100 } }
                                                }
                                            }
                                        }
                                    }
                                }
                            }

                            // Rectangle {
                            //     visible: missionState.activeTab === "harvest"
                            //     width: parent.width; height: 1; color: Qt.rgba(255,255,255,0.07)
                            // }

                            // Session Status
                            Rectangle {
                                visible: missionState.activeTab === "harvest"
                                width:  parent.width
                                height: parent.height * 0.48
                                color:  "#0d0d0d"
                                border.color: Qt.rgba(255,255,255,0.07); border.width: 1

                                Column {
                                    anchors.fill: parent; anchors.margins: 12; spacing: 8

                                    Row {
                                        width: parent.width; spacing: 8
                                        Rectangle { width: 3; height: 19; radius: 2; color: "#1ff18f"; anchors.verticalCenter: parent.verticalCenter }
                                        Text { text: "📊"; font.pixelSize: 19; anchors.verticalCenter: parent.verticalCenter }
                                        Text {
                                            text: "SESSION STATUS"; color: Qt.rgba(255,255,255,0.5)
                                            font.pixelSize: 12; font.weight: Font.ExtraBold
                                            font.letterSpacing: 1.5; font.family: "Courier New"
                                            anchors.verticalCenter: parent.verticalCenter
                                        }
                                    }

                                    Grid {
                                        width: parent.width
                                        columns: 2; columnSpacing: 6; rowSpacing: 6

                                        Repeater {
                                            model: [
                                                { label: "Area Cleared",  val: missionState.isMissionActive("harvest") ? "546 m²" : "--" },
                                                { label: "Weeds Removed", val: missionState.isMissionActive("harvest") ? "128"    : "--" },
                                                { label: "Time Elapsed",  val: missionState.isMissionActive("harvest") ? "12:34"  : "--" },
                                                { label: "Coverage",      val: missionState.isMissionActive("harvest") ? "18%"    : "--" },
                                                { label: "Blade RPM",     val: missionState.isMissionActive("harvest") ? Math.round(harvestPanelRef.st_bladeSpeed).toString() : "--" },
                                                { label: "Cut Depth",     val: missionState.isMissionActive("harvest") ? Math.round(harvestPanelRef.st_cutDepth) + " mm" : "--" }
                                            ]
                                            delegate: Rectangle {
                                                width:  (parent.width - 6) / 2
                                                height: 42; radius: 8
                                                color:  Qt.rgba(255,255,255,0.03)
                                                border.color: Qt.rgba(255,255,255,0.07); border.width: 1
                                                Column {
                                                    anchors.centerIn: parent; spacing: 3
                                                    Text {
                                                        anchors.horizontalCenter: parent.horizontalCenter
                                                        text: modelData.val; color: "#1ff18f"
                                                        font.pixelSize: 14; font.weight: Font.Bold; font.family: "Courier New"
                                                    }
                                                    Text {
                                                        anchors.horizontalCenter: parent.horizontalCenter
                                                        text: modelData.label; color: Qt.rgba(255,255,255,0.35)
                                                        font.pixelSize: 9; font.letterSpacing: 0.3
                                                    }
                                                }
                                            }
                                        }
                                    }

                                    Rectangle {
                                        width: parent.width; height: 32; radius: 7
                                        color: Qt.rgba(31/255,241/255,143/255,0.08); border.color: Qt.rgba(31/255,241/255,143/255,0.22); border.width: 1
                                        Row {
                                            anchors.left: parent.left; anchors.leftMargin: 12
                                            anchors.verticalCenter: parent.verticalCenter; spacing: 8
                                            Text { text: "✅"; font.pixelSize: 14 }
                                            Text { text: "No Active Alerts"; color: Qt.rgba(255,255,255,0.5); font.pixelSize: 11 }
                                        }
                                    }
                                }
                            }
                            
                            // ══════════════════════════════════════════════
                            // Sow sections — show only when sow active
                            // ══════════════════════════════════════════════
                            
                            //  Sowing Parameters Rectangle
                            Rectangle {
                                visible: missionState.activeTab === "sow"
                                width:   parent.width
                                height:  parent.height * 0.45
                                color:   "#0d0d0d"
                                border.color: Qt.rgba(255,255,255,0.07); border.width: 1

                                Column {
                                    anchors.fill: parent; anchors.margins: 12; spacing: 10

                                    // Header
                                    Row {
                                        width: parent.width; spacing: 8; height: 22
                                        Rectangle { width: 3; height: 18; radius: 2; color: "#1ff18f"; anchors.verticalCenter: parent.verticalCenter }
                                        Text { text: "📐"; font.pixelSize: 18; anchors.verticalCenter: parent.verticalCenter }
                                        Text {
                                            text: "SOWING PARAMETERS"; color: Qt.rgba(255,255,255,0.5)
                                            font.pixelSize: 12; font.weight: Font.ExtraBold
                                            font.letterSpacing: 1.5; font.family: "Courier New"
                                            anchors.verticalCenter: parent.verticalCenter
                                        }
                                    }

                                    // ── Row Spacing slider ────────────────────────────────────────────
                                    Rectangle {
                                        width: parent.width; height: 35; radius: 8
                                        color: Qt.rgba(255,255,255,0.03); border.color: Qt.rgba(255,255,255,0.07); border.width: 1

                                        Column {
                                            anchors.fill: parent; anchors.margins: 8; spacing: 4

                                            Row {
                                                width: parent.width
                                                Text { text: "↔️  Row Spacing"; color: Qt.rgba(255,255,255,0.5); font.pixelSize: 11; anchors.verticalCenter: parent.verticalCenter; width: parent.width - 72} //width: parent.width - 72 
                                                Rectangle {
                                                    width: 68; height: 20; radius: 5; anchors.right: parent.right
                                                    color: Qt.rgba(31/255,241/255,143/255,0.08); border.color: Qt.rgba(31/255,241/255,143/255,0.22); border.width: 1
                                                    Text {
                                                        anchors.centerIn: parent
                                                        text: Math.round(sowPanelRef.st_rowSpacing) + " cm"
                                                        color: "#1ff18f"; font.pixelSize: 10; font.weight: Font.Bold; font.family: "Courier New"
                                                    }
                                                }
                                            }
                                            Slider {
                                                id: rowSpSl; width: parent.width; from: 5; to: 100; height: 18
                                                value: sowPanelRef.st_rowSpacing
                                                onValueChanged: sowPanelRef.st_rowSpacing = value
                                                background: Rectangle {
                                                    x: rowSpSl.leftPadding; y: rowSpSl.topPadding + rowSpSl.availableHeight/2 - height/2
                                                    width: rowSpSl.availableWidth; height: 3; radius: 2; color: Qt.rgba(255,255,255,0.1)
                                                    Rectangle { width: rowSpSl.visualPosition * parent.width; height: 3; radius: 2; color: "#1ff18f" }
                                                }
                                                handle: Rectangle {
                                                    x: rowSpSl.leftPadding + rowSpSl.visualPosition * (rowSpSl.availableWidth - width)
                                                    y: rowSpSl.topPadding + rowSpSl.availableHeight/2 - height/2
                                                    width: 14; height: 14; radius: 7
                                                    color: rowSpSl.pressed ? "#1ff18f" : Qt.rgba(255,255,255,0.1)
                                                    border.color: "#1ff18f"; border.width: 2
                                                    Behavior on color { ColorAnimation { duration: 100 } }
                                                }
                                            }
                                        }
                                    }

                                    // ── Seed Spacing slider ───────────────────────────────────────────
                                    Rectangle {
                                        width: parent.width; height: 35; radius: 8
                                        color: Qt.rgba(255,255,255,0.03); border.color: Qt.rgba(255,255,255,0.07); border.width: 1

                                        Column {
                                            anchors.fill: parent; anchors.margins: 8; spacing: 4

                                            Row {
                                                width: parent.width
                                                Text { text: "·  Seed Spacing"; color: Qt.rgba(255,255,255,0.5); font.pixelSize: 11; anchors.verticalCenter: parent.verticalCenter; width: parent.width - 72 }
                                                Rectangle {
                                                    width: 68; height: 17; radius: 5; anchors.right: parent.right
                                                    color: Qt.rgba(31/255,241/255,143/255,0.08); border.color: Qt.rgba(31/255,241/255,143/255,0.22); border.width: 1
                                                    Text {
                                                        anchors.centerIn: parent
                                                        text: Math.round(sowPanelRef.st_seedSpacing) + " cm"
                                                        color: "#1ff18f"; font.pixelSize: 10; font.weight: Font.Bold; font.family: "Courier New"
                                                    }
                                                }
                                            }
                                            Slider {
                                                id: seedSpSl; width: parent.width; from: 2; to: 50; height: 18
                                                value: sowPanelRef.st_seedSpacing
                                                onValueChanged: sowPanelRef.st_seedSpacing = value
                                                background: Rectangle {
                                                    x: seedSpSl.leftPadding; y: seedSpSl.topPadding + seedSpSl.availableHeight/2 - height/2
                                                    width: seedSpSl.availableWidth; height: 3; radius: 2; color: Qt.rgba(255,255,255,0.1)
                                                    Rectangle { width: seedSpSl.visualPosition * parent.width; height: 3; radius: 2; color: "#1ff18f" }
                                                }
                                                handle: Rectangle {
                                                    x: seedSpSl.leftPadding + seedSpSl.visualPosition * (seedSpSl.availableWidth - width)
                                                    y: seedSpSl.topPadding + seedSpSl.availableHeight/2 - height/2
                                                    width: 14; height: 14; radius: 7
                                                    color: seedSpSl.pressed ? "#1ff18f" : Qt.rgba(255,255,255,0.1)
                                                    border.color: "#1ff18f"; border.width: 2
                                                    Behavior on color { ColorAnimation { duration: 100 } }
                                                }
                                            }
                                        }
                                    }

                                    // ── Multi Row Mode toggle ─────────────────────────────────────────
                                    Rectangle {
                                        width: parent.width; height: 34; radius: 8
                                        color: sowPanelRef.st_multiRow ? Qt.rgba(31/255,241/255,143/255,0.08) : Qt.rgba(255,255,255,0.03)
                                        border.color: sowPanelRef.st_multiRow ? Qt.rgba(31/255,241/255,143/255,0.22) : Qt.rgba(255,255,255,0.07); border.width: 1
                                        Behavior on color        { ColorAnimation { duration: 150 } }
                                        Behavior on border.color { ColorAnimation { duration: 150 } }

                                        Row {
                                            anchors.left: parent.left; anchors.leftMargin: 10
                                            anchors.verticalCenter: parent.verticalCenter; spacing: 7
                                            Text { text: "⋮⋮"; font.pixelSize: 14; anchors.verticalCenter: parent.verticalCenter }
                                            Text { text: "Multi Row Mode"; color: Qt.rgba(255,255,255,0.5); font.pixelSize: 11; anchors.verticalCenter: parent.verticalCenter }
                                        }

                                        Rectangle {
                                            anchors.right: parent.right; anchors.rightMargin: 10
                                            anchors.verticalCenter: parent.verticalCenter
                                            width: 38; height: 20; radius: 10
                                            color: sowPanelRef.st_multiRow ? Qt.rgba(31/255,241/255,143/255,0.4) : Qt.rgba(255,255,255,0.1)
                                            border.color: sowPanelRef.st_multiRow ? "#1ff18f" : Qt.rgba(255,255,255,0.07); border.width: 1
                                            Behavior on color        { ColorAnimation { duration: 150 } }
                                            Behavior on border.color { ColorAnimation { duration: 150 } }
                                            Rectangle {
                                                width: 14; height: 14; radius: 7; y: 3
                                                x: sowPanelRef.st_multiRow ? parent.width - width - 3 : 3
                                                color: sowPanelRef.st_multiRow ? "#1ff18f" : Qt.rgba(255,255,255,0.35)
                                                Behavior on x     { NumberAnimation { duration: 150; easing.type: Easing.InOutQuad } }
                                                Behavior on color { ColorAnimation  { duration: 150 } }
                                            }
                                            MouseArea {
                                                anchors.fill: parent; cursorShape: Qt.PointingHandCursor
                                                onClicked: sowPanelRef.st_multiRow = !sowPanelRef.st_multiRow
                                            }
                                        }
                                    }

                                } // end Column
                            }

                            Rectangle {
                                visible: missionState.activeTab === "sow"
                                width: parent.width; height: 1; color: Qt.rgba(255,255,255,0.07)
                            }

                            // ── Session Stats ─────────────────────────────────────────────────────────────
                            Rectangle {
                                visible: missionState.activeTab === "sow"
                                width:   parent.width
                                height:  parent.height * 0.35
                                color:   "#0d0d0d"
                                border.color: Qt.rgba(255,255,255,0.07); border.width: 1

                                Column {
                                    anchors.fill: parent; anchors.margins: 12; spacing: 8

                                    Row {
                                        width: parent.width; spacing: 8; height: 22
                                        Rectangle { width: 3; height: 18; radius: 2; color: "#1ff18f"; anchors.verticalCenter: parent.verticalCenter }
                                        Text { text: "📊"; font.pixelSize: 18; anchors.verticalCenter: parent.verticalCenter }
                                        Text {
                                            text: "SESSION STATS"; color: Qt.rgba(255,255,255,0.5)
                                            font.pixelSize: 12; font.weight: Font.ExtraBold
                                            font.letterSpacing: 1.5; font.family: "Courier New"
                                            anchors.verticalCenter: parent.verticalCenter
                                        }
                                    }

                                    Grid {
                                        width: parent.width; columns: 2; columnSpacing: 6; rowSpacing: 6

                                        Repeater {
                                            model: [
                                                { label: "Hopper Level", val: missionState.isMissionActive("sow") ? "78%"   : "--" },
                                                { label: "Seeds Sown",   val: missionState.isMissionActive("sow") ? "2,480" : "--" },
                                                { label: "Row Count",    val: missionState.isMissionActive("sow") ? "14"    : "--" },
                                                { label: "Area Covered", val: missionState.isMissionActive("sow") ? "320 m²": "--" },
                                                { label: "Time Elapsed", val: missionState.isMissionActive("sow") ? "08:42" : "--" },
                                                { label: "Est. Remain",  val: missionState.isMissionActive("sow") ? "22 min": "--" }
                                            ]
                                            delegate: Rectangle {
                                                width:  (parent.width - 6) / 2
                                                height: 42; radius: 8
                                                color:  Qt.rgba(255,255,255,0.03)
                                                border.color: Qt.rgba(255,255,255,0.07); border.width: 1
                                                Column {
                                                    anchors.centerIn: parent; spacing: 3
                                                    Text {
                                                        anchors.horizontalCenter: parent.horizontalCenter
                                                        text: modelData.val; color: "#1ff18f"
                                                        font.pixelSize: 14; font.weight: Font.Bold; font.family: "Courier New"
                                                    }
                                                    Text {
                                                        anchors.horizontalCenter: parent.horizontalCenter
                                                        text: modelData.label; color: Qt.rgba(255,255,255,0.35)
                                                        font.pixelSize: 9; font.letterSpacing: 0.3
                                                    }
                                                }
                                            }
                                        }
                                    }

                                    // Fault row
                                    Rectangle {
                                        width: parent.width; height: 32; radius: 7
                                        color: Qt.rgba(31/255,241/255,143/255,0.08); border.color: Qt.rgba(31/255,241/255,143/255,0.22); border.width: 1
                                        Row {
                                            anchors.left: parent.left; anchors.leftMargin: 12
                                            anchors.verticalCenter: parent.verticalCenter; spacing: 8
                                            Text { text: "✅"; font.pixelSize: 14 }
                                            Text { text: "No Active Alerts"; color: Qt.rgba(255,255,255,0.5); font.pixelSize: 11 }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                //=============================================================
                // BOTTOM PANEL - Tab Controls (Spray/Harvest/Sow)
                //=============================================================
                
                Rectangle {
                    id:     bottomPanel
                    width:  parent.width
                    height: mainColumn.height - sizeState.topH //300 //mainContent.height - topRow.height   //300
                    color:  "#0d0d0d"

                    QtObject {
                        id: missionState
                        property string activeTab:    "spray"
                        property string missionOwner: ""

                        function startMission(tab) { missionOwner = tab }
                        function stopMission()     { missionOwner = "" }
                        function isMissionActive(tab) { return missionOwner === tab }
                        function isLocked(tab)        { return missionOwner !== "" && missionOwner !== tab }
                    }

                    Column {
                        anchors.fill: parent
                        spacing: 0

                        // Tab Bar
                        Rectangle {
                            id:     tabBar
                            width:  parent.width
                            height: 44
                            color:  "#060e09"

                            Rectangle {
                                anchors.bottom: parent.bottom
                                width: parent.width; height: 1
                                color: Qt.rgba(255,255,255,0.08)
                            }

                            Row {
                                anchors.left:    parent.left
                                anchors.top:     parent.top
                                anchors.bottom:  parent.bottom
                                anchors.leftMargin: 10
                                spacing: 4

                                Repeater {
                                    model: [
                                        { id: "spray",   label: "Spray",           icon: "💧" },
                                        { id: "harvest", label: "Weed Harvesting",  icon: "🌿" },
                                        { id: "sow",     label: "Crop Sowing",      icon: "🌱" }
                                    ]

                                    delegate: Rectangle {
                                        id: tabBtn
                                        property bool isActive:  missionState.activeTab === modelData.id
                                        property bool hasMission: missionState.isMissionActive(modelData.id)
                                        property bool isLocked:   missionState.isLocked(modelData.id)

                                        height: tabBar.height
                                        width:  tabRow.implicitWidth + 32
                                        color: "transparent"
                                        opacity: isLocked ? 0.45 : 1

                                        Rectangle {
                                            anchors.bottom: parent.bottom
                                            width: parent.width; height: 2
                                            color: tabBtn.isActive ? "#1ff18f" : "transparent"
                                            Behavior on color { ColorAnimation { duration: 150 } }
                                        }

                                        Row {
                                            id: tabRow
                                            anchors.centerIn: parent
                                            spacing: 7

                                            Text {
                                                text: modelData.icon
                                                font.pixelSize: 14
                                                anchors.verticalCenter: parent.verticalCenter
                                            }

                                            Text {
                                                text: modelData.label
                                                color: tabBtn.isLocked ? Qt.rgba(255,255,255,0.2)
                                                     : tabBtn.isActive  ? "#ffffff"
                                                     : Qt.rgba(255,255,255,0.6)
                                                // color: tabBtn.isLocked ? Qt.rgba(255,255,255,0.35)
                                                //     : tabBtn.isActive  ? "#ffffff"
                                                //     : Qt.rgba(255,255,255,0.5)
                                                font.pixelSize: 12
                                                font.weight: tabBtn.isActive ? Font.Bold : Font.Normal
                                                anchors.verticalCenter: parent.verticalCenter
                                                Behavior on color { ColorAnimation { duration: 150 } }
                                            }

                                            Rectangle {
                                                width: 6; height: 6; radius: 3
                                                color: "#1ff18f"
                                                anchors.verticalCenter: parent.verticalCenter
                                                visible: tabBtn.hasMission
                                            }

                                            Text {
                                                text: "🔒"
                                                font.pixelSize: 9
                                                color: Qt.rgba(255,255,255,0.2)
                                                anchors.verticalCenter: parent.verticalCenter
                                                visible: tabBtn.isLocked
                                            }
                                        }

                                        MouseArea {
                                            anchors.fill: parent
                                            hoverEnabled: true
                                            cursorShape: tabBtn.isLocked ? Qt.ForbiddenCursor : Qt.PointingHandCursor
                                            onClicked: {
                                                if (!tabBtn.isLocked)
                                                    missionState.activeTab = modelData.id
                                            }
                                        }
                                    }
                                }
                            }

                            // Right status area
                            Row {
                                anchors.right:          parent.right
                                anchors.rightMargin:    12
                                anchors.verticalCenter: parent.verticalCenter
                                spacing: 12

                                Rectangle {
                                    visible: missionState.missionOwner !== ""
                                    height: 26; radius: 13
                                    width: missionBadgeRow.implicitWidth + 24
                                    color: Qt.rgba(31,241,143,0.08)
                                    border.color: Qt.rgba(31,241,143,0.25); border.width: 1

                                    Row {
                                        id: missionBadgeRow
                                        anchors.centerIn: parent; spacing: 6
                                        Rectangle { width: 6; height: 6; radius: 3; color: "#1ff18f"; anchors.verticalCenter: parent.verticalCenter }
                                        Text { text: "MISSION ACTIVE"; color: "#1ff18f"; font.pixelSize: 10; font.weight: Font.DemiBold; font.letterSpacing: 1; font.family: "Courier New" }
                                    }
                                }

                                Repeater {
                                    model: [["🛰️", "GPS: RTK FIX"], ["🔋", "78%"], ["📡", "LTE"]]
                                    delegate: Row {
                                        spacing: 4; anchors.verticalCenter: parent ? parent.verticalCenter : undefined
                                        Text { text: modelData[0]; font.pixelSize: 12 }
                                        Text { text: modelData[1]; color: Qt.rgba(255,255,255,0.38); font.pixelSize: 10 }
                                    }
                                }
                            }
                        }

                        // Panel stack
                        Item {
                            width:  parent.width
                            height: parent.height - tabBar.height

                            SprayPanel {
                                id: sprayPanelRef
                                anchors.fill:   parent
                                // th:           agvView.th
                                // darkTheme:    agvView.darkTheme
                                visible:        missionState.activeTab === "spray"
                                missionActive:  missionState.isMissionActive("spray")
                                locked:         missionState.isLocked("spray")
                                onMissionStartRequested: missionState.startMission("spray")
                                onMissionStopRequested:  missionState.stopMission()
                            }

                            HarvestPanel {
                                id: harvestPanelRef
                                anchors.fill:   parent
                                visible:        missionState.activeTab === "harvest"
                                missionActive:  missionState.isMissionActive("harvest")
                                locked:         missionState.isLocked("harvest")
                                onMissionStartRequested: missionState.startMission("harvest")
                                onMissionStopRequested:  missionState.stopMission()
                            }

                            SowPanel {
                                id: sowPanelRef
                                anchors.fill:   parent
                                visible:        missionState.activeTab === "sow"
                                missionActive:  missionState.isMissionActive("sow")
                                locked:         missionState.isLocked("sow")
                                onMissionStartRequested: missionState.startMission("sow")
                                onMissionStopRequested:  missionState.stopMission()
                            }
                        }
                    }
                }
            }
        }
    }
}
