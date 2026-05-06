import QtQuick
import Quickshell
import "bars"
import "modules"

ShellRoot {
    Variants {
        model: Quickshell.screens

        Item {
            required property var modelData
            property var scr: modelData

            Frame {
                screen: parent.scr
            }

            Bars {
                screen: parent.scr
            }
        }
    }
}
