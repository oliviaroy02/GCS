//C:\NestLink\GCS\src\AGVView\AGVCameraButton.qml
import QtQuick

Rectangle {
    property string label:      ""
    property string buttonType: ""

    signal clicked()

    width:  28
    height: 28
    radius: 14
    color:  mouseArea.pressed ? "#3a3a3a" : "#2a2a2a"
    border.color: "#00d4ff"
    border.width: 1

    Text {
        anchors.centerIn: parent
        text:             label
        color:            "#00d4ff"
        font.pixelSize:   12
    }

    MouseArea {
        id:           mouseArea
        anchors.fill: parent
        onClicked: {
            console.log("Camera control:", buttonType)
            parent.clicked()
        }
    }
}