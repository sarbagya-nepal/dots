// modules/bars/Left.qml
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import "../../theme"

RowLayout {
    spacing: 10

    Text {
        id: launcher
        text: ""
        color: Theme.accent
        font.pixelSize: 18
    MouseArea {
        anchors.fill: parent
        onClicked: appLauncher.toggle()
        cursorShape: Qt.PointingHandCursor
    }
    }

    Row {
        id: wsRow
        spacing: 5

        Repeater {
            model: 9

            Rectangle {
                property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
                property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)

                width: isActive ? 20 : 8
                height: 8
                radius: height / 2

                color: isActive
                    ? Theme.accent
                    : (ws ? Theme.dim : Theme.secondary)

                Behavior on width {
                    NumberAnimation {
                        duration: 160
                        easing.type: Easing.OutCubic
                    }
                }

                Behavior on color {
                    ColorAnimation { duration: 120 }
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: parent.opacity = 0.8
                    onExited: parent.opacity = 1.0
                    onClicked: Hyprland.dispatch("workspace " + (index + 1))
                }
            }
        }
    }
}
