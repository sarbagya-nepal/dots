import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import "../../theme"
import "./components"

PanelWindow {
    anchors.top: true
    anchors.left: true
    anchors.right: true
    implicitHeight: 36
    color: "transparent"

    Rectangle {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 5
        color: Theme.bg
    }
    // LEFT
    Rectangle {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        width: leftModule.implicitWidth + 24
        color: Theme.bg
        Layout.alignment: Qt.AlignVCenter

        Left {
            id: leftModule
            anchors.fill: parent
            anchors.leftMargin: 12
            anchors.rightMargin: 12
        }
        RightSlant {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.right
        }
    }

    // CENTER
    Rectangle {
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: centerModule.implicitWidth + 24
        color: Theme.bg

        LeftSlant {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.right: parent.left
        }
        Center {
            id: centerModule
            anchors.fill: parent
            anchors.leftMargin: 12
            anchors.rightMargin: 12
        }
        RightSlant {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.right
        }
    }

    // RIGHT
    Rectangle {
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        width: rightModule.implicitWidth + 24
        color: Theme.bg

        Right {
            id: rightModule
            anchors.fill: parent
            anchors.leftMargin: 12
            anchors.rightMargin: 12
        }
        LeftSlant {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.right: parent.left
        }
    }
}
