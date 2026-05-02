import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Wayland
import "../../components" as Components
import "../../theme"

PanelWindow {
    id: root
    anchors.left: true
    anchors.top: true
    anchors.bottom: true

    WlrLayershell.layer: WlrLayer.Top
    implicitWidth: 40
    color: Theme.bg

    signal menuClicked

    ColumnLayout {
        anchors.fill: parent
        anchors.topMargin: 10
        anchors.bottomMargin: 10
        spacing: 15

        Components.MenuButton {}

        Components.Workspaces {}

        Item {
            Layout.fillHeight: true
        }

        Components.Clock {}
    }
}
