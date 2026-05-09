import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import "../../theme/"

PanelWindow {
    id: root
    property string configPath: Quickshell.shellDir + "/wallpaper.json"
    property string wallpaperPath: ""

    WlrLayershell.layer: WlrLayer.Background
    WlrLayershell.exclusionMode: ExclusionMode.Ignore
    WlrLayershell.namespace: "wallpaper"
    color: Theme.surface

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }

    // Bottom layer — current wallpaper, plays if animated
    AnimatedImage {
        id: imgBack
        anchors.fill: parent
        fillMode: AnimatedImage.PreserveAspectCrop
        asynchronous: true
        playing: true
    }

    // Top layer — incoming wallpaper, fades in once loaded
    AnimatedImage {
        id: imgFront
        anchors.fill: parent
        fillMode: AnimatedImage.PreserveAspectCrop
        asynchronous: true
        opacity: 0
        playing: true

        onStatusChanged: {
            if (status === AnimatedImage.Ready) {
                fadeIn.restart()
            }
        }

        NumberAnimation {
            id: fadeIn
            target: imgFront
            property: "opacity"
            from: 0
            to: 1
            duration: 800
            easing.type: Easing.InOutQuad

            onFinished: {
                imgBack.source = imgFront.source
                imgFront.opacity = 0
                imgFront.source = ""
            }
        }
    }

    function setWallpaper(path) {
        if (path === imgBack.source) return
        imgFront.source = path
    }

    Component.onCompleted: loadWallpaper()

    Connections {
        target: wallpaperController
        function onWallpaperSelected(path) {
            root.wallpaperPath = path
            setWallpaper(path)
            saveWallpaper(path)
        }
    }

    function loadWallpaper() {
        fileReader.command = ["bash", "-c", "cat " + configPath + " 2>/dev/null || echo '{}'"]
        fileReader.running = true
    }

    function saveWallpaper(path) {
        fileWriter.command = ["bash", "-c", "mkdir -p " + Quickshell.shellDir + " && echo '{\"path\":\"" + path + "\"}' > " + configPath]
        fileWriter.running = true
    }

    Process {
        id: fileReader
        command: []
        stdout: SplitParser {
            onRead: data => {
                try {
                    let json = JSON.parse(data.trim())
                    if (json.path) {
                        imgBack.source = json.path
                        root.wallpaperPath = json.path
                        return
                    }
                } catch (e) {
                    console.log("No saved wallpaper or bad JSON")
                }
                imgBack.source = "/home/chain/Pictures/wallpapers/dream.png"
                root.wallpaperPath = imgBack.source
            }
        }
    }

    Process {
        id: fileWriter
        command: []
    }
}

