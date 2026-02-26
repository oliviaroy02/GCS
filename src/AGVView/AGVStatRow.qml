// C:\NestLink\GCS\src\AGVView\AGVStatRow.qml
import QtQuick

Item {
    property string label: ""
    property string value: "--"
    property string accent: "#1ff18f"

    width: parent.width
    height: 22

    // Text {
    //     anchors.left: parent.left
    //     anchors.verticalCenter: parent.verticalCenter
    //     text: label
    //     color: "rgba(255,255,255,0.38)"
    //     font.pixelSize: 10
    // }

    Text {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        text: value
        color: accent
        font.pixelSize: 11
        font.weight: Font.Bold
        font.family: "Courier New"
    }
}
