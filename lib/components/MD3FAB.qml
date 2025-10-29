// Material Design 3 Floating Action Button Component
// Reference: https://m3.material.io/components/floating-action-button/overview
import QtQuick
import QtQuick.Controls

Button {
    id: root
    
    // FAB variants
    enum FABSize {
        Small,
        Medium,
        Large
    }
    
    enum FABType {
        Surface,
        Primary,
        Secondary,
        Tertiary
    }
    
    property int fabSize: MD3FAB.FABSize.Medium
    property int fabType: MD3FAB.FABType.Primary
    property string iconSource: ""
    property string label: ""
    property bool extended: label !== ""
    // Colors
    property color containerColor: "#EADDFF"
    property color iconColor: "#21005D"
    
    implicitWidth: {
        if (extended) return Math.max(80, labelText.implicitWidth + iconImage.width + 32)
        switch (fabSize) {
            case MD3FAB.FABSize.Small: return 40
            case MD3FAB.FABSize.Medium: return 56
            case MD3FAB.FABSize.Large: return 96
            default: return 56
        }
    }
    
    implicitHeight: {
        if (extended) return 56
        switch (fabSize) {
            case MD3FAB.FABSize.Small: return 40
            case MD3FAB.FABSize.Medium: return 56
            case MD3FAB.FABSize.Large: return 96
            default: return 56
        }
    }
    
    Component.onCompleted: {
        switch (fabType) {
            case "Surface":
                background.color = Qt.binding(() => "#1C1B1F")
                iconImage.color = Qt.binding(() => "#D0BCFF")
                break
            case "Primary":
                background.color = Qt.binding(() => "#EADDFF")
                iconImage.color = Qt.binding(() => "#21005D")
                break
            case "Secondary":
                background.color = Qt.binding(() => "#E8DEF8")
                iconImage.color = Qt.binding(() => "#1D192B")
                break
            case "Tertiary":
                background.color = Qt.binding(() => "#FFD8E4")
                iconImage.color = Qt.binding(() => "#31111D")
        }
    }
    
    background: Rectangle {
        id: fabBackground
        radius: {
            if (root.extended) return 16
            switch (root.fabSize) {
                case MD3FAB.FABSize.Small: return 12
                case MD3FAB.FABSize.Medium: return 16
                case MD3FAB.FABSize.Large: return 28
                default: return 16
            }
        }
        color: containerColor
        
        // Simple shadow
        Rectangle {
            anchors.fill: parent
            anchors.margins: -3
            radius: parent.radius
            color: "transparent"
            border.color: "#30000000"
            border.width: 3
            z: -1
        }
        
        // State layer
        Rectangle {
            anchors.fill: parent
            radius: parent.radius
            color: iconColor
            opacity: root.pressed ? 0.12 : root.hovered ? 0.08 : 0
            
            Behavior on opacity {
                NumberAnimation { duration: 150 }
            }
        }
    }
    
    contentItem: Row {
        spacing: 12
        anchors.centerIn: parent
        
        Image {
            id: iconImage
            source: root.iconSource
            anchors.verticalCenter: parent.verticalCenter
            width: {
                switch (root.fabSize) {
                    case MD3FAB.FABSize.Small: return 24
                    case MD3FAB.FABSize.Large: return 36
                    default: return 24
                }
            }
            height: width
            fillMode: Image.PreserveAspectFit
        }
        
        Text {
            id: labelText
            text: root.label
            visible: root.extended
            font.family: "Roboto"
            font.pixelSize: 14
            font.weight: Font.Medium
            color: iconColor
            verticalAlignment: Text.AlignVCenter
        }
    }
}
