// Material Design 3 Icon Button Component
// Reference: https://m3.material.io/components/icon-buttons/overview
import QtQuick
import QtQuick.Controls

Button {
    id: root
    
    // Icon button variants
    enum IconButtonType {
        Standard,
        Filled,
        FilledTonal,
        Outlined
    }
    
    property int buttonType: MD3IconButton.IconButtonType.Standard
    property string iconSource: ""
    property color iconColor: "#CAC4D0"
    property color containerColor: "#D0BCFF"
    property real buttonSize: 40
    property bool selected: false
    
    implicitWidth: buttonSize
    implicitHeight: buttonSize
    
    padding: 0
    
    Component.onCompleted: {
        switch (buttonType) {
            case MD3IconButton.IconButtonType.Standard:
                background.color = Qt.binding(() => "transparent")
                iconImage.color = Qt.binding(() => "#CAC4D0")
                break
            case MD3IconButton.IconButtonType.Filled:
                background.color = Qt.binding(() => selected ? "#D0BCFF" : "#49454F")
                iconImage.color = Qt.binding(() => selected ? "#381E72" : "#D0BCFF")
                break
            case MD3IconButton.IconButtonType.FilledTonal:
                background.color = Qt.binding(() => selected ? "#E8DEF8" : "#49454F")
                iconImage.color = Qt.binding(() => selected ? "#1D192B" : "#CAC4D0")
                break
            case MD3IconButton.IconButtonType.Outlined:
                background.color = Qt.binding(() => selected ? "#E6E1E5" : "transparent")
                background.border.width = selected ? 0 : 1
                background.border.color = Qt.binding(() => "#79747E")
                iconImage.color = Qt.binding(() => selected ? "#1C1B1F" : "#CAC4D0")
                break
        }
    }
    
    background: Rectangle {
        id: buttonBackground
        radius: buttonSize / 2
        color: "transparent"
        
        // State layer
        Rectangle {
            anchors.fill: parent
            radius: parent.radius
            color: iconImage.color
            opacity: root.pressed ? 0.12 : root.hovered ? 0.08 : 0
            
            Behavior on opacity {
                NumberAnimation { duration: 150 }
            }
        }
    }
    
    contentItem: Item {
        Text {
            id: iconImage
            text: root.iconSource
            anchors.centerIn: parent
            font.family: "Material Symbols Rounded"
            font.pixelSize: 24
            color: iconColor
        }
    }
    
    states: [
        State {
            name: "disabled"
            when: !root.enabled
            PropertyChanges {
                target: iconImage
                opacity: 0.38
            }
        }
    ]
}
