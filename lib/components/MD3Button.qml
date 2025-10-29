// Material Design 3 Button Component
// Reference: https://m3.material.io/components/buttons/overview
import QtQuick
import QtQuick.Controls

Button {
    id: root
    
    // Button variants
    enum ButtonType {
        Filled,      // Highest emphasis
        FilledTonal, // Medium-high emphasis
        Elevated,    // Medium emphasis
        Outlined,    // Medium emphasis
        Text         // Lowest emphasis
    }
    
    property int buttonType: MD3Button.ButtonType.Filled
    property bool withIcon: false
    property string iconSource: ""
    property color containerColor: "#D0BCFF"
    property color labelColor: "#381E72"
    property color outlineColor: "#79747E"
    property real buttonRadius: 20
    property real buttonHeight: 40
    property real elevationLevel: 0
    
    implicitWidth: Math.max(64, contentItem.implicitWidth + leftPadding + rightPadding)
    implicitHeight: buttonHeight
    
    leftPadding: withIcon ? 16 : 24
    rightPadding: 24
    topPadding: 10
    bottomPadding: 10
    
    spacing: 8
    
    // Configure appearance based on button type
    Component.onCompleted: {
        switch (buttonType) {
            case MD3Button.ButtonType.Filled:
                background.color = Qt.binding(() => containerColor)
                contentItem.color = Qt.binding(() => labelColor)
                elevationLevel = 0
                break
            case MD3Button.ButtonType.FilledTonal:
                background.color = Qt.binding(() => "#E8DEF8")
                contentItem.color = Qt.binding(() => "#1D192B")
                elevationLevel = 0
                break
            case MD3Button.ButtonType.Elevated:
                background.color = Qt.binding(() => "#1C1B1F")
                contentItem.color = Qt.binding(() => "#D0BCFF")
                elevationLevel = 1
                break
            case MD3Button.ButtonType.Outlined:
                background.color = Qt.binding(() => "transparent")
                background.border.width = 1
                background.border.color = Qt.binding(() => outlineColor)
                contentItem.color = Qt.binding(() => "#D0BCFF")
                elevationLevel = 0
                break
            case MD3Button.ButtonType.Text:
                background.color = Qt.binding(() => "transparent")
                contentItem.color = Qt.binding(() => "#D0BCFF")
                elevationLevel = 0
                break
        }
    }
    
    background: Rectangle {
        id: buttonBackground
        radius: buttonRadius
        color: containerColor
        
        // Simple shadow effect using rectangles
        Rectangle {
            visible: elevationLevel > 0
            anchors.fill: parent
            anchors.margins: -2
            radius: parent.radius
            color: "transparent"
            border.color: "#20000000"
            border.width: elevationLevel
            z: -1
        }
        
        // State layer (ripple effect)
        Rectangle {
            anchors.fill: parent
            radius: parent.radius
            color: labelColor
            opacity: root.pressed ? 0.12 : root.hovered ? 0.08 : 0
            
            Behavior on opacity {
                NumberAnimation { duration: 150 }
            }
        }
    }
    
    contentItem: Row {
        spacing: root.spacing
        
        Image {
            source: root.iconSource
            visible: root.withIcon && root.iconSource !== ""
            width: 18
            height: 18
            anchors.verticalCenter: parent.verticalCenter
            fillMode: Image.PreserveAspectFit
        }
        
        Text {
            text: root.text
            font.family: "Roboto"
            font.pixelSize: 14
            font.weight: Font.Medium
            font.letterSpacing: 0.1
            color: labelColor
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
    }
    
    // State changes
    states: [
        State {
            name: "disabled"
            when: !root.enabled
            PropertyChanges {
                target: buttonBackground
                opacity: 0.38
            }
        }
    ]
}
