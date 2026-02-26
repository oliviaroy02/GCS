// import QtQuick
// import QtQuick.Controls
// import QtQuick.Layouts

// import QGroundControl
// import QGroundControl.Controls

// ToolIndicatorPage {
//     id: root

//     property real _toolButtonHeight: ScreenTools.defaultFontPixelHeight * 3

//     contentComponent: Component {
//         GridLayout {
//             columns: 2
//             columnSpacing: ScreenTools.defaultFontPixelWidth
//             rowSpacing: columnSpacing

//             SubMenuButton {
//                 implicitHeight: root._toolButtonHeight
//                 Layout.fillWidth: true
//                 text: qsTr("Fly")
//                 imageResource: "/res/FlyingPaperPlane.svg"
//                 onClicked: {
//                     if (mainWindow.allowViewSwitch()) {
//                         mainWindow.closeIndicatorDrawer()
//                         mainWindow.showFlyView()
//                     }
//                 }
//             }

//             SubMenuButton {
//                 implicitHeight: root._toolButtonHeight
//                 Layout.fillWidth: true
//                 text: qsTr("Plan")
//                 imageResource: "/qmlimages/Plan.svg"
//                 onClicked: {
//                     if (mainWindow.allowViewSwitch()) {
//                         mainWindow.closeIndicatorDrawer()
//                         mainWindow.showPlanView()
//                     }
//                 }
//             }

//             SubMenuButton {
//                 implicitHeight: root._toolButtonHeight
//                 Layout.fillWidth: true
//                 text: qsTr("Analyze")
//                 imageResource: "/qmlimages/Analyze.svg"
//                 visible: QGroundControl.corePlugin.showAdvancedUI
//                 onClicked: {
//                     if (mainWindow.allowViewSwitch()) {
//                         mainWindow.closeIndicatorDrawer()
//                         mainWindow.showAnalyzeTool()
//                     }
//                 }
//             }

//             SubMenuButton {
//                 id: setupButton
//                 implicitHeight: root._toolButtonHeight
//                 Layout.fillWidth: true
//                 text: qsTr("Configure")
//                 imageResource: "/res/GearWithPaperPlane.svg"
//                 onClicked: {
//                     if (mainWindow.allowViewSwitch()) {
//                         mainWindow.closeIndicatorDrawer()
//                         mainWindow.showVehicleConfig()
//                     }
//                 }
//             }

//             SubMenuButton {
//                 id: settingsButton
//                 implicitHeight: root._toolButtonHeight
//                 Layout.fillWidth: true
//                 text: qsTr("Settings")
//                 imageResource: "/res/QGCLogoWhite.svg"
//                 visible: !QGroundControl.corePlugin.options.combineSettingsAndSetup
//                 onClicked: {
//                     if (mainWindow.allowViewSwitch()) {
//                         mainWindow.closeIndicatorDrawer()
//                         mainWindow.showSettingsTool()
//                     }
//                 }
//             }

//             SubMenuButton {
//                 id: closeButton
//                 implicitHeight: root._toolButtonHeight
//                 Layout.fillWidth: true
//                 text: qsTr("Close")
//                 imageResource: "/res/OpenDoor.svg"
//                 onClicked: {
//                     if (mainWindow.allowViewSwitch()) {
//                         mainWindow.finishCloseProcess()
//                     }
//                 }
//             }

//             ColumnLayout {
//                 id: versionColumnLayout
//                 Layout.fillWidth: true
//                 Layout.columnSpan: 2
//                 spacing: 0

//                 QGCLabel {
//                     id: versionLabel
//                     Layout.fillWidth: true
//                     horizontalAlignment: Text.AlignHCenter
//                     text: qsTr("%1 Version").arg(QGroundControl.appName)
//                     font.pointSize: ScreenTools.smallFontPointSize
//                     wrapMode: QGCLabel.WordWrap
//                 }

//                 QGCLabel {
//                     Layout.fillWidth: true
//                     horizontalAlignment: Text.AlignHCenter
//                     text: QGroundControl.qgcVersion
//                     font.pointSize: ScreenTools.smallFontPointSize
//                     wrapMode: QGCLabel.WrapAnywhere
//                 }

//                 QGCLabel {
//                     Layout.fillWidth: true
//                     horizontalAlignment: Text.AlignHCenter
//                     text: QGroundControl.qgcAppDate
//                     font.pointSize: ScreenTools.smallFontPointSize
//                     wrapMode: QGCLabel.WrapAnywhere
//                     visible: QGroundControl.qgcDailyBuild

//                     QGCMouseArea {
//                         anchors.topMargin: -(parent.y - versionLabel.y)
//                         anchors.fill: parent

//                         onClicked: (mouse) => {
//                             if (mouse.modifiers & Qt.ControlModifier) {
//                                 QGroundControl.corePlugin.showTouchAreas = !QGroundControl.corePlugin.showTouchAreas
//                                 showTouchAreasNotification.open()
//                             } else if (ScreenTools.isMobile || mouse.modifiers & Qt.ShiftModifier) {
//                                 mainWindow.closeIndicatorDrawer()
//                                 if (!QGroundControl.corePlugin.showAdvancedUI) {
//                                     advancedModeOnConfirmation.open()
//                                 } else {
//                                     advancedModeOffConfirmation.open()
//                                 }
//                             }
//                         }

