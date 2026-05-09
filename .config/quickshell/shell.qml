// shell.qml
import QtQuick
import Quickshell
import "modules/Bars"
import "modules/Wallpaper"
import "modules/Frame"
import "modules/Popouts"
import "theme"

ShellRoot {
    id: root

    QtObject {
        id: wallpaperController
        signal wallpaperSelected(string path)
    }

    Wallpaper {}
    Bars {}
    Frame {}

    WallpaperMenu {
        id: wallpaperMenu
        wallpaperDir: "/home/chain/Pictures/wallpapers"
        onSelected: path => wallpaperController.wallpaperSelected(path)
    }

    AppMenu {
        id: appLauncher
        launcherVisible: false
        wallpaperMenu: wallpaperMenu
    }
}
