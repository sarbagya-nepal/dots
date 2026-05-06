import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import "../../../theme"

Canvas {
    property color slantColor: Theme.bg
    width: 12
    height: parent.height
    onPaint: {
        var ctx = getContext("2d");
        var w = width, h = height;
        ctx.fillStyle = slantColor;
        ctx.beginPath();
        ctx.moveTo(0, 0);
        ctx.lineTo(w, 0);
        ctx.lineTo(0, h);
        ctx.closePath();
        ctx.fill();
    }
}
