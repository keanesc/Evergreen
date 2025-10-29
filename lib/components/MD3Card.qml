// Material Design 3 Card Component
// Reference: https://m3.material.io/components/cards/overview
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Pane {
    id: root
    
    // Card variants
    enum CardType {
        Elevated,
        Filled,
        Outlined
    }
    
    property int cardType: MD3Card.CardType.Elevated
    property color cardColor: "#1C1B1F"
    property color outlineColor: "#79747E"
    property real cardRadius: 12
    property real elevationLevel: 1
    property bool clickable: false
    property bool checked: false
    property bool dragged: false
    
    signal clicked()
    
    implicitWidth: 300
    implicitHeight: 200
    
    padding: 0
    
    Component.onCompleted: {
        switch (cardType) {
            case MD3Card.CardType.Elevated:
                background.color = Qt.binding(() => "#1C1B1F")
                elevationLevel = dragged ? 8 : 1
                break
            case MD3Card.CardType.Filled:
                background.color = Qt.binding(() => "#49454F")
                elevationLevel = dragged ? 8 : 0
                break
            case MD3Card.CardType.Outlined:
                background.color = Qt.binding(() => "#1C1B1F")
                background.border.width = 1
                background.border.color = Qt.binding(() => outlineColor)
                elevationLevel = dragged ? 8 : 0
                break
        }
    }
    
    background: Rectangle {
        id: cardBackground
        radius: cardRadius
        color: cardColor
        
        // Simple shadow effect
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
        
        // State layer for clickable cards
        Rectangle {
            anchors.fill: parent
            radius: parent.radius
            color: "#D0BCFF"
            opacity: cardMouseArea.pressed ? 0.12 : cardMouseArea.containsMouse ? 0.08 : 0
            visible: root.clickable
            
            Behavior on opacity {
                NumberAnimation { duration: 150 }
            }
        }
    }
    
    MouseArea {
        id: cardMouseArea
        anchors.fill: parent
        enabled: root.clickable
        hoverEnabled: root.clickable
        onClicked: root.clicked()
    }
    
    // Default content (can be overridden)
    default property alias content: contentContainer.data
    
    ColumnLayout {
        id: contentContainer
        anchors.fill: parent
        spacing: 0
    }
}
