// Material Design 3 Checkbox Component
// Reference: https://m3.material.io/components/checkbox/overview
import QtQuick
import QtQuick.Controls

CheckBox {
    id: root
    
    property color checkedColor: "#D0BCFF"
    property color uncheckedColor: "#CAC4D0"
    property color disabledColor: "#E6E1E5"
    
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                           implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                            implicitContentHeight + topPadding + bottomPadding,
                            implicitIndicatorHeight + topPadding + bottomPadding)
    
    spacing: 8
    padding: 8
    
    indicator: Rectangle {
        implicitWidth: 18
        implicitHeight: 18
        x: root.leftPadding
        y: parent.height / 2 - height / 2
        radius: 2
        border.width: 2
        border.color: {
            if (!root.enabled) return disabledColor
            return root.checked ? checkedColor : uncheckedColor
        }
        color: root.checked ? checkedColor : "transparent"
        
        opacity: root.enabled ? 1.0 : 0.38
        
        // State layer
        Rectangle {
            anchors.centerIn: parent
            width: 40
            height: 40
            radius: 20
            color: root.checked ? checkedColor : uncheckedColor
            opacity: root.pressed ? 0.12 : root.hovered ? 0.08 : 0
            
            Behavior on opacity {
                NumberAnimation { duration: 150 }
            }
        }
        
        // Checkmark
        Canvas {
            id: checkmark
            anchors.fill: parent
            visible: root.checked || root.checkState === Qt.PartiallyChecked
            onPaint: {
                var ctx = getContext("2d")
                ctx.clearRect(0, 0, width, height)
                ctx.strokeStyle = "#381E72"
                ctx.lineWidth = 2
                ctx.lineCap = "round"
                ctx.lineJoin = "round"
                
                if (root.checkState === Qt.PartiallyChecked) {
                    // Draw minus sign
                    ctx.beginPath()
                    ctx.moveTo(4, height / 2)
                    ctx.lineTo(width - 4, height / 2)
                    ctx.stroke()
                } else {
                    // Draw checkmark
                    ctx.beginPath()
                    ctx.moveTo(4, height / 2)
                    ctx.lineTo(width / 2 - 1, height - 5)
                    ctx.lineTo(width - 4, 5)
                    ctx.stroke()
                }
            }
        }
        
        Connections {
            target: root
            function onCheckedChanged() { checkmark.requestPaint() }
            function onCheckStateChanged() { checkmark.requestPaint() }
        }
    }
    
    contentItem: Text {
        leftPadding: root.indicator.width + root.spacing
        text: root.text
        font.family: "Roboto"
        font.pixelSize: 14
        color: "#E6E1E5"
        opacity: root.enabled ? 1.0 : 0.38
        verticalAlignment: Text.AlignVCenter
    }
}