//                         // This allows you to change this on mobile
//                         onPressAndHold: {
//                             QGroundControl.corePlugin.showTouchAreas = !QGroundControl.corePlugin.showTouchAreas
//                             showTouchAreasNotification.open()
//                         }
//                     }
//                 }
//             }
//         }
//     }
// }

//===============================================================================
//===============================================================================
//===============================================================================

// import QtQuick
// import QtQuick.Controls
// import QtQuick.Layouts

// import QGroundControl
// import QGroundControl.Controls

// ToolIndicatorPage {
//     id: root

//     showExpand: false

//     contentComponent: Component {
//         Rectangle {
//             width:  280
//             height: menuColumn.height + footer.height
//             color:  "#2b2b2b"
//             radius: 8

//             Column {
//                 id:             menuColumn
//                 anchors.left:   parent.left
//                 anchors.right:  parent.right
//                 anchors.top:    parent.top
//                 spacing:        0

//                 // Configuration Button
//                 MenuButton {
//                     text:       qsTr("Configure")
//                     iconSource: "/res/GearWithPaperPlane.svg"
//                     onClicked: {
//                         if (mainWindow.allowViewSwitch()) {
//                             mainWindow.closeIndicatorDrawer()
//                             mainWindow.showVehicleConfig()
//                         }
//                     }
//                 }

//                 // Flight Button
//                 MenuButton {
//                     text:       qsTr("Flight")
//                     iconSource: "/res/FlyingPaperPlane.svg"
//                     onClicked: {
//                         if (mainWindow.allowViewSwitch()) {
//                             mainWindow.closeIndicatorDrawer()
//                             mainWindow.showFlyView()
//                         }
//                     }
//                 }

//                 // Planning Button
//                 MenuButton {
//                     text:       qsTr("Planning")
//                     iconSource: "/qmlimages/Plan.svg"
//                     onClicked: {
//                         if (mainWindow.allowViewSwitch()) {
//                             mainWindow.closeIndicatorDrawer()
//                             mainWindow.showPlanView()
//                         }
//                     }
//                 }

//                 // Analyze Button
//                 MenuButton {
//                     text:       qsTr("Analyze")
//                     iconSource: "/qmlimages/Analyze.svg"
//                     showChevron: true
//                     visible:    QGroundControl.corePlugin.showAdvancedUI
//                     onClicked: {
//                         if (mainWindow.allowViewSwitch()) {
//                             mainWindow.closeIndicatorDrawer()
//                             mainWindow.showAnalyzeTool()
//                         }
//                     }
//                 }

//                 // Settings Button
//                 MenuButton {
//                     text:       qsTr("Settings")
//                     iconSource: "/res/QGCLogoWhite.svg"
//                     showChevron: true
//                     visible:    !QGroundControl.corePlugin.options.combineSettingsAndSetup
//                     onClicked: {
//                         if (mainWindow.allowViewSwitch()) {
//                             mainWindow.closeIndicatorDrawer()
//                             mainWindow.showSettingsTool()
//                         }
//                     }
//                 }

//                 // QR Code Button
//                 MenuButton {
//                     text:       qsTr("QR code")
//                     iconSource: "/qmlimages/QRCode.svg"
//                     onClicked: {
//                         mainWindow.closeIndicatorDrawer()
//                         // Add QR code functionality
//                     }
//                 }
//             }

//             // Footer with Powered By
//             Rectangle {
//                 id:             footer
//                 anchors.bottom: parent.bottom
//                 anchors.left:   parent.left
//                 anchors.right:  parent.right
//                 height:         70
//                 color:          Qt.rgba(0, 0, 0, 0.3)
//                 radius:         8

//                 Column {
//                     anchors.centerIn: parent
//                     spacing: 4

//                     QGCLabel {
//                         anchors.horizontalCenter: parent.horizontalCenter
//                         text:           "------ Powered By ------"
//                         font.pixelSize: 9
//                         color:          Qt.rgba(1, 1, 1, 0.4)
//                     }

//                     QGCLabel {
//                         anchors.horizontalCenter: parent.horizontalCenter
//                         text:           "Nesta Aerospace"
//                         font.pixelSize: 14
//                         font.weight:    Font.Bold
//                         color:          "#00d4ff"
//                     }
//                 }
//             }
//         }
//     }
// }

// // ============================================================================
// // Menu Button Component
// // ============================================================================
// component MenuButton: Rectangle {
//     id:         button
//     width:      parent.width
//     height:     52
//     color:      mouseArea.pressed ? Qt.rgba(1, 1, 1, 0.15) : 
//                 mouseArea.containsMouse ? Qt.rgba(1, 1, 1, 0.08) : "transparent"

//     property string text:        ""
//     property string iconSource:  ""
//     property bool   showChevron: false
//     signal clicked()

//     // Blue accent bar on hover
//     Rectangle {
//         anchors.left:   parent.left
//         anchors.top:    parent.top
//         anchors.bottom: parent.bottom
//         width:          3
//         color:          "#00d4ff"
//         visible:        mouseArea.containsMouse || mouseArea.pressed
        
