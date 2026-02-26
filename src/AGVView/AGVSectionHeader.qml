//C:\NestLink\GCS\src\AGVView\AGVSectionHeader.qml
import QtQuick

Item {
    property string label:  ""
    property string accent: "#1ff18f" //"#ff6b35"

    height: 28

    Row {
        anchors.verticalCenter: parent.verticalCenter
        spacing: 8

        Rectangle {
            width:                  3
            height:                 14
            radius:                 2
            color:                  accent
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            text:           label
            color:          accent
            font.pixelSize: 10
            font.weight:    Font.Bold
            font.letterSpacing: 1.5
        }
    }
}