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

    QGCPalette { id: qgcPal; colorGroupEnabled: true }

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

        Row {
            anchors.fill: parent
            spacing: 0

            //=================================================================
            // LEFT PANEL - Mission Data & Telemetry
            //=================================================================
            
            Rectangle {
                id:     leftPanel
                width:  320
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
                            value: "0.064"
                            unit: ""
                            gaugeValue: 0.32
                            gaugeColor: "#ff9800"
                        }

                        // Temperature Gauge
                        AGVTelemetryGauge {
                            width: parent.width
                            title: "TEMPERATURE"
                            value: "-29.16"
                            unit: "°C"
                            gaugeValue: 0.45
                            gaugeColor: "#4caf50"
                        }

                        // Atmosphere
                        AGVTelemetryItem {
                            width: parent.width
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
                                        Text { text: "CELL"; color: "#666666"; font.pixelSize: 10 }
                                        Text { text: "65.25"; color: "#ffffff"; font.pixelSize: 13 }
                                    }

                                    Column {
                                        spacing: 6
                                        Text { text: "GAS PRESS"; color: "#666666"; font.pixelSize: 10 }
                                        Text { text: "12.48"; color: "#ffffff"; font.pixelSize: 13 }
                                    }

                                    Column {
                                        spacing: 6
                                        Text { text: "MODE"; color: "#666666"; font.pixelSize: 10 }
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
            
            Rectangle {
                width:  parent.width - leftPanel.width
                height: parent.height
                color:  "#1a1a1a"

                Column {
                    anchors.fill: parent
                    spacing: 0

                    //=========================================================
                    // Camera Feed Area
                    //=========================================================
                    
                    // Rectangle {
                    //     width:  parent.width
                    //     height: parent.height - 300
                    //     color:  "#000000"

                    //     // Camera Control Panel Header
                    //     Rectangle {
                    //         width: parent.width
                    //         height: 40
                    //         color: Qt.rgba(0, 0, 0, 0.7)
                    //         z: 10

                    //         Row {
                    //             anchors.left: parent.left
                    //             anchors.leftMargin: 20
                    //             anchors.verticalCenter: parent.verticalCenter
                    //             spacing: 15

                    //             Text {
                    //                 text: "CAMERA CONTROL PANEL"
                    //                 color: "#ffffff"
                    //                 font.pixelSize: 13
                    //                 font.weight: Font.Bold
                    //             }

                    //             // Camera thumbnails would go here
                    //         }

                    //         // Right arrow
                    //         Text {
                    //             anchors.right: parent.right
                    //             anchors.rightMargin: 20
                    //             anchors.verticalCenter: parent.verticalCenter
                    //             text: "›"
                    //             color: "#ffffff"
                    //             font.pixelSize: 32
                    //         }
                    //     }

                    //     // Video Stream (QGC's video widget)
                    //     QGCVideoBackground {
                    //         anchors.fill: parent
                    //         // display: QGroundControl.videoManager.videoReceiver
                    //         // receiver: QGroundControl.videoManager.videoReceiver
                    //         visible: QGroundControl.videoManager.hasVideo

                    //         // Camera controls overlay (bottom right)
                    //         Rectangle {
                    //             anchors.right: parent.right
                    //             anchors.bottom: parent.bottom
                    //             anchors.margins: 20
                    //             width: 100
                    //             height: 150
                    //             radius: 8
                    //             color: Qt.rgba(0, 0, 0, 0.6)

                    //             Column {
                    //                 anchors.centerIn: parent
                    //                 spacing: 10

                    //                 // Zoom buttons
                    //                 Row {
                    //                     anchors.horizontalCenter: parent.horizontalCenter
                    //                     spacing: 10

                    //                     AGVCameraButton { label: "-"; buttonType: "zoom_out" }
                    //                     AGVCameraButton { label: "+"; buttonType: "zoom_in" }
                    //                 }

                    //                 // Directional pad
                    //                 Grid {
                    //                     columns: 3
                    //                     rows: 3
                    //                     spacing: 5
                    //                     anchors.horizontalCenter: parent.horizontalCenter

                    //                     Item { width: 28; height: 28 }
                    //                     AGVCameraButton { label: "▲"; buttonType: "up" }
                    //                     Item { width: 28; height: 28 }

                    //                     AGVCameraButton { label: "◀"; buttonType: "left" }
                    //                     AGVCameraButton { label: "●"; buttonType: "center" }
                    //                     AGVCameraButton { label: "▶"; buttonType: "right" }

                    //                     Item { width: 28; height: 28 }
                    //                     AGVCameraButton { label: "▼"; buttonType: "down" }
                    //                     Item { width: 28; height: 28 }
                    //                 }
                    //             }
                    //         }
                    //     }

                    //     // Placeholder when no video
                    //     Rectangle {
                    //         anchors.fill: parent
                    //         color: "#1a1a1a"
                    //         visible: !QGroundControl.videoManager.hasVideo

                    //         Column {
                    //             anchors.centerIn: parent
                    //             spacing: 15

                    //             Text {
                    //                 anchors.horizontalCenter: parent.horizontalCenter
                    //                 text: "📹"
                    //                 font.pixelSize: 64
                    //             }

                    //             Text {
                    //                 anchors.horizontalCenter: parent.horizontalCenter
                    //                 text: "No Video Stream"
                    //                 color: "#666666"
                    //                 font.pixelSize: 16
                    //             }
                    //         }
                    //     }
                    // }

                    Rectangle {
                        width:  parent.width
                        height: parent.height - 300
                        color:  "#000000"

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
                            // allowMapArbitraryCenter: false
                            visible:        showMap
                            z:              1

                            Component.onCompleted: {
                                // Try active vehicle position first
                                if (_activeVehicle && _activeVehicle.coordinate.isValid) {
                                    center = _activeVehicle.coordinate
                                    zoomLevel = 17
                                    return
                                }

                                // Fall back to GCS (system) location
                                if (QGroundControl.qgcPositionManger.gcsPosition.isValid) {
                                    center = QGroundControl.qgcPositionManger.gcsPosition
                                    zoomLevel = 16
                                    return
                                }
                            }

                            // Keep updating to vehicle position when connected
                            Connections {
                                target: QGroundControl.multiVehicleManager
                                function onActiveVehicleChanged(activeVehicle) {
                                    if (activeVehicle && activeVehicle.coordinate.isValid) {
                                        agvMap.center    = activeVehicle.coordinate
                                        agvMap.zoomLevel = 17
                                    }
                                }
                            }

                            // Also follow vehicle position while connected
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
                                // Reset follow mode when vehicle reconnects
                            }
                        }

                        // Video View
                        Item {
                            anchors.fill:   parent
                            visible:        !showMap
                            z:              1

                            QGCVideoBackground {
                                anchors.fill:   parent
                                // display:        QGroundControl.videoManager.videoReceiver
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

                            // Camera controls overlay (bottom right) - only in video mode
                            // Rectangle {
                            //     anchors.right:   parent.right
                            //     anchors.bottom:  parent.bottom
                            //     anchors.margins: 20
                            //     width:           100
                            //     height:          150
                            //     radius:          8
                            //     color:           Qt.rgba(0, 0, 0, 0.6)

                            //     Column {
                            //         anchors.centerIn: parent
                            //         spacing:          10

                            //         Row {
                            //             anchors.horizontalCenter: parent.horizontalCenter
                            //             spacing: 10
                            //             AGVCameraButton { label: "-"; buttonType: "zoom_out" }
                            //             AGVCameraButton { label: "+"; buttonType: "zoom_in"  }
                            //         }

                            //         Grid {
                            //             columns: 3
                            //             rows:    3
                            //             spacing: 5
                            //             anchors.horizontalCenter: parent.horizontalCenter

                            //             Item             { width: 28; height: 28 }
                            //             AGVCameraButton  { label: "▲"; buttonType: "up"     }
                            //             Item             { width: 28; height: 28 }

                            //             AGVCameraButton  { label: "◀"; buttonType: "left"   }
                            //             AGVCameraButton  { label: "●"; buttonType: "center" }
                            //             AGVCameraButton  { label: "▶"; buttonType: "right"  }

                            //             Item             { width: 28; height: 28 }
                            //             AGVCameraButton  { label: "▼"; buttonType: "down"   }
                            //             Item             { width: 28; height: 28 }
                            //         }
                            //     }
                            // }

                            // Camera controls overlay (bottom right) - only in video mode
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

                                    // Row 1
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

                                    // Row 2
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

                                    // Row 3
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
                    // Bottom Section - Tabs & Details
                    //=========================================================
                    
                    // // 1st iteration
                    // Rectangle {
                    //     id: bottomPanel
                    //     width:  parent.width
                    //     height: 300
                    //     color:  "#0d0d0d"

                    //     Column {
                    //         anchors.fill: parent
                    //         spacing: 0

                    //         // Tab Bar
                    //         Rectangle {
                    //             width: parent.width
                    //             height: 50
                    //             color: "#1a1a1a"

                    //             Row {
                    //                 anchors.centerIn: parent
                    //                 spacing: 2

                    //                 AGVTabButton {
                    //                     label: "SPRAY"
                    //                     isActive: tabBar.currentIndex === 0
                    //                     onClicked: tabBar.currentIndex = 0
                    //                 }

                    //                 // AGVTabButton {
                    //                 //     label: "SPREAD"
                    //                 //     isActive: tabBar.currentIndex === 1
                    //                 //     onClicked: tabBar.currentIndex = 1
                    //                 // }

                    //                 AGVTabButton {
                    //                     label: "SEED HARVESTING"
                    //                     isActive: tabBar.currentIndex === 2
                    //                     onClicked: tabBar.currentIndex = 2
                    //                 }

                    //                 AGVTabButton {
                    //                     label: "CROP SOWING"
                    //                     isActive: tabBar.currentIndex === 3
                    //                     onClicked: tabBar.currentIndex = 3
                    //                 }
                    //             }
                    //         }

                    //         // Tab Content Area
                    //         Rectangle {
                    //             width: parent.width
                    //             height: parent.height - 50
                    //             color: "#0d0d0d"

                    //             QtObject {
                    //                 id: tabBar
                    //                 property int currentIndex: 0
                    //             }

                    //             StackLayout {
                    //                 anchors.fill: parent
                    //                 currentIndex: tabBar.currentIndex

                    //                 // Spray Tab
                    //                 SprayPanel { }

                    //                 // Spread Tab
                    //                 // SpreadPanel { }

                    //                 // Harvest Seeds Tab
                    //                 HarvestPanel { }

                    //                 // Sow Onions Tab
                    //                 SowPanel { }
                    //             }
                    //         }
                    //     }
                    // }

                    Rectangle {
                        id:     bottomPanel
                        width:  parent.width
                        height: 300
                        color:  "#0d0d0d"

                        // ── Global mission state ─────────────────────────────
                        QtObject {
                            id: missionState
                            property string activeTab:    "spray"   // "spray" | "harvest" | "sow"
                            property string missionOwner: ""        // "" | "spray" | "harvest" | "sow"

                            function startMission(tab) { missionOwner = tab }
                            function stopMission()     { missionOwner = "" }
                            function isMissionActive(tab) { return missionOwner === tab }
                            function isLocked(tab)        { return missionOwner !== "" && missionOwner !== tab }
                        }

                        Column {
                            anchors.fill: parent
                            spacing: 0

                            // ── Tab Bar ──────────────────────────────────────
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
                                            property bool hovered: false

                                            height: tabBar.height
                                            width:  tabRow.implicitWidth + 32

                                            color: "transparent"
                                            opacity: isLocked ? 0.45 : 1

                                            // Bottom active indicator
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
                                                    font.pixelSize: 12
                                                    font.weight: tabBtn.isActive ? Font.Bold : Font.Normal
                                                    anchors.verticalCenter: parent.verticalCenter
                                                    Behavior on color { ColorAnimation { duration: 150 } }
                                                }

                                                // Active mission dot
                                                Rectangle {
                                                    width: 6; height: 6; radius: 3
                                                    color: "#1ff18f"
                                                    anchors.verticalCenter: parent.verticalCenter
                                                    visible: tabBtn.hasMission
                                                }

                                                // Lock icon
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
                                                onEntered: tabBtn.hovered = true
                                                onExited:  tabBtn.hovered = false
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

                                    // Mission active badge
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

                                    // Status chips
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

                            // ── Panel stack ──────────────────────────────────
                            Item {
                                width:  parent.width
                                height: parent.height - tabBar.height

                                SprayPanel {
                                    anchors.fill:   parent
                                    visible:        missionState.activeTab === "spray"
                                    missionActive:  missionState.isMissionActive("spray")
                                    locked:         missionState.isLocked("spray")
                                    onMissionStartRequested: missionState.startMission("spray")
                                    onMissionStopRequested:  missionState.stopMission()
                                }

                                HarvestPanel {
                                    anchors.fill:   parent
                                    visible:        missionState.activeTab === "harvest"
                                    missionActive:  missionState.isMissionActive("harvest")
                                    locked:         missionState.isLocked("harvest")
                                    onMissionStartRequested: missionState.startMission("harvest")
                                    onMissionStopRequested:  missionState.stopMission()
                                }

                                SowPanel {
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
}
