import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import "../theme"

RowLayout {
    spacing: 10

    Text {
        text: ""
        color: Theme.accent
        font.pixelSize: 20
        Layout.alignment: Qt.AlignVCenter
    }

    Rectangle {
        height: 32
        width: wsRow.implicitWidth + 30
        radius: height / 2
        color: Theme.surface
        Layout.alignment: Qt.AlignVCenter

        Row {
            id: wsRow
            anchors.centerIn: parent
            spacing: 8

            Repeater {
                model: 5

                Rectangle {
                    property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
                    property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)

                    width: isActive ? 30 : (ws ? 18 : 12)
                    height: 8
                    radius: height / 2

                    color: isActive
                        ? Theme.accent
                        : (ws ? Theme.dim : Theme.secondary)

                    anchors.verticalCenter: parent.verticalCenter

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
                        onClicked: Hyprland.dispatch("workspace", index + 1)
                    }
                }
            }
        }
    }
}
