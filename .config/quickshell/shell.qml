import Quickshell
import QtQuick
import "modules/background" as BackgroundModule
import "modules/bar" as BarModule

ShellRoot {
    BackgroundModule.Background {
        id: background
    }

    BarModule.Bar {
        onMenuClicked: launcher.visible = !launcher.visible
    }
}
