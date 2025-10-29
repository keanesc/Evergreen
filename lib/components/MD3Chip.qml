// Material Design 3 Chip Component
// Reference: https://m3.material.io/components/chips/overview
import QtQuick
import QtQuick.Controls

Button {
    id: root
    
    // Chip variants
    enum ChipType {
        Assist,      // Help users take action
        Filter,      // Filter content
        Input,       // Represent discrete information
        Suggestion   // Help narrow user's intent
    }
    
    property int chipType: MD3Chip.ChipType.Assist
    property bool withIcon: false
    property string iconSource: ""
    property bool withAvatar: false
    property string avatarSource: ""
    property bool closable: false
    // Colors
    property color containerColor: "#E8DEF8"
    property color labelColor: "#1D192B"
    property real chipHeight: 32
    
    signal closeClicked()
    
    implicitWidth: Math.max(64, contentItem.implicitWidth + leftPadding + rightPadding)
    implicitHeight: chipHeight
    
    leftPadding: (withIcon || withAvatar) ? 8 : 16
    rightPadding: closable ? 8 : 16
    topPadding: 6
    bottomPadding: 6
    
    spacing: 8
    
    Component.onCompleted: {
        switch (chipType) {
            case "Assist":
                background.color = Qt.binding(() => "#E8DEF8")
                contentItem.color = Qt.binding(() => "#1D192B")
                break
            case "Filter":
                background.color = Qt.binding(() => checked ? "#E8DEF8" : "transparent")
                background.radius = Qt.binding(() => 8)
                background.border.color = Qt.binding(() => "#79747E")
                contentItem.color = Qt.binding(() => checked ? "#1D192B" : "#CAC4D0")
                background.border.width = Qt.binding(() => 1)
                break
            case "Input":
                background.color = Qt.binding(() => "#E8DEF8")
                contentItem.color = Qt.binding(() => "#1D192B")
                background.radius = Qt.binding(() => 8)
                break
            case "Suggestion":
                background.color = Qt.binding(() => "transparent")
                background.radius = Qt.binding(() => 8)
                background.border.color = Qt.binding(() => "#79747E")
                contentItem.color = Qt.binding(() => "#CAC4D0")
                background.border.width = Qt.binding(() => 1)
        }
    }
    
    background: Rectangle {
        id: chipBackground
        radius: chipHeight / 2
        color: containerColor
        
        // State layer
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
        
        // Avatar (for input chips)
        Rectangle {
            visible: root.withAvatar && root.avatarSource !== ""
            width: 24
            height: 24
            radius: 12
            anchors.verticalCenter: parent.verticalCenter
            color: "#D0BCFF"
            
            Text {
                anchors.centerIn: parent
                text: root.avatarSource.charAt(0).toUpperCase()
                font.family: "Roboto"
                font.pixelSize: 12
                font.weight: Font.Medium
                color: "#381E72"
            }
        }
        
        // Icon
        Image {
            source: root.iconSource
            visible: root.withIcon && root.iconSource !== "" && !root.withAvatar
            width: 18
            height: 18
            anchors.verticalCenter: parent.verticalCenter
            fillMode: Image.PreserveAspectFit
        }
        
        // Checkmark for filter chips
        Image {
            source: "checkmark-icon"
            visible: root.chipType === MD3Chip.ChipType.Filter && root.checked
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
        }
        
        // Close button for input chips
        MouseArea {
            visible: root.closable
            width: 18
            height: 18
            anchors.verticalCenter: parent.verticalCenter
            onClicked: {
                mouse.accepted = true
                root.closeClicked()
            }
            
            Image {
                source: "close-icon"
                anchors.fill: parent
                fillMode: Image.PreserveAspectFit
            }
        }
    }
}
