// Material Design 3 Switch Component
// Reference: https://m3.material.io/components/switch/overview
import QtQuick
import QtQuick.Controls

Switch {
    id: root
    
    property color selectedTrackColor: "#D0BCFF"
    property color unselectedTrackColor: "#49454F"
    property color selectedHandleColor: "#381E72"
    property color unselectedHandleColor: "#79747E"
    property bool withIcons: false
    
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                           implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                            implicitContentHeight + topPadding + bottomPadding,
                            implicitIndicatorHeight + topPadding + bottomPadding)
    
    spacing: 8
    padding: 8
    
    indicator: Item {
        implicitWidth: 52
        implicitHeight: 32
        x: root.leftPadding
        y: parent.height / 2 - height / 2
        
        // Track
        Rectangle {
            id: track
            width: parent.width
            height: parent.height
            radius: 16
            border.width: 2
            border.color: root.checked ? "transparent" : "#79747E"
            color: root.checked ? selectedTrackColor : unselectedTrackColor
            opacity: root.enabled ? 1.0 : 0.38
            
            Behavior on color {
                ColorAnimation { duration: 150 }
            }
            
            // State layer
            Rectangle {
                anchors.centerIn: handle
                width: 40
                height: 40
                radius: 20
                color: root.checked ? selectedTrackColor : unselectedHandleColor
                opacity: root.pressed ? 0.12 : root.hovered ? 0.08 : 0
                
                Behavior on opacity {
                    NumberAnimation { duration: 150 }
                }
            }
        }
        
        // Handle
        Rectangle {
            id: handle
            width: root.checked ? 24 : 16
            height: root.checked ? 24 : 16
            radius: width / 2
            x: root.checked ? parent.width - width - 4 : 4
            y: (parent.height - height) / 2
            color: root.checked ? selectedHandleColor : unselectedHandleColor
            
            Behavior on x {
                NumberAnimation { 
                    duration: 150
                    easing.type: Easing.OutCubic
                }
            }
            
            Behavior on width {
                NumberAnimation { duration: 150 }
            }
            
            Behavior on height {
                NumberAnimation { duration: 150 }
            }
            
            // Icon (optional)
            Image {
                anchors.centerIn: parent
                width: 16
                height: 16
                visible: root.withIcons
                source: root.checked ? "check-icon" : "close-icon"
                fillMode: Image.PreserveAspectFit
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
