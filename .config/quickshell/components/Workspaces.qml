import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import "../theme"

ColumnLayout {
    Layout.alignment: Qt.AlignHCenter
    spacing: 10

    Repeater {
        model: 5
        Rectangle {

            property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
            property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)

            implicitWidth: 15
            radius: 1 / 2 * height

            implicitHeight: isActive ? 40 : (ws ? 35 : 30)
            color: isActive ? Theme.accent : (ws ? Theme.dim : Theme.secondaryDim)
            MouseArea {
                anchors.fill: parent
                onClicked: Hyprland.dispatch("workspace " + (index + 1))
            }
        }
    }
}
