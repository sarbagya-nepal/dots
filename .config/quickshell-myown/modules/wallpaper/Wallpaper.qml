import QtQuick
import Quickshell
import Quickshell.Wayland
import "../../theme/"

PanelWindow {
    id: root
    property string wallpaperPath: "/home/chain/Pictures/wallpapers/aurora_borealis.png"

    WlrLayershell.layer: WlrLayer.Background
    WlrLayershell.exclusionMode: ExclusionMode.Ignore
    WlrLayershell.namespace: "wallpaper"
    color: Theme.bg

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }

    Image {
        anchors.fill: parent
        source: root.wallpaperPath
        fillMode: Image.PreserveAspectCrop
        asynchronous: true
    }
}
