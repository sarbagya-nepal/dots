import QtQuick
import Quickshell
import Quickshell.Wayland
import "../theme"

PanelWindow {
    id: root

    anchors.top: true
    anchors.left: true
    anchors.right: true

    height: 60
    WlrLayershell.layer: WlrLayer.Top
    exclusionMode: WlrLayershell.Exclusive
    exclusiveZone: height - 30
    color: "transparent"

    // Background strip
    Rectangle {
        anchors.top: parent.top
        width: parent.width
        height: 40
        color: Theme.bg
    }

    // --- CENTER (floating pill) ---
    Center {
        id: center
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 5
        z: 5
    }

    // --- LEFT ---
    Item {
        id: leftWrap
        anchors.left: parent.left
        anchors.leftMargin: 12
        anchors.verticalCenter: parent.top
        anchors.verticalCenterOffset: 20

        width: left.implicitWidth
        height: left.implicitHeight

        Left {
            id: left
        }
    }

    // --- RIGHT ---
    Item {
        id: rightWrap
        anchors.right: parent.right
        anchors.rightMargin: 12
        anchors.verticalCenter: parent.top
        anchors.verticalCenterOffset: 20

        width: right.implicitWidth
        height: right.implicitHeight

        Right {
            id: right
        }
    }

    // --- corner blending ---
    Canvas {
        // opacity: 0.8
        x: 10
        y: 40
        width: 20
        height: 20
        onPaint: {
            var ctx = getContext("2d");
            ctx.fillStyle = Theme.bg;
            ctx.moveTo(0, 0);
            ctx.lineTo(20, 0);
            ctx.arcTo(0, 0, 0, 20, 20);
            ctx.fill();
        }
    }

    Canvas {
        // opacity: 0.8
        x: parent.width - 30
        y: 40
        width: 20
        height: 20
        onPaint: {
            var ctx = getContext("2d");
            ctx.fillStyle = Theme.bg;
            ctx.moveTo(20, 0);
            ctx.lineTo(0, 0);
            ctx.arcTo(20, 0, 20, 20, 20);
            ctx.fill();
        }
    }
}
