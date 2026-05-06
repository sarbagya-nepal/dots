import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import "../theme"

Item {
    id: root
    required property var screen

    // --- BOTTOM FRAME ---
    PanelWindow {
        screen: root.screen
        anchors { bottom: true; left: true; right: true }
        height: 30
        WlrLayershell.layer: WlrLayer.Top
        exclusionMode: WlrLayershell.Exclusive
        exclusiveZone: 10
        color: "transparent"

        Rectangle {
            anchors.bottom: parent.bottom
            width: parent.width
            height: 10
            color: Theme.bg
        // opacity: 0.85
        }

        // Bottom-left corner
        Canvas {
            // opacity: 0.8
            x: 10
            y: 0
            width: 20
            height: 20
            renderTarget: Canvas.FramebufferObject
            onPaint: {
                var ctx = getContext("2d")
                ctx.reset()
                ctx.fillStyle = Theme.bg
                ctx.moveTo(0, 20)
                ctx.lineTo(20, 20)
                ctx.arcTo(0, 20, 0, 0, 20)
                ctx.closePath()
                ctx.fill()
            }
        }

        // Bottom-right corner
        Canvas {
            // opacity: 0.8
            x: parent.width - 30
            y: 0
            width: 20
            height: 20
            renderTarget: Canvas.FramebufferObject
            onPaint: {
                var ctx = getContext("2d")
                ctx.reset()
                ctx.fillStyle = Theme.bg
                ctx.moveTo(20, 20)
                ctx.lineTo(0, 20)
                ctx.arcTo(20, 20, 20, 0, 20)
                ctx.closePath()
                ctx.fill()
            }
        }
    }

    // --- LEFT FRAME ---
    PanelWindow {
        screen: root.screen
        anchors { top: true; bottom: true; left: true }
        width: 10
        WlrLayershell.layer: WlrLayer.Top
        exclusionMode: WlrLayershell.Exclusive
        exclusiveZone: 10
        color: "transparent"

        Rectangle {
            anchors.fill: parent
            color: Theme.bg
        // opacity: 0.85
        }
    }

    // --- RIGHT FRAME ---
    PanelWindow {
        screen: root.screen
        anchors { top: true; bottom: true; right: true }
        width: 10
        WlrLayershell.layer: WlrLayer.Top
        exclusionMode: WlrLayershell.Exclusive
        exclusiveZone: 10
        color: "transparent"

        Rectangle {
            anchors.fill: parent
            color: Theme.bg
        // opacity: 0.85
        }
    }
}