//         Behavior on opacity { NumberAnimation { duration: 150 } }
//     }

//     Row {
//         anchors.left:           parent.left
//         anchors.leftMargin:     24
//         anchors.verticalCenter: parent.verticalCenter
//         spacing:                16

//         // Icon
//         QGCColoredImage {
//             width:                  24
//             height:                 24
//             anchors.verticalCenter: parent.verticalCenter
//             source:                 button.iconSource
//             color:                  "#e0e0e0"
//             fillMode:               Image.PreserveAspectFit
//             sourceSize.width:       width
//             sourceSize.height:      height
//         }

//         // Text Label
//         QGCLabel {
//             anchors.verticalCenter: parent.verticalCenter
//             text:                   button.text
//             font.pixelSize:         15
//             color:                  "#e0e0e0"
//         }
//     }

//     // Chevron (for Settings/Analyze)
//     QGCColoredImage {
//         visible:                button.showChevron
//         anchors.right:          parent.right
//         anchors.rightMargin:    24
//         anchors.verticalCenter: parent.verticalCenter
//         width:                  14
//         height:                 14
//         source:                 "/qmlimages/arrow-right.svg"
//         color:                  Qt.rgba(1, 1, 1, 0.5)
//         fillMode:               Image.PreserveAspectFit
//     }

//     MouseArea {
//         id:             mouseArea
//         anchors.fill:   parent
//         hoverEnabled:   true
//         cursorShape:    Qt.PointingHandCursor
//         onClicked:      button.clicked()
//     }

//     // Separator line between buttons
//     Rectangle {
//         anchors.bottom: parent.bottom
//         anchors.left:   parent.left
//         anchors.right:  parent.right
//         anchors.leftMargin:  24
//         anchors.rightMargin: 24
//         height:         1
//         color:          Qt.rgba(1, 1, 1, 0.1)
//     }
// }


import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import QGroundControl
import QGroundControl.Controls

