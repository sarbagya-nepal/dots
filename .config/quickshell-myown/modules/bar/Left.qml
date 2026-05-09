import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland

import "../../theme"

RowLayout {
    id: workspace
    spacing: 5
    Repeater {
        model: 9

        Rectangle {
            property bool active: Hyprland.focusedWorkspace?.id === index + 1
            property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)

            color: active ? Theme.accent : ws ? Theme.dim : Theme.secondary
            implicitHeight: 8
            implicitWidth: active ? 20 : ws ? 10 : 8
            radius: height / 2

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    Hyprland.dispatch("workspace " + (index + 1));
                }
            }
        }
    }
}
