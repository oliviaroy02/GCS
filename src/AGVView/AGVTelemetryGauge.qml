import QtQuick

Rectangle {
    property string title:      ""
    property string value:      ""
    property string unit:       ""
    property real   gaugeValue: 0.5
    property color  gaugeColor: "#4caf50"

    height: 100
    color:  "#0d0d0d"

    Row {
        anchors.fill:    parent
        anchors.margins: 20
        spacing:         20

        Column {
            width:                  parent.width * 0.5
            anchors.verticalCenter: parent.verticalCenter
            spacing:                8

            Text {
                text:            title
                color:           "#1ff18f" //"#ff6b35"
                font.pixelSize:  12
                font.weight:     Font.Bold
            }

            Row {
                spacing: 5
                Text {
                    text:           value
                    color:          "#ffffff"
                    font.pixelSize: 20
                    font.weight:    Font.Bold
                }
                Text {
                    text:           unit
                    color:          "#666666"
                    font.pixelSize: 14
                }
            }
        }

        Rectangle {
            width:                  60
            height:                 60
            radius:                 30
            color:                  "#1a1a1a"
            anchors.verticalCenter: parent.verticalCenter

            Canvas {
                id: gaugeCanvas
                anchors.fill: parent
                onPaint: {
                    var ctx = getContext("2d")
                    ctx.clearRect(0, 0, width, height)
                    var cx = width / 2
                    var cy = height / 2
                    var r  = width / 2 - 5
                    ctx.beginPath()
                    ctx.arc(cx, cy, r, 0.75 * Math.PI, 2.25 * Math.PI)
                    ctx.lineWidth = 4
                    ctx.strokeStyle = "#2a2a2a"
                    ctx.stroke()
                    ctx.beginPath()
                    ctx.arc(cx, cy, r, 0.75 * Math.PI, 0.75 * Math.PI + (1.5 * Math.PI * gaugeValue))
                    ctx.lineWidth = 4
                    ctx.strokeStyle = gaugeColor
                    ctx.stroke()
                }
                Component.onCompleted: requestPaint()
            }

            Text {
                anchors.centerIn: parent
                text:             unit || value
                color:            "#ffffff"
                font.pixelSize:   10
                font.weight:      Font.Bold
            }
        }
    }

    Rectangle {
        anchors.bottom: parent.bottom
        width:          parent.width
        height:         1
        color:          Qt.rgba(1, 1, 1, 0.1)
    }
}