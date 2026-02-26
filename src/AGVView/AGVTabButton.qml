import QtQuick

Rectangle {
    property string label:    ""
    property bool   isActive: false

    signal clicked()

    width:  150
    height: 40
    color:  isActive ? "#1ff18f" : "#2a2a2a" //"#ff6b35"

    Text {
        anchors.centerIn: parent
        text:             label
        color:            isActive ? "#000000" : "#666666"
        font.pixelSize:   11
        font.weight:      Font.Bold
    }

    MouseArea {
        anchors.fill: parent
        cursorShape:  Qt.PointingHandCursor
        onClicked:    parent.clicked()
    }
}