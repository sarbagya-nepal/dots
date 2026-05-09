// modules/bars/Right.qml
import QtQuick
import QtQuick.Layouts
import "../../theme"

RowLayout {
    spacing: 12
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
    Text {
        id: dayText
        color: Theme.dim
        font.pixelSize: 12
        font.bold: true
        Layout.alignment: Qt.AlignVCenter

        Timer {
            interval: 3600000
            running: true
            repeat: true
            triggeredOnStart: true
            onTriggered: dayText.text = Qt.formatDateTime(new Date(), "ddd")
        }
    }
}
