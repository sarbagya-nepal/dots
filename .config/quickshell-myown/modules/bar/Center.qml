import QtQuick
import QtQuick.Layouts
import "../../theme"

RowLayout {
    spacing: 12

    Text {
        id: clockText
        color: Theme.fg
        font.pixelSize: 13
        font.bold: true
        Layout.alignment: Qt.AlignVCenter
        text: "Fuck You, Idiot"
    }
}
