import Quickshell 
import Quickshell.Wayland 
import Quickshell.Hyprland 
import QtQuick 
import QtQuick.Layouts

PanelWindow {
  anchors.left: true
  anchors.top: true
  anchors.bottom: true

  implicitWidth: 50
  color: "#090e13"

  ColumnLayout {
    anchors.fill: parent
    anchors.margins: 8
    spacing: 10

    // ───── WORKSPACES ─────
    ColumnLayout {
      spacing: 8
      Layout.alignment: Qt.AlignHCenter

      Repeater {
        model: 5

        Rectangle {
          property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
          property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)

          radius: height / 2

          implicitWidth: 20
          implicitHeight: isActive ? 45 : (ws ? 35 : 30)

          color: isActive ? "#7fb4ca" : ws ? "#2e3440" : "#1b1f27"

          Behavior on implicitHeight { NumberAnimation { duration: 150 } }
          Behavior on color { ColorAnimation { duration: 150 } }

          MouseArea {
            anchors.fill: parent
            onClicked: Hyprland.dispatch("workspace " + (index + 1))
          }
        }
      }
    }

    // ───── SPACER ─────
    Item { Layout.fillHeight: true }

    // ───── CLOCK AT BOTTOM ─────
    Text {
      id: clock
      text: Qt.formatDateTime(new Date(), "hh \nmm")
      color: "#c5c9c7"
      font.bold: false
      font.pixelSize: 18
      font.letterSpacing: 3
      Layout.alignment: Qt.AlignHCenter

      Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: clock.text = Qt.formatDateTime(new Date(), "hh \nmm")
      }
    }
  }
}
