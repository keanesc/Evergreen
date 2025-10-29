// Material Design 3 Slider Component
// Reference: https://m3.material.io/components/sliders/overview
import QtQuick
import QtQuick.Controls

Slider {
    id: root
    
    property color activeColor: "#D0BCFF"
    property color inactiveColor: "#49454F"
    property color handleColor: "#D0BCFF"
    property bool showLabel: false
    property bool showTickMarks: false
    property int tickMarkCount: 0
    
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                           implicitHandleWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                            implicitHandleHeight + topPadding + bottomPadding)
    
    padding: 6
    
    background: Item {
        x: root.leftPadding
        y: root.topPadding + root.availableHeight / 2 - height / 2
        implicitWidth: 200
        implicitHeight: 4
        width: root.availableWidth
        height: implicitHeight
        
        // Inactive track
        Rectangle {
            width: parent.width
            height: parent.height
            radius: 2
            color: inactiveColor
        }
        
        // Active track
        Rectangle {
            width: root.visualPosition * parent.width
            height: parent.height
            radius: 2
            color: activeColor
        }
        
        // Tick marks
        Repeater {
            model: root.showTickMarks ? root.tickMarkCount : 0
            
            Rectangle {
                x: (index / (root.tickMarkCount - 1)) * (parent.width - width)
                y: (parent.height - height) / 2
                width: 2
                height: 4
                color: index < root.value / root.to * (root.tickMarkCount - 1) ? "#381E72" : "#CAC4D0"
            }
        }
    }
    
    handle: Rectangle {
        x: root.leftPadding + root.visualPosition * (root.availableWidth - width)
        y: root.topPadding + root.availableHeight / 2 - height / 2
        implicitWidth: 20
        implicitHeight: 20
        radius: 10
        color: handleColor
        
        // Simple shadow
        Rectangle {
            anchors.fill: parent
            anchors.margins: -1
            radius: parent.radius
            color: "transparent"
            border.color: "#30000000"
            border.width: 1
            z: -1
        }
        
        // State layer
        Rectangle {
            anchors.centerIn: parent
            width: 40
            height: 40
            radius: 20
            color: activeColor
            opacity: root.pressed ? 0.12 : root.hovered ? 0.08 : 0
            
            Behavior on opacity {
                NumberAnimation { duration: 150 }
            }
        }
        
        // Value label
        Rectangle {
            visible: root.showLabel && (root.pressed || root.hovered)
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.top
            anchors.bottomMargin: 8
            width: labelText.width + 16
            height: 28
            radius: 14
            color: activeColor
            
            Text {
                id: labelText
                anchors.centerIn: parent
                text: Math.round(root.value)
                font.family: "Roboto"
                font.pixelSize: 12
                color: "#381E72"
            }
            
            // Label tail
            Canvas {
                anchors.top: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                width: 8
                height: 4
                onPaint: {
                    var ctx = getContext("2d")
                    ctx.fillStyle = activeColor
                    ctx.beginPath()
                    ctx.moveTo(4, 0)
                    ctx.lineTo(0, 4)
                    ctx.lineTo(8, 4)
                    ctx.closePath()
                    ctx.fill()
                }
            }
        }
    }
}
