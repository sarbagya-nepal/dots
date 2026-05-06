import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import "../../theme"

Item {
    id: root

    // --- BOTTOM FRAME ---
    PanelWindow {
        anchors {
            bottom: true
            left: true
            right: true
        }
        implicitHeight: 5
        color: "transparent"
        Rectangle {
            anchors.fill: parent
            color: Theme.bg
        }
    }

    // --- LEFT FRAME ---
    PanelWindow {
        anchors {
            top: true
            bottom: true
            left: true
        }
        implicitWidth: 5
        color: "transparent"
        Rectangle {
            anchors.fill: parent
            color: Theme.bg
        }
    }

    // --- RIGHT FRAME ---
    PanelWindow {
        anchors {
            top: true
            bottom: true
            right: true
        }
        implicitWidth: 5
        color: "transparent"
        Rectangle {
            anchors.fill: parent
            color: Theme.bg
        }
    }

    // --- CORNER MASKS ---
    // Top-left
    PanelWindow {
        anchors { top: true; left: true }
        implicitWidth: 15
        implicitHeight: 15
        color: "transparent"
        Canvas {
            anchors.fill: parent
            onPaint: {
                var ctx = getContext("2d")
                var r = width
                ctx.fillStyle = Theme.bg
                ctx.beginPath()
                ctx.moveTo(r, 0)
                ctx.lineTo(0, 0)
                ctx.lineTo(0, r)
                ctx.arc(r, r, r, Math.PI, 1.5 * Math.PI, false)
                ctx.closePath()
                ctx.fill()
            }
        }
    }

    // Top-right
    PanelWindow {
        anchors { top: true; right: true }
        implicitWidth: 15
        implicitHeight: 15
        color: "transparent"
        Canvas {
            anchors.fill: parent
            onPaint: {
                var ctx = getContext("2d")
                var r = width
                ctx.fillStyle = Theme.bg
                ctx.beginPath()
                ctx.moveTo(0, 0)
                ctx.lineTo(r, 0)
                ctx.lineTo(r, r)
                ctx.arc(0, r, r, 0, 1.5 * Math.PI, true)
                ctx.closePath()
                ctx.fill()
            }
        }
    }

    // Bottom-left
    PanelWindow {
        anchors { bottom: true; left: true }
        implicitWidth: 15
        implicitHeight: 15
        color: "transparent"
        Canvas {
            anchors.fill: parent
            onPaint: {
                var ctx = getContext("2d")
                var r = width
                ctx.fillStyle = Theme.bg
                ctx.beginPath()
                ctx.moveTo(0, 0)
                ctx.lineTo(0, r)
                ctx.lineTo(r, r)
                ctx.arc(r, 0, r, 0.5 * Math.PI, Math.PI, false)
                ctx.closePath()
                ctx.fill()
            }
        }
    }

    // Bottom-right
    PanelWindow {
        anchors { bottom: true; right: true }
        implicitWidth: 15
        implicitHeight: 15
        color: "transparent"
        Canvas {
            anchors.fill: parent
            onPaint: {
                var ctx = getContext("2d")
                var r = width
                ctx.fillStyle = Theme.bg
                ctx.beginPath()
                ctx.moveTo(r, 0)
                ctx.lineTo(r, r)
                ctx.lineTo(0, r)
                ctx.arc(0, 0, r, 0.5 * Math.PI, 0, true)
                ctx.closePath()
                ctx.fill()
            }
        }
    }
}
