// Material Design 3 Snackbar Component
// Reference: https://m3.material.io/components/snackbar/overview
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Popup {
    id: root
    
    property string message: ""
    property string actionText: ""
    property bool showCloseButton: false
    property int displayDuration: 4000
    // Colors
    property color containerColor: "#E6E1E5"
    property color textColor: "#1C1B1F"
    property color actionColor: "#D0BCFF"
    
    signal actionClicked()
    
    x: (parent.width - width) / 2
    y: parent.height - height - 16
    
    implicitWidth: Math.min(parent.width - 32, 600)
    implicitHeight: snackbarContent.implicitHeight + topPadding + bottomPadding
    
    padding: 0
    topPadding: 16
    bottomPadding: 16
    leftPadding: 16
    rightPadding: 8
    
    modal: false
    dim: false
    closePolicy: Popup.CloseOnEscape
    
    background: Rectangle {
        color: containerColor
        radius: 4
        
        // Simple shadow
        Rectangle {
            anchors.fill: parent
            anchors.margins: -3
            radius: parent.radius
            color: "transparent"
            border.color: "#40000000"
            border.width: 3
            z: -1
        }
    }
    
    contentItem: RowLayout {
        id: snackbarContent
        spacing: 8
        
        Text {
            Layout.fillWidth: true
            text: root.message
            font.family: "Roboto"
            font.pixelSize: 14
            color: textColor
            wrapMode: Text.WordWrap
            maximumLineCount: 2
            elide: Text.ElideRight
        }
        
        MD3Button {
            visible: root.actionText !== ""
            text: root.actionText
            buttonType: MD3Button.ButtonType.Text
            labelColor: actionColor
            onClicked: {
                root.actionClicked()
                root.close()
            }
        }
        
        MD3IconButton {
            visible: root.showCloseButton
            iconSource: "close-icon"
            buttonType: MD3IconButton.IconButtonType.Standard
            iconColor: textColor
            onClicked: root.close()
        }
    }
    
    Timer {
        id: autoCloseTimer
        interval: root.displayDuration
        running: root.visible && root.displayDuration > 0
        onTriggered: root.close()
    }
    
    function show() {
        root.open()
    }
    
    enter: Transition {
        NumberAnimation {
            property: "opacity"
            from: 0.0
            to: 1.0
            duration: 150
        }
        NumberAnimation {
            property: "y"
            from: root.parent.height
            to: root.parent.height - root.height - 16
            duration: 200
            easing.type: Easing.OutCubic
        }
    }
    
    exit: Transition {
        NumberAnimation {
            property: "opacity"
            from: 1.0
            to: 0.0
            duration: 150
        }
    }
}
