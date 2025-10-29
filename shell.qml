// Main Quickshell Application
import Quickshell
import QtQuick

import "modules"

Scope {
    id: root
    
    // State management
    property bool settingsPanelOpen: false
    
    function toggleSettingsPanel() {
        root.settingsPanelOpen = !root.settingsPanelOpen
    }
    
    // Status Bar
    Variants {
        model: Quickshell.screens
        
        PanelWindow {
            id: barWindow
            property var modelData
            screen: modelData
            
            anchors {
                top: true
                left: true
                right: true
            }
            
            implicitHeight: 40
            color: "transparent"
            
            StatusBar {
                anchors.fill: parent
                onSettingsClicked: root.toggleSettingsPanel()
            }
        }
    }
    
    // Settings Panel
    SettingsPanel {
        isPanelOpen: root.settingsPanelOpen
        onClose: root.settingsPanelOpen = false
    }
}
