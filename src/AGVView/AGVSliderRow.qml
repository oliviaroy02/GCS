//C:\NestLink\GCS\src\AGVView\AGVSliderRow.qml
import QtQuick
import QtQuick.Controls

Item {
    property string label:   ""
    property string unit:    ""
    property real   minVal:  0
    property real   maxVal:  100
    property real   initVal: 50

    height: 44

    Column {
        anchors.fill:   parent
        spacing:        4

        Row {
            width:      parent.width

            Text {
                text:           label
                color:          "#aaaaaa"
                font.pixelSize: 11
                width:          parent.width * 0.6
            }

            Text {
                anchors.right:  parent.right
                text:           Math.round(slider.value) + " " + unit
                color:          "#ffffff"
                font.pixelSize: 11
                font.weight:    Font.Medium
            }
        }

        Slider {
            id:         slider
            width:      parent.width
            from:       minVal
            to:         maxVal
            value:      initVal
            height:     20

            background: Rectangle {
                x:              slider.leftPadding
                y:              slider.topPadding + slider.availableHeight / 2 - height / 2
                width:          slider.availableWidth
                height:         3
                radius:         2
                color:          Qt.rgba(1,1,1,0.1)

                Rectangle {
                    width:  slider.visualPosition * parent.width
                    height: parent.height
                    radius: 2
                    color:  "#1ff18f" //"#ff6b35"
                }
            }

            handle: Rectangle {
                x:                  slider.leftPadding + slider.visualPosition * (slider.availableWidth - width)
                y:                  slider.topPadding + slider.availableHeight / 2 - height / 2
                width:              12
                height:             12
                radius:             6
                color:              slider.pressed ? "#1ff18f" : "#ffffff" //"#ff6b35"
                border.color:       "#1ff18f" //"#ff6b35"
                border.width:       2
            }
        }
    }
}