import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs

import QGroundControl
import QGroundControl.Controls
import QGroundControl.FlyView
import QGroundControl.Comms 1.0

Item {
    required property var guidedValueSlider

    id:     control
    width:  parent.width
    height: ScreenTools.toolbarHeight

    property var    _activeVehicle:     QGroundControl.multiVehicleManager.activeVehicle
    property bool   _communicationLost: _activeVehicle ? _activeVehicle.vehicleLinkManager.communicationLost : false
    property color  _mainStatusBGColor: qgcPal.toolbarBlack
    property real   _leftRightMargin:   ScreenTools.defaultFontPixelWidth * 0.75
    property var    _guidedController:  globals.guidedControllerFlyView

    AutoConnector { id: autoConnector }

    function dropMainStatusIndicatorTool() {
        mainStatusIndicator.dropMainStatusIndicator();
    }

    QGCPalette { id: qgcPal }

    QGCFlickable {
        anchors.fill:       parent
        contentWidth:       toolBarLayout.width
        flickableDirection: Flickable.HorizontalFlick

        Row {
            id:         toolBarLayout
            height:     parent.height
            spacing:    0

            //Left Panel
            Item {
                id:     leftPanel
                width:  leftPanelLayout.implicitWidth
                height: parent.height

                // Gradient background behind Q button and main status indicator
                Rectangle {
                    id:         gradientBackground
                    height:     parent.height
                    width:      mainStatusLayout.width
                    opacity:    qgcPal.windowTransparent.a

                    gradient: Gradient {
                        orientation: Gradient.Horizontal
                        GradientStop { position: 0; color: _mainStatusBGColor }
                        //GradientStop { position: qgcButton.x + qgcButton.width; color: _mainStatusBGColor }
                        GradientStop { position: 1; color: qgcPal.window }
                    }
                }

                // Standard toolbar background to the right of the gradient
                Rectangle {
                    anchors.left:   gradientBackground.right
                    anchors.right:  parent.right
                    height:         parent.height
                    color:          qgcPal.windowTransparent
                }

                RowLayout {
                    id:         leftPanelLayout
                    height:     parent.height
                    spacing:    ScreenTools.defaultFontPixelWidth * 2

                    RowLayout {
                        id:         mainStatusLayout
                        height:     parent.height
                        spacing:    0

                        QGCToolBarButton {
                            id:                 qgcButton
                            Layout.fillHeight:  true
                            icon.source:        "qrc:/res/resources/NestLinkLogo.png"
                            logo:               true
                            onClicked:          mainWindow.showToolSelectDialog()
                        }

                        MainStatusIndicator {
                            id:                 mainStatusIndicator
                            Layout.fillHeight:  true
                        }
                    }

                    QGCButton {
                        id:         disconnectButton
                        text:       qsTr("Disconnect")
                        onClicked:  _activeVehicle.closeVehicle()
                        visible:    _activeVehicle && _communicationLost
                    }

                    FlightModeIndicator {
                        Layout.fillHeight:  true
                        visible:            _activeVehicle
                    }
                }
            }

            //Center panel
            Item {
                id:     centerPanel
                // center panel takes up all remaining space in toolbar between left and right panels
                width:  Math.max(guidedActionConfirm.visible ? guidedActionConfirm.width : 0, control.width - (leftPanel.width + rightPanel.width))
                height: parent.height

                Rectangle {
                    anchors.fill:   parent
                    color:          qgcPal.windowTransparent
                }

                GuidedActionConfirm {
                    id:                         guidedActionConfirm
                    height:                     parent.height
                    anchors.horizontalCenter:   parent.horizontalCenter
                    guidedController:           control._guidedController
                    guidedValueSlider:          control.guidedValueSlider
                    messageDisplay:             guidedActionMessageDisplay
                }
            }

            //Right Panel
            Item {
                id:     rightPanel
                width:  flyViewIndicators.width + ScreenTools.defaultFontPixelWidth * 14
                height: parent.height

                Rectangle {
                    anchors.fill:   parent
                    color:          qgcPal.windowTransparent
                }

                Row {
                    anchors.right:  parent.right
                    anchors.top:    parent.top
                    anchors.bottom: parent.bottom
                    spacing:        0

                    FlyViewToolBarIndicators {
                        id:     flyViewIndicators
                        height: parent.height
                    }
                    
                    //Thin divider
                    Rectangle {
                        width:              1
                        height:             parent.height * 0.6
                        color:              "white"
                        opacity:            0.2
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    //Connect/Disconnect Button
                    Item {
                        id:     connectBtn
                        width:  ScreenTools.defaultFontPixelWidth * 13
                        height: parent.height

                        Row {
                            anchors.centerIn: parent
                            spacing:          6

                            Rectangle {
                                width:                  7
                                height:                 7
                                radius:                 4
                                anchors.verticalCenter: parent.verticalCenter
                                color:                  _activeVehicle ? "#4caf50" : "#6495ED"

                                SequentialAnimation on opacity {
                                    running:  !_activeVehicle
                                    loops:    Animation.Infinite
                                    NumberAnimation { to: 0.2; duration: 800 }
                                    NumberAnimation { to: 1.0; duration: 800 }
                                }
                            }

                            Text {
                                anchors.verticalCenter: parent.verticalCenter
                                text:                   _activeVehicle ? qsTr("Disconnect") : qsTr("Connect")
                                color:                  _activeVehicle ? "#ff6b6b" : Qt.rgba(1, 1, 1, 0.85)
                                font.pixelSize:         ScreenTools.defaultFontPointSize * 1.4
                                font.weight:            Font.Medium

                                Rectangle {
                                    anchors.bottom: parent.bottom
                                    anchors.left:   parent.left
                                    anchors.right:  parent.right
                                    height:         1
                                    color:          _activeVehicle ? "#ff6b6b" : "#6495ED"
                                    visible:        connectMouse.containsMouse
                                }
                            }
                        }

                        MouseArea {
                            id:             connectMouse
                            anchors.fill:   parent
                            hoverEnabled:   true
                            cursorShape:    Qt.PointingHandCursor
                            onClicked: {
                                if (_activeVehicle) {
                                    _activeVehicle.closeVehicle()
                                } else {
                                    autoConnector.connectToSITL()
                                }
                            }
                        }
                    }

                    // Rectangle {
                    //     id:                 connectBtn
                    //     anchors.right:      parent.right
                    //     anchors.top:        parent.top
                    //     anchors.bottom:     parent.bottom
                    //     anchors.margins:    4
                    //     width:              ScreenTools.defaultFontPixelWidth * 10
                    //     color: "transparent"
                    //     // radius:             4
                    //     // color:              connectMouse.pressed ? Qt.rgba(1,1,1,0.15) :
                    //     //                     _activeVehicle       ? Qt.rgba(0.2,0.7,0.3,0.25) :
                    //     //                                         Qt.rgba(0.2,0.4,0.8,0.25)
                    //     // border.color:       _activeVehicle ? "#4caf50" : "#6495ED"
                    //     // border.width:       1

                    //     // Behavior on color { ColorAnimation { duration: 150 } }

                    //     Row {
                    //         anchors.centerIn: parent
                    //         spacing:          6

                    //         Rectangle {
                    //             width:                  8
                    //             height:                 8
                    //             radius:                 4
                    //             anchors.verticalCenter: parent.verticalCenter
                    //             color:                  _activeVehicle ? "#4caf50" : "#6495ED"

                    //             SequentialAnimation on opacity {
                    //                 running:  !_activeVehicle
                    //                 loops:    Animation.Infinite
                    //                 NumberAnimation { to: 0.2; duration: 800 }
                    //                 NumberAnimation { to: 1.0; duration: 800 }
                    //             }
                    //         }

                    //         Text {
                    //             anchors.verticalCenter: parent.verticalCenter
                    //             text:                   _activeVehicle ? qsTr("Connected") : qsTr("Connect")
                    //             color:                  "#ffffff" //_activeVehicle ? "#4caf50" : "#ffffff"
                    //             font.pixelSize:         ScreenTools.defaultFontPointSize * 1.55
                    //             font.weight:            Font.Medium

                    //             // Subtle underline on hover when disconnected
                    //             Rectangle {
                    //                 anchors.bottom:     parent.bottom
                    //                 anchors.left:       parent.left
                    //                 anchors.right:      parent.right
                    //                 height:             1
                    //                 color:              "#6495ED"
                    //                 visible:            connectMouse.containsMouse && !_activeVehicle
                    //             }
                    //         }
                    //     }

                    //     MouseArea {
                    //         id:          connectMouse
                    //         anchors.fill: parent
                    //         enabled:      !_activeVehicle
                    //         cursorShape:  _activeVehicle ? Qt.ArrowCursor : Qt.PointingHandCursor

                    //         onClicked: {
                    //             console.log("Connecting to SITL 127.0.0.1:5762...")
                    //             autoConnector.connectToSITL()
                    //         }
                    //     }
                    // }
                }
            }
        }
    }

    // The guided action message display is outside of the GuidedActionConfirm control so that it doesn't end up as
    // part of the Flickable
    Rectangle {
        id:                         guidedActionMessageDisplay
        anchors.top:                control.bottom
        anchors.topMargin:          _margins
        x:                          control.mapFromItem(guidedActionConfirm.parent, guidedActionConfirm.x, 0).x + (guidedActionConfirm.width - guidedActionMessageDisplay.width) / 2
        width:                      messageLabel.contentWidth + (_margins * 2)
        height:                     messageLabel.contentHeight + (_margins * 2)
        color:                      qgcPal.windowTransparent
        radius:                     ScreenTools.defaultBorderRadius
        visible:                    guidedActionConfirm.visible

        QGCLabel {
            id:         messageLabel
            x:          _margins
            y:          _margins
            width:      ScreenTools.defaultFontPixelWidth * 30
            wrapMode:   Text.WordWrap
            text:       guidedActionConfirm.message
        }

        PropertyAnimation {
            id:         messageOpacityAnimation
            target:     guidedActionMessageDisplay
            property:   "opacity"
            from:       1
            to:         0
            duration:   500
        }

        Timer {
            id:             messageFadeTimer
            interval:       4000
            onTriggered:    messageOpacityAnimation.start()
        }
    }

    ParameterDownloadProgress {
        anchors.fill: parent
    }
}