ToolIndicatorPage {
    id: root

    showExpand: false

    // contentComponent: Component {
    //     Rectangle {
    //         width:  280
    //         height: Math.max(600, menuColumn.height + footer.height + 20) //420
    //         color:  "#2b2b2b"
    //         radius: 8

    //         Column {
    //             id:             menuColumn
    //             anchors.left:   parent.left
    //             anchors.right:  parent.right
    //             anchors.top:    parent.top
    //             spacing:        0

    //             // Configuration
    //             Rectangle {
    //                 width:  parent.width
    //                 height: 52
    //                 color:  configMouse.pressed ? Qt.rgba(1, 1, 1, 0.15) : 
    //                         configMouse.containsMouse ? Qt.rgba(1, 1, 1, 0.08) : "transparent"

    //                 Rectangle {
    //                     anchors.left: parent.left; anchors.top: parent.top; anchors.bottom: parent.bottom
    //                     width: 3; color: "#00d4ff"
    //                     visible: configMouse.containsMouse || configMouse.pressed
    //                 }

    //                 Row {
    //                     anchors.left: parent.left; anchors.leftMargin: 24
    //                     anchors.verticalCenter: parent.verticalCenter; spacing: 16

    //                     QGCColoredImage {
    //                         width: 24; height: 24; anchors.verticalCenter: parent.verticalCenter
    //                         source: "/qmlimages/Gears.svg"; color: "#e0e0e0"; fillMode: Image.PreserveAspectFit
    //                     }
    //                     QGCLabel { anchors.verticalCenter: parent.verticalCenter; text: qsTr("Configuration"); font.pixelSize: 15; color: "#e0e0e0" }
    //                 }

    //                 MouseArea {
    //                     id: configMouse; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor
    //                     onClicked: { if (mainWindow.allowViewSwitch()) { mainWindow.closeIndicatorDrawer(); mainWindow.showVehicleConfig() } }
    //                 }

    //                 Rectangle { anchors.bottom: parent.bottom; anchors.left: parent.left; anchors.right: parent.right
    //                     anchors.leftMargin: 24; anchors.rightMargin: 24; height: 1; color: Qt.rgba(1, 1, 1, 0.1) }
    //             }

    //             // Flight
    //             Rectangle {
    //                 width: parent.width; height: 52
    //                 color: flightMouse.pressed ? Qt.rgba(1, 1, 1, 0.15) : flightMouse.containsMouse ? Qt.rgba(1, 1, 1, 0.08) : "transparent"

    //                 Rectangle { anchors.left: parent.left; anchors.top: parent.top; anchors.bottom: parent.bottom
    //                     width: 3; color: "#00d4ff"; visible: flightMouse.containsMouse || flightMouse.pressed }

    //                 Row {
    //                     anchors.left: parent.left; anchors.leftMargin: 24; anchors.verticalCenter: parent.verticalCenter; spacing: 16
    //                     QGCColoredImage { width: 24; height: 24; anchors.verticalCenter: parent.verticalCenter
    //                         source: "/qmlimages/PaperPlane.svg"; color: "#e0e0e0"; fillMode: Image.PreserveAspectFit }
    //                     QGCLabel { anchors.verticalCenter: parent.verticalCenter; text: qsTr("Flight"); font.pixelSize: 15; color: "#e0e0e0" }
    //                 }

    //                 MouseArea { id: flightMouse; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor
    //                     onClicked: { if (mainWindow.allowViewSwitch()) { mainWindow.closeIndicatorDrawer(); mainWindow.showFlyView() } } }

    //                 Rectangle { anchors.bottom: parent.bottom; anchors.left: parent.left; anchors.right: parent.right
    //                     anchors.leftMargin: 24; anchors.rightMargin: 24; height: 1; color: Qt.rgba(1, 1, 1, 0.1) }
    //             }

    //             // Planning
    //             Rectangle {
    //                 width: parent.width; height: 52
    //                 color: planMouse.pressed ? Qt.rgba(1, 1, 1, 0.15) : planMouse.containsMouse ? Qt.rgba(1, 1, 1, 0.08) : "transparent"

    //                 Rectangle { anchors.left: parent.left; anchors.top: parent.top; anchors.bottom: parent.bottom
    //                     width: 3; color: "#00d4ff"; visible: planMouse.containsMouse || planMouse.pressed }

    //                 Row {
    //                     anchors.left: parent.left; anchors.leftMargin: 24; anchors.verticalCenter: parent.verticalCenter; spacing: 16
    //                     QGCColoredImage { width: 24; height: 24; anchors.verticalCenter: parent.verticalCenter
    //                         source: "/qmlimages/Plan.svg"; color: "#e0e0e0"; fillMode: Image.PreserveAspectFit }
    //                     QGCLabel { anchors.verticalCenter: parent.verticalCenter; text: qsTr("Planning"); font.pixelSize: 15; color: "#e0e0e0" }
    //                 }

    //                 MouseArea { id: planMouse; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor
    //                     onClicked: { if (mainWindow.allowViewSwitch()) { mainWindow.closeIndicatorDrawer(); mainWindow.showPlanView() } } }

    //                 Rectangle { anchors.bottom: parent.bottom; anchors.left: parent.left; anchors.right: parent.right
    //                     anchors.leftMargin: 24; anchors.rightMargin: 24; height: 1; color: Qt.rgba(1, 1, 1, 0.1) }
    //             }

    //             // Analyze
    //             Rectangle {
    //                 width: parent.width; 
    //                 height: 52; 
    //                 visible: QGroundControl.corePlugin.showAdvancedUI
    //                 color: analyzeMouse.pressed ? Qt.rgba(1, 1, 1, 0.15) : analyzeMouse.containsMouse ? Qt.rgba(1, 1, 1, 0.08) : "transparent"

    //                 Rectangle { 
    //                     anchors.left: parent.left; 
    //                     anchors.top: parent.top; 
    //                     anchors.bottom: parent.bottom
    //                     width: 3; 
    //                     color: "#00d4ff"; 
    //                     visible: analyzeMouse.containsMouse || analyzeMouse.pressed 
    //                 }

    //                 Row {
    //                     anchors.left: parent.left; 
    //                     anchors.leftMargin: 24; 
    //                     anchors.verticalCenter: parent.verticalCenter; 
    //                     spacing: 16
    //                     QGCColoredImage { 
    //                         width: 24; 
    //                         height: 24; 
    //                         anchors.verticalCenter: parent.verticalCenter
    //                         source: "/qmlimages/Analyze.svg"; 
    //                         color: "#e0e0e0"; 
    //                         fillMode: Image.PreserveAspectFit 
    //                     }
    //                     QGCLabel { 
    //                         anchors.verticalCenter: parent.verticalCenter; 
    //                         text: qsTr("Analyze"); 
    //                         font.pixelSize: 15; 
    //                         color: "#e0e0e0" 
    //                     }
    //                 }

    //                 Text { anchors.right: parent.right; anchors.rightMargin: 24; anchors.verticalCenter: parent.verticalCenter
    //                     text: "›"; font.pixelSize: 20; color: Qt.rgba(1, 1, 1, 0.5) }

    //                 MouseArea { id: analyzeMouse; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor
    //                     onClicked: { if (mainWindow.allowViewSwitch()) { mainWindow.closeIndicatorDrawer(); mainWindow.showAnalyzeTool() } } }

    //                 Rectangle { anchors.bottom: parent.bottom; anchors.left: parent.left; anchors.right: parent.right
    //                     anchors.leftMargin: 24; anchors.rightMargin: 24; height: 1; color: Qt.rgba(1, 1, 1, 0.1) }
    //             }

    //             // Settings
    //             Rectangle {
    //                 width: parent.width; 
    //                 height: 52; 
    //                 visible: !QGroundControl.corePlugin.options.combineSettingsAndSetup
    //                 color: settingsMouse.pressed ? Qt.rgba(1, 1, 1, 0.15) : settingsMouse.containsMouse ? Qt.rgba(1, 1, 1, 0.08) : "transparent"

    //                 Rectangle { 
    //                     anchors.left: parent.left; 
    //                     anchors.top: parent.top; 
    //                     anchors.bottom: parent.bottom
    //                     width: 3; 
    //                     color: "#00d4ff"; 
    //                     visible: settingsMouse.containsMouse || settingsMouse.pressed 
    //                 }

    //                 Row {
    //                     anchors.left: parent.left; 
    //                     anchors.leftMargin: 24; 
    //                     anchors.verticalCenter: parent.verticalCenter; 
    //                     spacing: 16
    //                     QGCColoredImage { 
    //                         width: 24; 
    //                         height: 24; 
    //                         anchors.verticalCenter: parent.verticalCenter
    //                         source: "/res/QGCLogoWhite.svg"; 
    //                         color: "#e0e0e0"; 
    //                         fillMode: Image.PreserveAspectFit 
    //                     }
    //                     QGCLabel { 
    //                         anchors.verticalCenter: parent.verticalCenter; 
    //                         text: qsTr("Settings"); 
    //                         font.pixelSize: 15; 
    //                         color: "#e0e0e0" 
    //                     }
    //                 }

    //                 Text { 
    //                     anchors.right: parent.right; 
    //                     anchors.rightMargin: 24; 
    //                     anchors.verticalCenter: parent.verticalCenter
    //                     text: "›"; 
    //                     font.pixelSize: 20; 
    //                     color: Qt.rgba(1, 1, 1, 0.5) 
    //                 }

    //                 MouseArea { 
    //                     id: settingsMouse; 
    //                     anchors.fill: parent; 
    //                     hoverEnabled: true; 
    //                     cursorShape: Qt.PointingHandCursor
    //                     onClicked: { 
    //                         if (mainWindow.allowViewSwitch()) { 
    //                             mainWindow.closeIndicatorDrawer(); 
    //                             mainWindow.showSettingsTool() 
    //                         } 
    //                     } 
    //                 }

    //                 Rectangle { 
    //                     anchors.bottom: parent.bottom; 
    //                     anchors.left: parent.left; 
    //                     anchors.right: parent.right
    //                     anchors.leftMargin: 24; 
    //                     anchors.rightMargin: 24; 
    //                     height: 1; 
    //                     color: Qt.rgba(1, 1, 1, 0.1) 
    //                 }
    //             }

    //             // QR Code
    //             Rectangle {
    //                 width: parent.width; 
    //                 height: 52
    //                 color: qrMouse.pressed ? Qt.rgba(1, 1, 1, 0.15) : qrMouse.containsMouse ? Qt.rgba(1, 1, 1, 0.08) : "transparent"

    //                 Rectangle { 
    //                     anchors.left: parent.left; 
    //                     anchors.top: parent.top; 
    //                     anchors.bottom: parent.bottom
    //                     width: 3;
    //                     color: "#00d4ff"; 
    //                     visible: qrMouse.containsMouse || qrMouse.pressed 
    //                 }

    //                 Row {
    //                     anchors.left: parent.left; 
    //                     anchors.leftMargin: 24; 
    //                     anchors.verticalCenter: parent.verticalCenter; 
    //                     spacing: 16
    //                     QGCColoredImage { 
    //                         width: 24; 
    //                         height: 24; 
    //                         anchors.verticalCenter: parent.verticalCenter
    //                         source: "/qmlimages/QRCode.svg"; 
    //                         color: "#e0e0e0"; 
    //                         fillMode: Image.PreserveAspectFit 
    //                     }
    //                     QGCLabel { 
    //                         anchors.verticalCenter: parent.verticalCenter; 
    //                         text: qsTr("QR code"); 
    //                         font.pixelSize: 15; 
    //                         color: "#e0e0e0" 
    //                     }
    //                 }

    //                 MouseArea { 
    //                     id: qrMouse; 
    //                     anchors.fill: parent; 
    //                     hoverEnabled: true; 
    //                     cursorShape: Qt.PointingHandCursor
    //                     onClicked: mainWindow.closeIndicatorDrawer() 
    //                 }
    //             }
    //         }

    //         // Footer
    //         Rectangle {
    //             anchors.bottom: parent.bottom; 
    //             anchors.left: parent.left; 
    //             anchors.right: parent.right
    //             height: 70; 
    //             color: Qt.rgba(0, 0, 0, 0.3); 
    //             // radius: 8

    //             Column {
    //                 anchors.centerIn: parent; 
    //                 spacing: 4
    //                 QGCLabel { 
    //                     anchors.horizontalCenter: parent.horizontalCenter; 
    //                     text: "------ Powered By ------"; 
    //                     font.pixelSize: 9; 
    //                     color: Qt.rgba(1, 1, 1, 0.4) 
    //                 }
    //                 QGCLabel { 
    //                     anchors.horizontalCenter: parent.horizontalCenter; 
    //                     text: "Nesta Aerospace"; 
    //                     font.pixelSize: 14; 
    //                     font.weight: Font.Bold; 
    //                     color: "#00d4ff" 
    //                 }
    //             }
    //         }
    //     }
    // }

    contentComponent: Component {
    Item {
        implicitWidth:  240
        implicitHeight: Math.max(600, menuColumn.height + footer.height + 20)
        // implicitHeight: Math.max(2500, menuColumn.height + footer.height + 100) //600  // Set minimum height
        // width: 280
        // height: parent.height
        // anchors.top: parent.top
        // anchors.bottom: parent.bottom

        Rectangle {
            anchors.fill:   parent
            color:          Qt.rgba(0, 0, 0, 0.4)
            radius:         8

            Column {
                id:             menuColumn
                anchors.left:   parent.left
                anchors.right:  parent.right
                anchors.top:    parent.top
                spacing:        0

                //----------------> Logo Section
                Rectangle {
                    id:     logoContainer
                    width:  parent.width
                    height: 120
                    color:  Qt.rgba(0, 0, 0, 0.4)

                    Column {
                        anchors.centerIn: parent
                        spacing: 8

                        // Logo Image
                        Image {
                            anchors.horizontalCenter: parent.horizontalCenter
                            source:   "qrc:/res/logo_kamdar.svg"//"qrc:/res/resources/NestLinkLogo.png"
                            width:  80
                            height: 80
                            fillMode: Image.PreserveAspectFit
                            
                            // If logo doesn't exist, show placeholder
                            onStatusChanged: {
                                if (status === Image.Error) {
                                    // Show placeholder circle instead
                                    visible = false
                                }
                            }
                        }

                        // App Name
                        QGCLabel {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: "NestLink"
                            font.pixelSize: 16
                            font.weight: Font.Bold
                            color: "#00d4ff"
                        }

                        // // Version or Tagline (optional)
                        // QGCLabel {
                        //     anchors.horizontalCenter: parent.horizontalCenter
                        //     text: "v1.0.0"
                        //     font.pixelSize: 10
                        //     color: Qt.rgba(1, 1, 1, 0.5)
                        // }
                    }

                    // Bottom border
                    Rectangle {
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        anchors.right: parent.right
                        height: 1
                        color: Qt.rgba(1, 1, 1, 0.1)
                    }
                }

                // ----------------> Configuration
                // Rectangle {
                //     width:  parent.width
                //     height: 52
                //     color:  configMouse.pressed ? Qt.rgba(1, 1, 1, 0.15) : 
                //             configMouse.containsMouse ? Qt.rgba(1, 1, 1, 0.08) : "transparent"

                //     Rectangle {
                //         anchors.left: parent.left; anchors.top: parent.top; anchors.bottom: parent.bottom
                //         width: 3; color: "#00d4ff"
                //         visible: configMouse.containsMouse || configMouse.pressed
                //     }

                //     Row {
                //         anchors.left: parent.left; anchors.leftMargin: 24
                //         anchors.verticalCenter: parent.verticalCenter; spacing: 16

                //         QGCColoredImage {
                //             width: 24; height: 24; anchors.verticalCenter: parent.verticalCenter
                //             source: "/qmlimages/Gears.svg"; color: "#e0e0e0"; fillMode: Image.PreserveAspectFit
                //         }
                //         QGCLabel { anchors.verticalCenter: parent.verticalCenter; text: qsTr("Configuration"); font.pixelSize: 15; color: "#e0e0e0" }
                //     }

                //     MouseArea {
                //         id: configMouse; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor
                //         onClicked: { if (mainWindow.allowViewSwitch()) { mainWindow.closeIndicatorDrawer(); mainWindow.showVehicleConfig() } }
                //     }

                //     Rectangle { anchors.bottom: parent.bottom; anchors.left: parent.left; anchors.right: parent.right
                //         anchors.leftMargin: 24; anchors.rightMargin: 24; height: 1; color: Qt.rgba(1, 1, 1, 0.1) }
                // }

                // ----------------> Flight
                Rectangle {
                    width: parent.width; 
                    height: 52
                    color: flightMouse.pressed ? Qt.rgba(1, 1, 1, 0.15) : flightMouse.containsMouse ? Qt.rgba(1, 1, 1, 0.08) : "transparent"

                    Rectangle { 
                        anchors.left: parent.left; 
                        anchors.top: parent.top; 
                        anchors.bottom: parent.bottom
                        width: 3; 
                        color: "#00d4ff"; 
                        visible: flightMouse.containsMouse || flightMouse.pressed 
                    }

                    Row {
                        anchors.left: parent.left; 
                        anchors.leftMargin: 24; 
                        anchors.verticalCenter: parent.verticalCenter; 
                        spacing: 16
                        QGCColoredImage { 
                            width: 24; 
                            height: 24; 
                            anchors.verticalCenter: parent.verticalCenter
                            source: "/qmlimages/PaperPlane.svg"; 
                            color: "#e0e0e0"; fillMode: Image.PreserveAspectFit 
                        }
                        QGCLabel { 
                            anchors.verticalCenter: parent.verticalCenter; 
                            text: qsTr("Flight"); 
                            font.pixelSize: 15; 
                            color: "#e0e0e0" 
                        }
                    }

                    MouseArea { 
                        id: flightMouse; 
                        anchors.fill: parent; 
                        hoverEnabled: true; 
                        cursorShape: Qt.PointingHandCursor
                        onClicked: { 
                            if (mainWindow.allowViewSwitch()) { 
                                mainWindow.closeIndicatorDrawer(); 
                                mainWindow.showFlyView() 
                                } 
                            } 
                        }

                    Rectangle { 
                        anchors.bottom: parent.bottom; 
                        anchors.left: parent.left; 
                        anchors.right: parent.right
                        anchors.leftMargin: 24; 
                        anchors.rightMargin: 24; 
                        height: 1; 
                        color: Qt.rgba(1, 1, 1, 0.1) 
                    }
                }

                // ----------------> AGV
                Rectangle {
                    width: parent.width; 
                    height: 52
                    color: agvMouse.pressed ? Qt.rgba(1, 1, 1, 0.15) : agvMouse.containsMouse ? Qt.rgba(1, 1, 1, 0.08) : "transparent"

                    Rectangle { 
                        anchors.left: parent.left; 
                        anchors.top: parent.top; 
                        anchors.bottom: parent.bottom
                        width: 3; 
                        color: "#00d4ff"; 
                        visible: agvMouse.containsMouse || agvMouse.pressed 
                    }

                    Row {
                        anchors.left: parent.left; 
                        anchors.leftMargin: 24; 
                        anchors.verticalCenter: parent.verticalCenter; 
                        spacing: 16
                        QGCColoredImage { 
                            width: 24; 
                            height: 24; 
                            anchors.verticalCenter: parent.verticalCenter
                            source: "qrc:/res/rover.png"; 
                            color: "#e0e0e0"; 
                            fillMode: Image.PreserveAspectFit 
                        }
                        QGCLabel { 
                            anchors.verticalCenter: parent.verticalCenter; 
                            text: qsTr("AGV"); 
                            font.pixelSize: 15; 
                            color: "#e0e0e0" 
                        }
                    }

                    MouseArea {
                        id: agvMouse;
                        anchors.fill: parent;
                        hoverEnabled: true; 
                        cursorShape: Qt.PointingHandCursor
                        onClicked: { 
                            if (mainWindow.allowViewSwitch()) { 
                                mainWindow.closeIndicatorDrawer(); 
                                mainWindow.showAGVView()
                            } 
                        } 
                    }

                    Rectangle { 
                        anchors.bottom: parent.bottom; 
                        anchors.left: parent.left; 
                        anchors.right: parent.right
                        anchors.leftMargin: 24; 
                        anchors.rightMargin: 24; 
                        height: 1; 
                        color: Qt.rgba(1, 1, 1, 0.1) 
                    }
                }

                // ----------------> Planning
                // Rectangle {
                //     width: parent.width; height: 52
                //     color: planMouse.pressed ? Qt.rgba(1, 1, 1, 0.15) : planMouse.containsMouse ? Qt.rgba(1, 1, 1, 0.08) : "transparent"

                //     Rectangle { anchors.left: parent.left; anchors.top: parent.top; anchors.bottom: parent.bottom
                //         width: 3; color: "#00d4ff"; visible: planMouse.containsMouse || planMouse.pressed }

                //     Row {
                //         anchors.left: parent.left; anchors.leftMargin: 24; anchors.verticalCenter: parent.verticalCenter; spacing: 16
                //         QGCColoredImage { width: 24; height: 24; anchors.verticalCenter: parent.verticalCenter
                //             source: "/qmlimages/Plan.svg"; color: "#e0e0e0"; fillMode: Image.PreserveAspectFit }
                //         QGCLabel { anchors.verticalCenter: parent.verticalCenter; text: qsTr("Planning"); font.pixelSize: 15; color: "#e0e0e0" }
                //     }

                //     MouseArea { id: planMouse; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor
                //         onClicked: { if (mainWindow.allowViewSwitch()) { mainWindow.closeIndicatorDrawer(); mainWindow.showPlanView() } } }

                //     Rectangle { anchors.bottom: parent.bottom; anchors.left: parent.left; anchors.right: parent.right
                //         anchors.leftMargin: 24; anchors.rightMargin: 24; height: 1; color: Qt.rgba(1, 1, 1, 0.1) }
                // }

                // ----------------> Analyze
                // Rectangle {
                //     width: parent.width; height: 52; visible: QGroundControl.corePlugin.showAdvancedUI
                //     color: analyzeMouse.pressed ? Qt.rgba(1, 1, 1, 0.15) : analyzeMouse.containsMouse ? Qt.rgba(1, 1, 1, 0.08) : "transparent"

                //     Rectangle { anchors.left: parent.left; anchors.top: parent.top; anchors.bottom: parent.bottom
                //         width: 3; color: "#00d4ff"; visible: analyzeMouse.containsMouse || analyzeMouse.pressed }

                //     Row {
                //         anchors.left: parent.left; anchors.leftMargin: 24; anchors.verticalCenter: parent.verticalCenter; spacing: 16
                //         QGCColoredImage { width: 24; height: 24; anchors.verticalCenter: parent.verticalCenter
                //             source: "/qmlimages/Analyze.svg"; color: "#e0e0e0"; fillMode: Image.PreserveAspectFit }
                //         QGCLabel { anchors.verticalCenter: parent.verticalCenter; text: qsTr("Analyze"); font.pixelSize: 15; color: "#e0e0e0" }
                //     }

                //     Text { anchors.right: parent.right; anchors.rightMargin: 24; anchors.verticalCenter: parent.verticalCenter
                //         text: "›"; font.pixelSize: 20; color: Qt.rgba(1, 1, 1, 0.5) }

                //     MouseArea { 
                //         id: analyzeMouse; 
                //         anchors.fill: parent; 
                //         hoverEnabled: true; 
                //         cursorShape: Qt.PointingHandCursor
                //         onClicked: { 
                //             if (mainWindow.allowViewSwitch()) { 
                //                 mainWindow.closeIndicatorDrawer(); 
                //                 mainWindow.showAnalyzeTool() 
                //             } 
                //         } 
                //     }

                //     Rectangle { anchors.bottom: parent.bottom; anchors.left: parent.left; anchors.right: parent.right
                //         anchors.leftMargin: 24; anchors.rightMargin: 24; height: 1; color: Qt.rgba(1, 1, 1, 0.1) }
                // }

                // ----------------> Settings
                Rectangle {
                    width: parent.width; height: 52; visible: !QGroundControl.corePlugin.options.combineSettingsAndSetup
                    color: settingsMouse.pressed ? Qt.rgba(1, 1, 1, 0.15) : settingsMouse.containsMouse ? Qt.rgba(1, 1, 1, 0.08) : "transparent"

                    Rectangle { anchors.left: parent.left; anchors.top: parent.top; anchors.bottom: parent.bottom
                        width: 3; color: "#00d4ff"; visible: settingsMouse.containsMouse || settingsMouse.pressed }

                    Row {
                        anchors.left: parent.left; anchors.leftMargin: 24; anchors.verticalCenter: parent.verticalCenter; spacing: 16
                        QGCColoredImage { width: 24; height: 24; anchors.verticalCenter: parent.verticalCenter
                            source: "/res/QGCLogoWhite.svg"; color: "#e0e0e0"; fillMode: Image.PreserveAspectFit }
                        QGCLabel { anchors.verticalCenter: parent.verticalCenter; text: qsTr("Settings"); font.pixelSize: 15; color: "#e0e0e0" }
                    }

                    Text { anchors.right: parent.right; anchors.rightMargin: 24; anchors.verticalCenter: parent.verticalCenter
                        text: "›"; font.pixelSize: 20; color: Qt.rgba(1, 1, 1, 0.5) }

                    MouseArea { id: settingsMouse; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor
                        onClicked: { if (mainWindow.allowViewSwitch()) { mainWindow.closeIndicatorDrawer(); mainWindow.showSettingsTool() } } }

                    Rectangle { anchors.bottom: parent.bottom; anchors.left: parent.left; anchors.right: parent.right
                        anchors.leftMargin: 24; anchors.rightMargin: 24; height: 1; color: Qt.rgba(1, 1, 1, 0.1) }
                }

                // ----------------> QR Code
                // Rectangle {
                //     width: parent.width; height: 52
                //     color: qrMouse.pressed ? Qt.rgba(1, 1, 1, 0.15) : qrMouse.containsMouse ? Qt.rgba(1, 1, 1, 0.08) : "transparent"

                //     Rectangle { anchors.left: parent.left; anchors.top: parent.top; anchors.bottom: parent.bottom
                //         width: 3; color: "#00d4ff"; visible: qrMouse.containsMouse || qrMouse.pressed }

                //     Row {
                //         anchors.left: parent.left; anchors.leftMargin: 24; anchors.verticalCenter: parent.verticalCenter; spacing: 16
                //         QGCColoredImage { width: 24; height: 24; anchors.verticalCenter: parent.verticalCenter
                //             source: "/qmlimages/QRCode.svg"; color: "#e0e0e0"; fillMode: Image.PreserveAspectFit }
                //         QGCLabel { anchors.verticalCenter: parent.verticalCenter; text: qsTr("QR code"); font.pixelSize: 15; color: "#e0e0e0" }
                //     }

                //     MouseArea { id: qrMouse; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor
                //         onClicked: mainWindow.closeIndicatorDrawer() }

                //     Rectangle { anchors.bottom: parent.bottom; anchors.left: parent.left; anchors.right: parent.right
                //         anchors.leftMargin: 24; anchors.rightMargin: 24; height: 1; color: Qt.rgba(1, 1, 1, 0.1) }
                // }
            }

            // ----------------> Footer - Anchored to bottom
            Rectangle {
                id:             footer
                anchors.bottom: parent.bottom
                anchors.left:   parent.left
                anchors.right:  parent.right
                height:         80
                color:          Qt.rgba(0, 0, 0, 0.3)

                Column {
                    anchors.centerIn: parent
                    spacing: 4

                    QGCLabel {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text:           "------ Powered By ------"
                        font.pixelSize: 9
                        color:          Qt.rgba(1, 1, 1, 0.4)
                    }

                    QGCLabel {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text:           "Nesta Aerospace"
                        font.pixelSize: 14
                        font.weight:    Font.Bold
                        color:          "#00d4ff"
                    }
                }
            }
        }
    }
}
}