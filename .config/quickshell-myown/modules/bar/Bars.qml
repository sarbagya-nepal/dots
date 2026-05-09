import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import "../../theme"
import "../components"

PanelWindow {
    id: bar
    anchors.left: true
    anchors.right: true
    anchors.top: true
    implicitHeight: 36
    color: "transparent"

    Rectangle {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        implicitHeight: 10
        color: Theme.bg
    }

    // Left Module
    Rectangle {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        color: Theme.bg
        implicitWidth: leftSide.implicitWidth + 24

        Left {
            id: leftSide
            anchors.fill: parent
            anchors.leftMargin: 10
            anchors.rightMargin: 10
        }
        RightSlant {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.right
        }
    }

    // Center Module
    Rectangle {
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        implicitWidth: centerModule.implicitWidth + 24
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
    // Right Module
    Rectangle {
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        implicitWidth: rightSide.implicitWidth + 24
        color: Theme.bg

        Right {
            id: rightSide
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
