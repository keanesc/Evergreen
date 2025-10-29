// Material Design 3 Radio Button Component
// Reference: https://m3.material.io/components/radio-button/overview
import QtQuick
import QtQuick.Controls

RadioButton {
    id: root
    
    property color selectedColor: "#D0BCFF"
    property color unselectedColor: "#CAC4D0"
    property color disabledColor: "#E6E1E5"
    
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                           implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                            implicitContentHeight + topPadding + bottomPadding,
                            implicitIndicatorHeight + topPadding + bottomPadding)
    
    spacing: 8
    padding: 8
    
    indicator: Rectangle {
        implicitWidth: 20
        implicitHeight: 20
        x: root.leftPadding
        y: parent.height / 2 - height / 2
        radius: 10
        border.width: 2
        border.color: {
            if (!root.enabled) return disabledColor
            return root.checked ? selectedColor : unselectedColor
        }
        color: "transparent"
        
        opacity: root.enabled ? 1.0 : 0.38
        
        // State layer
        Rectangle {
            anchors.centerIn: parent
            width: 40
            height: 40
            radius: 20
            color: root.checked ? selectedColor : unselectedColor
            opacity: root.pressed ? 0.12 : root.hovered ? 0.08 : 0
            
            Behavior on opacity {
                NumberAnimation { duration: 150 }
            }
        }
        
        // Inner circle
        Rectangle {
            anchors.centerIn: parent
            width: 10
            height: 10
            radius: 5
            color: selectedColor
            visible: root.checked
            
            scale: root.checked ? 1 : 0
            
            Behavior on scale {
                NumberAnimation { 
                    duration: 150
                    easing.type: Easing.OutCubic
                }
            }
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
