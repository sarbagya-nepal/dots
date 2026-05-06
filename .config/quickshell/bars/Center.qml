import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Mpris
import "../theme"

Rectangle {
    id: root

    height: 30
    width: content.implicitWidth + 30
    radius: height / 2
    color: Theme.surface

    property MprisPlayer player: {
        for (const p of Mpris.players.values) {
            if (p.playbackState === MprisPlaybackState.Playing)
                return p;
        }
        return Mpris.players.values.length > 0 ? Mpris.players.values[0] : null;
    }

    property bool hasPlayer: player !== null
    property string songTitle: hasPlayer ? (player.trackTitle || "Unknown Title") : "No Media"

    opacity: hasPlayer ? 1 : 0.35
    Behavior on opacity {
        NumberAnimation {
            duration: 300
            easing.type: Easing.InOutQuad
        }
    }

    RowLayout {
        id: content
        spacing: 10
        anchors {
            left: parent.left
            leftMargin: 12
            right: parent.right
            rightMargin: 12
            verticalCenter: parent.verticalCenter
        }

        Text {
            text: "󰎆"
            font.pixelSize: 16
            font.weight: Font.DemiBold
            color: Theme.accent
        }

        Text {
            text: root.songTitle
            color: Theme.fg
            font.pixelSize: 13
            font.weight: Font.Medium
            elide: Text.ElideRight
            Layout.maximumWidth: 220
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: console.log("Media clicked")
    }
}
