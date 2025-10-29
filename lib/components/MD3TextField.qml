// Material Design 3 Text Field Component
// Reference: https://m3.material.io/components/text-fields/overview
import QtQuick
import QtQuick.Controls

TextField {
    id: root
    
    // Text field variants
    enum TextFieldType {
        Filled,
        Outlined
    }
    
    property int textFieldType: MD3TextField.TextFieldType.Filled
    property string labelText: ""
    property string supportingText: ""
    property string errorText: ""
    property bool hasError: false
    property string leadingIconSource: ""
    property string trailingIconSource: ""
    property color containerColor: "#49454F"
    property color focusedColor: "#D0BCFF"
    property color unfocusedColor: "#CAC4D0"
    property color errorColor: "#F2B8B5"
    
    signal leadingIconClicked()
    signal trailingIconClicked()
    
    implicitWidth: 280
    implicitHeight: 56
    
    leftPadding: leadingIconSource !== "" ? 52 : 16
    rightPadding: trailingIconSource !== "" ? 52 : 16
    topPadding: 8
    bottomPadding: 8
    
    font.family: "Roboto"
    font.pixelSize: 16
    color: "#E6E1E5"
    
    placeholderText: labelText
    placeholderTextColor: hasError ? errorColor : (activeFocus ? focusedColor : unfocusedColor)
    
    background: Item {
        implicitWidth: 280
        implicitHeight: 56
        
        // Filled variant
        Rectangle {
            visible: root.textFieldType === MD3TextField.TextFieldType.Filled
            anchors.fill: parent
            radius: 4
            color: containerColor
            
            Rectangle {
                anchors.bottom: parent.bottom
                width: parent.width
                height: 1
                color: root.hasError ? errorColor : (root.activeFocus ? focusedColor : unfocusedColor)
            }
            
            Rectangle {
                anchors.bottom: parent.bottom
                width: root.activeFocus ? parent.width : 0
                height: 2
                color: root.hasError ? errorColor : focusedColor
                
                Behavior on width {
                    NumberAnimation { duration: 200 }
                }
            }
        }
        
        // Outlined variant
        Rectangle {
            visible: root.textFieldType === MD3TextField.TextFieldType.Outlined
            anchors.fill: parent
            radius: 4
            color: "transparent"
            border.width: root.activeFocus ? 2 : 1
            border.color: root.hasError ? errorColor : (root.activeFocus ? focusedColor : unfocusedColor)
            
            Behavior on border.width {
                NumberAnimation { duration: 150 }
            }
        }
        
        // Leading icon
        Image {
            id: leadingIcon
            visible: root.leadingIconSource !== ""
            source: root.leadingIconSource
            anchors.left: parent.left
            anchors.leftMargin: 12
            anchors.verticalCenter: parent.verticalCenter
            width: 24
            height: 24
            fillMode: Image.PreserveAspectFit
            
            MouseArea {
                anchors.fill: parent
                onClicked: root.leadingIconClicked()
            }
        }
        
        // Trailing icon
        Image {
            id: trailingIcon
            visible: root.trailingIconSource !== ""
            source: root.trailingIconSource
            anchors.right: parent.right
            anchors.rightMargin: 12
            anchors.verticalCenter: parent.verticalCenter
            width: 24
            height: 24
            fillMode: Image.PreserveAspectFit
            
            MouseArea {
                anchors.fill: parent
                onClicked: root.trailingIconClicked()
            }
        }
    }
    
    // Supporting/error text
    Text {
        visible: (root.supportingText !== "" && !root.hasError) || (root.errorText !== "" && root.hasError)
        text: root.hasError ? root.errorText : root.supportingText
        anchors.top: parent.bottom
        anchors.topMargin: 4
        anchors.left: parent.left
        anchors.leftMargin: 16
        font.family: "Roboto"
        font.pixelSize: 12
        color: root.hasError ? errorColor : unfocusedColor
    }
}
