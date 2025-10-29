// Material Design 3 Dialog Component
// Reference: https://m3.material.io/components/dialogs/overview
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Dialog {
    id: root
    
    property string dialogTitle: ""
    property string dialogText: ""
    property string iconSource: ""
    property string positiveButtonText: "OK"
    property string negativeButtonText: "Cancel"
    property string neutralButtonText: ""
    property bool showIcon: iconSource !== ""
    property bool fullScreen: false
    
    signal positiveClicked()
    signal negativeClicked()
    signal neutralClicked()
    
    modal: true
    dim: true
    
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    
    width: fullScreen ? parent.width : Math.min(560, parent.width * 0.9)
    height: fullScreen ? parent.height : Math.min(contentHeight + topPadding + bottomPadding, parent.height * 0.9)
    
    topPadding: 24
    bottomPadding: 24
    leftPadding: 24
    rightPadding: 24
    
    background: Rectangle {
        color: "#2B2930"
        radius: fullScreen ? 0 : 28
        
        // Simple shadow
        Rectangle {
            visible: !fullScreen
            anchors.fill: parent
            anchors.margins: -3
            radius: parent.radius
            color: "transparent"
            border.color: "#40000000"
            border.width: 3
            z: -1
        }
    }
    
    header: ColumnLayout {
        spacing: 16
        
        Image {
            source: root.iconSource
            visible: root.showIcon
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 24
            Layout.preferredHeight: 24
            fillMode: Image.PreserveAspectFit
        }
        
        Text {
            text: root.dialogTitle
            visible: root.dialogTitle !== ""
            Layout.fillWidth: true
            font.family: "Roboto"
            font.pixelSize: 24
            font.weight: Font.Normal
            color: "#E6E1E5"
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
        }
    }
    
    contentItem: ScrollView {
        implicitHeight: dialogContent.implicitHeight
        clip: true
        
        Text {
            id: dialogContent
            text: root.dialogText
            width: parent.width
            font.family: "Roboto"
            font.pixelSize: 14
            font.weight: Font.Normal
            color: "#CAC4D0"
            wrapMode: Text.WordWrap
        }
    }
    
    footer: RowLayout {
        spacing: 8
        
        Item {
            Layout.fillWidth: true
        }
        
        MD3Button {
            text: root.neutralButtonText
            visible: root.neutralButtonText !== ""
            buttonType: MD3Button.ButtonType.Text
            onClicked: {
                root.neutralClicked()
                root.close()
            }
        }
        
        MD3Button {
            text: root.negativeButtonText
            visible: root.negativeButtonText !== ""
            buttonType: MD3Button.ButtonType.Text
            onClicked: {
                root.negativeClicked()
                root.close()
            }
        }
        
        MD3Button {
            text: root.positiveButtonText
            buttonType: MD3Button.ButtonType.Text
            onClicked: {
                root.positiveClicked()
                root.close()
            }
        }
    }
}
