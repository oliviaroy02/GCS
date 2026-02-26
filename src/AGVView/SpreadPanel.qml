// //C:\NestLink\GCS\src\AGVView\SpreadPanel.qml
// import QtQuick
// import QtQuick.Controls

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



import QtQuick
import QtQuick.Controls

Rectangle {
    anchors.fill:   parent
    color:          "#0d0d0d"

    readonly property string _accent: "#1ff18f"

    Row {
        anchors.fill:           parent
        anchors.margins:        12
        spacing:                10

        // ── A. Detection Mode ─────────────────────────────────
        Rectangle {
            width:  (parent.width - 30) / 4
            height: parent.height
            color:  Qt.rgba(1,1,1,0.02)
            radius: 6
            border.color: Qt.rgba(255/255, 31/255, 143/255, 0.15)
            border.width: 1

            Column {
                anchors.fill:           parent
                anchors.margins:        10
                spacing:                4

                // Section header
                Row {
                    width:   parent.width
                    height:  22
                    spacing: 6

                    Rectangle {
                        width:                  3
                        height:                 14
                        radius:                 2
                        color:                  _accent
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Text {
                        text:               "DETECTION MODE"
                        color:              _accent
                        font.pixelSize:     9
                        font.weight:        Font.Bold
                        font.letterSpacing: 1.2
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }

                Rectangle { width: parent.width; height: 1; color: Qt.rgba(1,1,1,0.06) }

                Repeater {
                    model: ["AI Vision Mode", "Pre-Mapped Seed Zones", "Manual Area Selection"]

                    delegate: Rectangle {
                        width:      parent.width
                        height:     (parent.parent.height - 80) / 3
                        radius:     4
                        color:      sel ? Qt.rgba(31/255,241/255,143/255,0.08) :
                                    ma.containsMouse ? Qt.rgba(1,1,1,0.03) : "transparent"
                        property bool sel: false
                        Behavior on color { ColorAnimation { duration: 80 } }

                        Row {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left:           parent.left
                            anchors.leftMargin:     8
                            spacing:                8

                            Rectangle {
                                width:                  8
                                height:                 8
                                radius:                 parent.parent.sel ? 2 : 4
                                anchors.verticalCenter: parent.verticalCenter
                                color:                  parent.parent.sel ? _accent : "transparent"
                                border.color:           parent.parent.sel ? _accent : Qt.rgba(1,1,1,0.25)
                                border.width:           1
                                Behavior on color  { ColorAnimation  { duration: 120 } }
                                Behavior on radius { NumberAnimation { duration: 120 } }
                            }

                            Text {
                                text:           modelData
                                color:          parent.parent.sel ? "#ffffff" : "#666666"
                                font.pixelSize: 11
                                Behavior on color { ColorAnimation { duration: 120 } }
                            }
                        }

                        Text {
                            anchors.right:          parent.right
                            anchors.rightMargin:    8
                            anchors.verticalCenter: parent.verticalCenter
                            text:                   "✓"
                            color:                  _accent
                            font.pixelSize:         10
                            visible:                parent.sel
                        }

                        MouseArea {
                            id:             ma
                            anchors.fill:   parent
                            hoverEnabled:   true
                            cursorShape:    Qt.PointingHandCursor
                            onClicked: {
                                var col = parent.parent
                                for (var i = 0; i < col.children.length; i++)
                                    col.children[i].sel = false
                                parent.sel = true
                            }
                        }
                    }
                }
            }
        }

        // ── B. Weed Type ──────────────────────────────────────
        Rectangle {
            width:  (parent.width - 30) / 4
            height: parent.height
            color:  Qt.rgba(1,1,1,0.02)
            radius: 6
            border.color: Qt.rgba(255/255, 31/255, 143/255, 0.15)
            border.width: 1

            Column {
                anchors.fill:    parent
                anchors.margins: 10
                spacing:         4

                Row {
                    width:   parent.width
                    height:  22
                    spacing: 6
                    Rectangle {
                        width: 3; height: 14; radius: 2; color: _accent
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Text {
                        text: "WEED TYPE"; color: _accent
                        font.pixelSize: 9; font.weight: Font.Bold; font.letterSpacing: 1.2
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }

                Rectangle { width: parent.width; height: 1; color: Qt.rgba(1,1,1,0.06) }

                Repeater {
                    model: ["Grass Weeds", "Broadleaf", "Custom"]
                    delegate: Rectangle {
                        width: parent.width
                        height: (parent.parent.height - 80) / 3
                        radius: 4
                        color:  sel ? Qt.rgba(31/255,241/255,143/255,0.08) :
                                ma.containsMouse ? Qt.rgba(1,1,1,0.03) : "transparent"
                        property bool sel: false
                        Behavior on color { ColorAnimation { duration: 80 } }

                        Row {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left; anchors.leftMargin: 8
                            spacing: 8
                            Rectangle {
                                width: 8; height: 8
                                radius: parent.parent.sel ? 2 : 4
                                anchors.verticalCenter: parent.verticalCenter
                                color: parent.parent.sel ? _accent : "transparent"
                                border.color: parent.parent.sel ? _accent : Qt.rgba(1,1,1,0.25)
                                border.width: 1
                                Behavior on color  { ColorAnimation  { duration: 120 } }
                                Behavior on radius { NumberAnimation { duration: 120 } }
                            }
                            Text {
                                text: modelData
                                color: parent.parent.sel ? "#ffffff" : "#666666"
                                font.pixelSize: 11
                                Behavior on color { ColorAnimation { duration: 120 } }
                            }
                        }

                        Text {
                            anchors.right: parent.right; anchors.rightMargin: 8
                            anchors.verticalCenter: parent.verticalCenter
                            text: "✓"; color: _accent; font.pixelSize: 10
                            visible: parent.sel
                        }

                        MouseArea {
                            id: ma; anchors.fill: parent
                            hoverEnabled: true; cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                var col = parent.parent
                                for (var i = 0; i < col.children.length; i++)
                                    col.children[i].sel = false
                                parent.sel = true
                            }
                        }
                    }
                }
            }
        }

        // ── C. Operation Mode ─────────────────────────────────
        Rectangle {
            width:  (parent.width - 30) / 4
            height: parent.height
            color:  Qt.rgba(1,1,1,0.02)
            radius: 6
            border.color: Qt.rgba(255/255, 31/255, 143/255, 0.15)
            border.width: 1

            Column {
                anchors.fill:    parent
                anchors.margins: 10
                spacing:         4

                Row {
                    width:   parent.width
                    height:  22
                    spacing: 6
                    Rectangle {
                        width: 3; height: 14; radius: 2; color: _accent
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Text {
                        text: "OPERATION MODE"; color: _accent
                        font.pixelSize: 9; font.weight: Font.Bold; font.letterSpacing: 1.2
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }

                Rectangle { width: parent.width; height: 1; color: Qt.rgba(1,1,1,0.06) }

                Repeater {
                    model: ["Surface Cutting", "Precision Root Removal", "Full Surface"]
                    delegate: Rectangle {
                        width: parent.width
                        height: (parent.parent.height - 80) / 3
                        radius: 4
                        color:  sel ? Qt.rgba(31/255,241/255,143/255,0.08) :
                                ma.containsMouse ? Qt.rgba(1,1,1,0.03) : "transparent"
                        property bool sel: false
                        Behavior on color { ColorAnimation { duration: 80 } }

                        Row {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left; anchors.leftMargin: 8
                            spacing: 8
                            Rectangle {
                                width: 8; height: 8
                                radius: parent.parent.sel ? 2 : 4
                                anchors.verticalCenter: parent.verticalCenter
                                color: parent.parent.sel ? _accent : "transparent"
                                border.color: parent.parent.sel ? _accent : Qt.rgba(1,1,1,0.25)
                                border.width: 1
                                Behavior on color  { ColorAnimation  { duration: 120 } }
                                Behavior on radius { NumberAnimation { duration: 120 } }
                            }
                            Text {
                                text: modelData
                                color: parent.parent.sel ? "#ffffff" : "#666666"
                                font.pixelSize: 11
                                Behavior on color { ColorAnimation { duration: 120 } }
                            }
                        }

                        Text {
                            anchors.right: parent.right; anchors.rightMargin: 8
                            anchors.verticalCenter: parent.verticalCenter
                            text: "✓"; color: _accent; font.pixelSize: 10
                            visible: parent.sel
                        }

                        MouseArea {
                            id: ma; anchors.fill: parent
                            hoverEnabled: true; cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                var col = parent.parent
                                for (var i = 0; i < col.children.length; i++)
                                    col.children[i].sel = false
                                parent.sel = true
                            }
                        }
                    }
                }
            }
        }

        // ── D. Tool Control ───────────────────────────────────
        Rectangle {
            width:  (parent.width - 30) / 4
            height: parent.height
            color:  Qt.rgba(1,1,1,0.02)
            radius: 6
            border.color: Qt.rgba(255/255, 31/255, 143/255, 0.15)
            border.width: 1

            Column {
                anchors.fill:    parent
                anchors.margins: 10
                spacing:         10

                Row {
                    width:   parent.width
                    height:  22
                    spacing: 6
                    Rectangle {
                        width: 3; height: 14; radius: 2; color: _accent
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Text {
                        text: "TOOL CONTROL"; color: _accent
                        font.pixelSize: 9; font.weight: Font.Bold; font.letterSpacing: 1.2
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }

                Rectangle { width: parent.width; height: 1; color: Qt.rgba(1,1,1,0.06) }

                // Blade Speed
                Column {
                    width:   parent.width
                    spacing: 6

                    Row {
                        width: parent.width
                        Text {
                            text: "Blade Speed"
                            color: "#888888"; font.pixelSize: 11
                            width: parent.width * 0.6
                        }
                        Text {
                            anchors.right:  parent.right
                            text:           Math.round(bladeSlider.value) + " RPM"
                            color:          _accent; font.pixelSize: 11; font.weight: Font.Medium
                        }
                    }

                    Slider {
                        id:     bladeSlider
                        width:  parent.width
                        from:   0; to: 3000; value: 1500
                        height: 20

                        background: Rectangle {
                            x: bladeSlider.leftPadding
                            y: bladeSlider.topPadding + bladeSlider.availableHeight / 2 - height / 2
                            width: bladeSlider.availableWidth; height: 3; radius: 2
                            color: Qt.rgba(1,1,1,0.1)
                            Rectangle {
                                width: bladeSlider.visualPosition * parent.width
                                height: parent.height; radius: 2; color: _accent
                            }
                        }
                        handle: Rectangle {
                            x: bladeSlider.leftPadding + bladeSlider.visualPosition * (bladeSlider.availableWidth - width)
                            y: bladeSlider.topPadding + bladeSlider.availableHeight / 2 - height / 2
                            width: 14; height: 14; radius: 7
                            color: bladeSlider.pressed ? _accent : "#1a1a1a"
                            border.color: _accent; border.width: 2
                        }
                    }
                }

                Rectangle { width: parent.width; height: 1; color: Qt.rgba(1,1,1,0.06) }

                // Extraction Depth
                Column {
                    width:   parent.width
                    spacing: 6

                    Row {
                        width: parent.width
                        Text {
                            text: "Extraction Depth"
                            color: "#888888"; font.pixelSize: 11
                            width: parent.width * 0.6
                        }
                        Text {
                            anchors.right:  parent.right
                            text:           Math.round(depthSlider.value) + " mm"
                            color:          _accent; font.pixelSize: 11; font.weight: Font.Medium
                        }
                    }

                    Slider {
                        id:     depthSlider
                        width:  parent.width
                        from:   0; to: 200; value: 50
                        height: 20

                        background: Rectangle {
                            x: depthSlider.leftPadding
                            y: depthSlider.topPadding + depthSlider.availableHeight / 2 - height / 2
                            width: depthSlider.availableWidth; height: 3; radius: 2
                            color: Qt.rgba(1,1,1,0.1)
                            Rectangle {
                                width: depthSlider.visualPosition * parent.width
                                height: parent.height; radius: 2; color: _accent
                            }
                        }
                        handle: Rectangle {
                            x: depthSlider.leftPadding + depthSlider.visualPosition * (depthSlider.availableWidth - width)
                            y: depthSlider.topPadding + depthSlider.availableHeight / 2 - height / 2
                            width: 14; height: 14; radius: 7
                            color: depthSlider.pressed ? _accent : "#1a1a1a"
                            border.color: _accent; border.width: 2
                        }
                    }
                }
            }
        }
    }
}