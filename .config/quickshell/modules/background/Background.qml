import Quickshell
import QtQuick
import Quickshell.Wayland

PanelWindow {
    id: root
    anchors.top: true
    anchors.bottom: true
    anchors.left: true
    anchors.right: true

    WlrLayershell.layer: WlrLayer.Background
    color: "transparent"

    Image {
        anchors.fill: parent
        source: "file:///home/chain/Pictures/wallpapers/gifs/anime-girl-sword-blue-eyes-live-wallpaper-wallsflow-com.gif"
        fillMode: Image.PreserveAspectCrop
    }
}
