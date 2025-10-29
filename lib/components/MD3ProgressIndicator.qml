// Material Design 3 Progress Indicator Component
// Reference: https://m3.material.io/components/progress-indicators/overview
import QtQuick
import QtQuick.Controls

Item {
    id: root
    
    // Progress indicator types
    enum IndicatorType {
        Linear,
        Circular
    }
    
    property int indicatorType: MD3ProgressIndicator.IndicatorType.Linear
    property bool indeterminate: false
    property real progress: 0.0 // 0.0 to 1.0
    property color indicatorColor: "#D0BCFF"
    property color trackColor: "#49454F"
    property real lineWidth: 4
    
    implicitWidth: indicatorType === MD3ProgressIndicator.IndicatorType.Linear ? 200 : 48
    implicitHeight: indicatorType === MD3ProgressIndicator.IndicatorType.Linear ? 4 : 48
    
    // Linear Progress Indicator
    Rectangle {
        visible: root.indicatorType === MD3ProgressIndicator.IndicatorType.Linear
        anchors.fill: parent
        radius: height / 2
        color: trackColor
        
        Rectangle {
            id: linearProgress
            width: root.indeterminate ? parent.width * 0.3 : parent.width * root.progress
            height: parent.height
            radius: height / 2
            color: indicatorColor
            
            SequentialAnimation on x {
                running: root.indeterminate && root.visible
                loops: Animation.Infinite
                
                NumberAnimation {
                    from: -linearProgress.width
                    to: root.width
                    duration: 1500
                    easing.type: Easing.InOutCubic
                }
            }
        }
    }
    
    // Circular Progress Indicator
    Item {
        visible: root.indicatorType === MD3ProgressIndicator.IndicatorType.Circular
        anchors.fill: parent
        
        Canvas {
            id: circularCanvas
            anchors.fill: parent
            
            onPaint: {
                var ctx = getContext("2d")
                var centerX = width / 2
                var centerY = height / 2
                var radius = Math.min(width, height) / 2 - root.lineWidth / 2
                
                ctx.clearRect(0, 0, width, height)
                
                // Draw track
                ctx.beginPath()
                ctx.arc(centerX, centerY, radius, 0, 2 * Math.PI)
                ctx.strokeStyle = root.trackColor
                ctx.lineWidth = root.lineWidth
                ctx.lineCap = "round"
                ctx.stroke()
                
                // Draw progress
                ctx.beginPath()
                var startAngle = -Math.PI / 2
                var endAngle = startAngle + (2 * Math.PI * root.progress)
                ctx.arc(centerX, centerY, radius, startAngle, endAngle)
                ctx.strokeStyle = root.indicatorColor
                ctx.lineWidth = root.lineWidth
                ctx.lineCap = "round"
                ctx.stroke()
            }
            
            Connections {
                target: root
                function onProgressChanged() { circularCanvas.requestPaint() }
            }
        }
        
        // Indeterminate rotation
        RotationAnimation on rotation {
            running: root.indeterminate && root.visible
            from: 0
            to: 360
            duration: 1500
            loops: Animation.Infinite
        }
    }
}
