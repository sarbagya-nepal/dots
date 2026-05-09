// modules/bars/Right.qml
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import "../../theme"

RowLayout {
    spacing: 12

    // ── VOLUME ──
    RowLayout {
        spacing: 6
        Layout.alignment: Qt.AlignVCenter

        Text {
            id: volIcon
            text: "󰕾"
            color: Theme.accent
            font.pixelSize: 20
            Layout.alignment: Qt.AlignVCenter

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    volToggle.running = true;
                    volGetter.running = true;
                }
                onWheel: wheel => {
                    let delta = wheel.angleDelta.y > 0 ? 0.05 : -0.05;
                    let newValue = Math.max(0, Math.min(1, volSlider.value + delta));
                    volSlider.value = newValue;
                    volSetter.command = ["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", newValue.toFixed(2)];
                    volSetter.running = true;
                    volGetter.running = true;
                }
            }
        }

        Rectangle {
            width: 60
            height: 4
            radius: 2
            color: Theme.secondary
            Layout.alignment: Qt.AlignVCenter

            Rectangle {
                width: parent.width * volSlider.value
                height: parent.height
                radius: 2
                color: Theme.accent
            }

            MouseArea {
                anchors.fill: parent
                onPressed: update(mouse)
                onPositionChanged: update(mouse)
                onWheel: wheel => {
                    let delta = wheel.angleDelta.y > 0 ? 0.05 : -0.05;
                    let newValue = Math.max(0, Math.min(1, volSlider.value + delta));
                    volSlider.value = newValue;
                    volSetter.command = ["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", newValue.toFixed(2)];
                    volSetter.running = true;
                    volGetter.running = true;
                }
                function update(mouse) {
                    let p = Math.max(0, Math.min(1, mouse.x / width));
                    volSlider.value = p;
                    volSetter.command = ["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", p.toFixed(2)];
                    volSetter.running = true;
                }
            }
        }
    }

    // ── DAY ──
    Text {
        id: dayText
        color: Theme.fg
        font.pixelSize: 13
        font.bold: true
        Layout.alignment: Qt.AlignVCenter

        Timer {
            interval: 3600000
            running: true
            repeat: true
            triggeredOnStart: true
            onTriggered: dayText.text = Qt.formatDateTime(new Date(), "dddd")
        }
    }

    // ── CLOCK ──
    Text {
        id: clockText
        color: Theme.fg
        font.pixelSize: 13
        font.bold: true
        Layout.alignment: Qt.AlignVCenter

        Timer {
            interval: 1000
            running: true
            repeat: true
            triggeredOnStart: true
            onTriggered: clockText.text = Qt.formatTime(new Date(), "HH:mm")
        }
    }

    // ── POWER ──
    Text {
        id: powerMenu
        Layout.alignment: Qt.AlignVCenter
        text: "⏻"
        color: Theme.colError
        font.pixelSize: 16
    }

    // ── PROCESSES ──
    QtObject {
        id: volSlider
        property real value: 0.5
    }

    Process {
        id: volGetter
        running: true
        command: ["bash", "-c", "wpctl get-volume @DEFAULT_AUDIO_SINK@"]
        stdout: SplitParser {
            onRead: data => {
                let output = data.trim();
                let match = output.match(/[0-9.]+/);
                if (match)
                    volSlider.value = parseFloat(match[0]);
                volIcon.text = output.includes("[MUTED]") ? "󰖁" : (volSlider.value == 0.0 ? "󰖁" : "󰕾");
                volIcon.color = output.includes("[MUTED]") ? Theme.colError : (volSlider.value == 0.0 ? Theme.colError : Theme.accent);
            }
        }
    }

    Process {
        id: volSetter
        command: []
    }

    Process {
        id: volToggle
        command: ["bash", "-c", "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"]
    }

    Timer {
        interval: 100
        running: true
        repeat: true
        onTriggered: volGetter.running = true
    }
}
