import QtQuick
import QtQuick.Layouts
import "../theme"

Text {
    id: root

    Layout.alignment: Qt.AlignHCenter
    horizontalAlignment: Text.AlignHCenter
    color: Theme.fg
    text: Qt.formatDateTime(new Date(), "hh \nmm")
    font {
        pixelSize: 16
        bold: true
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: root.text = Qt.formatDateTime(new Date(), "hh \nmm")
    }
}
