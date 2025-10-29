// Status Bar Component
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

import "../lib/components" as MD3

Rectangle {
    id: statusBar
    color: "#1C1B1F" // Material surface
    
    signal settingsClicked()
    
    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 16
        anchors.rightMargin: 16
        spacing: 16
        
        // Left section - Logo and time
        RowLayout {
            spacing: 12
            
            Rectangle {
                width: 28
                height: 28
                radius: 14
                color: "#D0BCFF" // Material primary
                
                Text {
                    anchors.centerIn: parent
                    text: "E"
                    font.family: "Roboto"
                    font.pixelSize: 16
                    font.weight: Font.Bold
                    color: "#381E72" // Material onPrimary
                }
            }
            
            Text {
                id: timeText
                text: Qt.formatDateTime(new Date(), "hh:mm")
                font.family: "Roboto"
                font.pixelSize: 14
                font.weight: Font.Medium
                color: "#E6E1E5" // Material onSurface
                
                Timer {
                    interval: 1000
                    running: true
                    repeat: true
                    onTriggered: {
                        timeText.text = Qt.formatDateTime(new Date(), "hh:mm")
                    }
                }
            }
            
            Text {
                text: Qt.formatDateTime(new Date(), "MMMM dd, yyyy")
                font.family: "Roboto"
                font.pixelSize: 14
                color: "#CAC4D0" // Material onSurfaceVariant
            }
        }
        
        Item {
            Layout.fillWidth: true
        }
        
        // Right section - System indicators
        RowLayout {
            spacing: 8
            
            // WiFi indicator
            Rectangle {
                width: 32
                height: 32
                radius: 16
                color: "transparent"
                
                Text {
                    anchors.centerIn: parent
                    text: "󰤨" // WiFi icon (nerd font)
                    font.family: "Material Symbols Rounded"
                    font.pixelSize: 18
                    color: "#CAC4D0"
                }
            }
            
            // Battery indicator
            Rectangle {
                width: 32
                height: 32
                radius: 16
                color: "transparent"
                
                Text {
                    anchors.centerIn: parent
                    text: "󰁹" // Battery icon
                    font.family: "Material Symbols Rounded"
                    font.pixelSize: 18
                    color: "#CAC4D0"
                }
            }
            
            // Volume indicator
            Rectangle {
                width: 32
                height: 32
                radius: 16
                color: "transparent"
                
                Text {
                    anchors.centerIn: parent
                    text: "󰕾" // Volume icon
                    font.family: "Material Symbols Rounded"
                    font.pixelSize: 18
                    color: "#CAC4D0"
                }
            }
            
            Rectangle {
                width: 1
                height: 24
                color: "#49454F" // Material outline
            }
            
            // Settings button
            Rectangle {
                id: settingsBtn
                width: 36
                height: 36
                radius: 18
                color: hovered ? "#49454F" : "transparent"
                
                property bool hovered: false
                
                Behavior on color {
                    ColorAnimation { duration: 150 }
                }
                
                Text {
                    anchors.centerIn: parent
                    text: "settings"
                    font.family: "Material Symbols Rounded"
                    font.pixelSize: 20
                    color: "#D0BCFF"
                }
                
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onEntered: settingsBtn.hovered = true
                    onExited: settingsBtn.hovered = false
                    onClicked: statusBar.settingsClicked()
                }
            }
        }
    }
}
