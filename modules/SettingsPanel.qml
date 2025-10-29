// Settings Panel Component - Showcases MD3 Components
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell

import "../lib/components" as MD3

Loader {
    id: root
    required property bool isPanelOpen
    
    signal close()
    
    active: false
    
    onIsPanelOpenChanged: {
        if (isPanelOpen) {
            root.active = true
        }
    }
    
    sourceComponent: Variants {
        model: Quickshell.screens
        
        PanelWindow {
            id: settingsWindow
            property var modelData
            screen: modelData
            
            anchors {
                top: true
                bottom: true
                left: true
                right: true
            }
            
            color: "transparent"
            visible: true
            
            // Backdrop
            Rectangle {
                anchors.fill: parent
                color: "#000000"
                opacity: root.isPanelOpen ? 0.5 : 0
                
                Behavior on opacity {
                    NumberAnimation { duration: 200 }
                }
                
                MouseArea {
                    anchors.fill: parent
                    onClicked: root.close()
                }
            }
            
            // Panel
            Rectangle {
                id: panel
                width: 480
                height: parent.height
                anchors.right: parent.right
                anchors.rightMargin: root.isPanelOpen ? 0 : -width
                color: "#1C1B1F" // Material surface
                
                Behavior on anchors.rightMargin {
                    NumberAnimation { 
                        id: panelAnimation
                        duration: 300
                        easing.type: Easing.OutCubic
                        onFinished: {
                            if (!root.isPanelOpen) {
                                root.active = false
                            }
                        }
                    }
                }
                
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 24
                    spacing: 24
                    
                    // Header
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 16
                        
                        Text {
                            text: "Material Design 3 Components"
                            font.family: "Roboto"
                            font.pixelSize: 24
                            font.weight: Font.Medium
                            color: "#E6E1E5"
                            Layout.fillWidth: true
                        }
                        
                        MD3.MD3IconButton {
                            buttonType: MD3.MD3IconButton.IconButtonType.Standard
                            iconSource: "close-icon"
                            onClicked: root.close()
                        }
                    }
                    
                    // Scrollable content
                    ScrollView {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        clip: true
                        
                        ColumnLayout {
                            width: panel.width - 48
                            spacing: 32
                            
                            // Buttons Section
                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 16
                                
                                Text {
                                    text: "Buttons"
                                    font.family: "Roboto"
                                    font.pixelSize: 20
                                    font.weight: Font.Medium
                                    color: "#D0BCFF"
                                }
                                
                                RowLayout {
                                    spacing: 12
                                    
                                    MD3.MD3Button {
                                        text: "Filled"
                                        buttonType: MD3.MD3Button.ButtonType.Filled
                                        onClicked: console.log("Filled button clicked")
                                    }
                                    
                                    MD3.MD3Button {
                                        text: "Tonal"
                                        buttonType: MD3.MD3Button.ButtonType.FilledTonal
                                    }
                                    
                                    MD3.MD3Button {
                                        text: "Outlined"
                                        buttonType: MD3.MD3Button.ButtonType.Outlined
                                    }
                                }
                                
                                RowLayout {
                                    spacing: 12
                                    
                                    MD3.MD3Button {
                                        text: "Text"
                                        buttonType: MD3.MD3Button.ButtonType.Text
                                    }
                                    
                                    MD3.MD3Button {
                                        text: "With Icon"
                                        buttonType: MD3.MD3Button.ButtonType.Filled
                                        withIcon: true
                                        iconSource: "add-icon"
                                    }
                                }
                            }
                            
                            Rectangle {
                                Layout.fillWidth: true
                                height: 1
                                color: "#49454F"
                            }
                            
                            // Icon Buttons Section
                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 16
                                
                                Text {
                                    text: "Icon Buttons"
                                    font.family: "Roboto"
                                    font.pixelSize: 20
                                    font.weight: Font.Medium
                                    color: "#D0BCFF"
                                }
                                
                                RowLayout {
                                    spacing: 12
                                    
                                    MD3.MD3IconButton {
                                        buttonType: MD3.MD3IconButton.IconButtonType.Standard
                                        iconSource: "favorite-icon"
                                    }
                                    
                                    MD3.MD3IconButton {
                                        buttonType: MD3.MD3IconButton.IconButtonType.Filled
                                        iconSource: "favorite-icon"
                                    }
                                    
                                    MD3.MD3IconButton {
                                        buttonType: MD3.MD3IconButton.IconButtonType.FilledTonal
                                        iconSource: "favorite-icon"
                                    }
                                    
                                    MD3.MD3IconButton {
                                        buttonType: MD3.MD3IconButton.IconButtonType.Outlined
                                        iconSource: "favorite-icon"
                                    }
                                }
                            }
                            
                            Rectangle {
                                Layout.fillWidth: true
                                height: 1
                                color: "#49454F"
                            }
                            
                            // FAB Section
                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 16
                                
                                Text {
                                    text: "Floating Action Buttons"
                                    font.family: "Roboto"
                                    font.pixelSize: 20
                                    font.weight: Font.Medium
                                    color: "#D0BCFF"
                                }
                                
                                RowLayout {
                                    spacing: 12
                                    
                                    MD3.MD3FAB {
                                        fabSize: MD3.MD3FAB.FABSize.Small
                                        iconSource: "add-icon"
                                    }
                                    
                                    MD3.MD3FAB {
                                        fabSize: MD3.MD3FAB.FABSize.Medium
                                        iconSource: "edit-icon"
                                    }
                                    
                                    MD3.MD3FAB {
                                        iconSource: "add-icon"
                                        label: "Create"
                                        extended: true
                                    }
                                }
                            }
                            
                            Rectangle {
                                Layout.fillWidth: true
                                height: 1
                                color: "#49454F"
                            }
                            
                            // Selection Controls
                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 16
                                
                                Text {
                                    text: "Selection Controls"
                                    font.family: "Roboto"
                                    font.pixelSize: 20
                                    font.weight: Font.Medium
                                    color: "#D0BCFF"
                                }
                                
                                MD3.MD3Checkbox {
                                    text: "Checkbox Option"
                                    checked: true
                                }
                                
                                MD3.MD3RadioButton {
                                    text: "Radio Option"
                                    checked: true
                                }
                                
                                MD3.MD3Switch {
                                    text: "Switch Option"
                                    checked: true
                                }
                            }
                            
                            Rectangle {
                                Layout.fillWidth: true
                                height: 1
                                color: "#49454F"
                            }
                            
                            // Chips Section
                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 16
                                
                                Text {
                                    text: "Chips"
                                    font.family: "Roboto"
                                    font.pixelSize: 20
                                    font.weight: Font.Medium
                                    color: "#D0BCFF"
                                }
                                
                                Flow {
                                    Layout.fillWidth: true
                                    spacing: 8
                                    
                                    MD3.MD3Chip {
                                        text: "Assist"
                                        chipType: MD3.MD3Chip.ChipType.Assist
                                        withIcon: true
                                    }
                                    
                                    MD3.MD3Chip {
                                        text: "Filter"
                                        chipType: MD3.MD3Chip.ChipType.Filter
                                        checked: true
                                    }
                                    
                                    MD3.MD3Chip {
                                        text: "Input"
                                        chipType: MD3.MD3Chip.ChipType.Input
                                        closable: true
                                    }
                                    
                                    MD3.MD3Chip {
                                        text: "Suggestion"
                                        chipType: MD3.MD3Chip.ChipType.Suggestion
                                    }
                                }
                            }
                            
                            Rectangle {
                                Layout.fillWidth: true
                                height: 1
                                color: "#49454F"
                            }
                            
                            // Text Field Section
                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 16
                                
                                Text {
                                    text: "Text Fields"
                                    font.family: "Roboto"
                                    font.pixelSize: 20
                                    font.weight: Font.Medium
                                    color: "#D0BCFF"
                                }
                                
                                MD3.MD3TextField {
                                    Layout.fillWidth: true
                                    labelText: "Filled Text Field"
                                    supportingText: "Supporting text"
                                    textFieldType: MD3.MD3TextField.TextFieldType.Filled
                                }
                                
                                MD3.MD3TextField {
                                    Layout.fillWidth: true
                                    labelText: "Outlined Text Field"
                                    textFieldType: MD3.MD3TextField.TextFieldType.Outlined
                                }
                            }
                            
                            Rectangle {
                                Layout.fillWidth: true
                                height: 1
                                color: "#49454F"
                            }
                            
                            // Slider Section
                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 16
                                
                                Text {
                                    text: "Sliders"
                                    font.family: "Roboto"
                                    font.pixelSize: 20
                                    font.weight: Font.Medium
                                    color: "#D0BCFF"
                                }
                                
                                MD3.MD3Slider {
                                    Layout.fillWidth: true
                                    value: 50
                                    from: 0
                                    to: 100
                                    showLabel: true
                                }
                                
                                MD3.MD3Slider {
                                    Layout.fillWidth: true
                                    value: 75
                                    from: 0
                                    to: 100
                                    showTickMarks: true
                                    tickMarkCount: 5
                                }
                            }
                            
                            Rectangle {
                                Layout.fillWidth: true
                                height: 1
                                color: "#49454F"
                            }
                            
                            // Progress Indicators Section
                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 16
                                
                                Text {
                                    text: "Progress Indicators"
                                    font.family: "Roboto"
                                    font.pixelSize: 20
                                    font.weight: Font.Medium
                                    color: "#D0BCFF"
                                }
                                
                                MD3.MD3ProgressIndicator {
                                    Layout.fillWidth: true
                                    indicatorType: MD3.MD3ProgressIndicator.IndicatorType.Linear
                                    progress: 0.6
                                }
                                
                                RowLayout {
                                    spacing: 16
                                    
                                    MD3.MD3ProgressIndicator {
                                        indicatorType: MD3.MD3ProgressIndicator.IndicatorType.Circular
                                        progress: 0.75
                                    }
                                    
                                    MD3.MD3ProgressIndicator {
                                        indicatorType: MD3.MD3ProgressIndicator.IndicatorType.Circular
                                        indeterminate: true
                                    }
                                }
                            }
                            
                            Rectangle {
                                Layout.fillWidth: true
                                height: 1
                                color: "#49454F"
                            }
                            
                            // Cards Section
                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 16
                                
                                Text {
                                    text: "Cards"
                                    font.family: "Roboto"
                                    font.pixelSize: 20
                                    font.weight: Font.Medium
                                    color: "#D0BCFF"
                                }
                                
                                MD3.MD3Card {
                                    Layout.fillWidth: true
                                    implicitHeight: 120
                                    cardType: MD3.MD3Card.CardType.Elevated
                                    clickable: true
                                    
                                    ColumnLayout {
                                        anchors.fill: parent
                                        anchors.margins: 16
                                        
                                        Text {
                                            text: "Elevated Card"
                                            font.family: "Roboto"
                                            font.pixelSize: 18
                                            font.weight: Font.Medium
                                            color: "#E6E1E5"
                                        }
                                        
                                        Text {
                                            text: "This is an elevated card with shadow"
                                            font.family: "Roboto"
                                            font.pixelSize: 14
                                            color: "#CAC4D0"
                                            wrapMode: Text.WordWrap
                                            Layout.fillWidth: true
                                        }
                                    }
                                }
                                
                                MD3.MD3Card {
                                    Layout.fillWidth: true
                                    implicitHeight: 120
                                    cardType: MD3.MD3Card.CardType.Outlined
                                    
                                    ColumnLayout {
                                        anchors.fill: parent
                                        anchors.margins: 16
                                        
                                        Text {
                                            text: "Outlined Card"
                                            font.family: "Roboto"
                                            font.pixelSize: 18
                                            font.weight: Font.Medium
                                            color: "#E6E1E5"
                                        }
                                        
                                        Text {
                                            text: "This is an outlined card with border"
                                            font.family: "Roboto"
                                            font.pixelSize: 14
                                            color: "#CAC4D0"
                                            wrapMode: Text.WordWrap
                                            Layout.fillWidth: true
                                        }
                                    }
                                }
                            }
                            
                            // Bottom spacing
                            Item {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 32
                            }
                        }
                    }
                }
            }
        }
    }
}
