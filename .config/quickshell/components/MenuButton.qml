import QtQuick
import QtQuick.Layouts
import "../theme"

Text {
    id: root
    signal clicked

    Layout.alignment: Qt.AlignHCenter
    text: ""
    color: Theme.accent
    font {
        pixelSize: 25
    }
}
