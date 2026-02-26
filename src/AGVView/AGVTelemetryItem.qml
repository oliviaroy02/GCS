import QtQuick

Rectangle {
    property string title: ""
    property string value: ""

    height: 70
    color:  "#0d0d0d"

    Column {
        anchors.left:           parent.left
        anchors.leftMargin:     20
        anchors.verticalCenter: parent.verticalCenter
        spacing:                8

        Text { text: title; color: "#1ff18f"; font.pixelSize: 12; font.weight: Font.Bold } //"#ff6b35"
        Text { text: value; color: "#ffffff"; font.pixelSize: 14 }
    }

    Rectangle {
        anchors.bottom: parent.bottom
        width:  parent.width
        height: 1
        color:  Qt.rgba(1, 1, 1, 0.1)
    }
}