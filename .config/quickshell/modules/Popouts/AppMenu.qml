pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import "../../theme"

Loader {
    id: root

    property bool launcherVisible: false
    property var terminalCommand: detectTerminal()
    property var wallpaperMenu: null

    active: launcherVisible

    onLauncherVisibleChanged: {
        if (launcherVisible && menuWindow)
            menuWindow.slideUp.start();
    }

    property var commands: [
        {
            name: "Wallpaper",
            desc: "Open wallpaper selector",
            icon: "preferences-desktop-wallpaper",
            keywords: ["wallpaper", "wp", "bg", "background"],
            action: () => {
                if (root.wallpaperMenu)
                    root.wallpaperMenu.toggle();
            }
        },
        {
            name: "Dashboard",
            desc: "Open system dashboard",
            icon: "dashboard",
            keywords: ["dashboard", "dash", "system"],
            action: () => {
                console.log("Dashboard not implemented yet");
            }
        }
    ]

    sourceComponent: PanelWindow {
        id: menuWindow

        anchors.bottom: true

        implicitWidth: 620
        implicitHeight: 450

        WlrLayershell.layer: WlrLayer.Overlay
        WlrLayershell.exclusionMode: ExclusionMode.Ignore
        WlrLayershell.namespace: "app-menu"
        WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

        color: "transparent"

        NumberAnimation {
            id: slideDown
            target: slider
            property: "y"
            from: 0
            to: menuWindow.height
            duration: 260
            easing.type: Easing.InCubic
            onFinished: root.launcherVisible = false
        }

        Item {
            id: slider
            width: parent.width
            height: parent.height
            y: menuWindow.height

            NumberAnimation {
                id: slideUp
                target: slider
                property: "y"
                from: menuWindow.height
                to: 0
                duration: 320
                easing.type: Easing.OutCubic
                onFinished: searchInput.forceActiveFocus()
            }

            Component.onCompleted: slideUp.start()

            Rectangle {
                id: menuRect
                anchors.fill: parent
                color: Theme.bg
                radius: 14
            }

            Item {
                id: content
                anchors.fill: parent
                anchors.margins: 16

                Text {
                    id: modeIndicator
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.topMargin: -10
                    text: isCommandMode ? "command mode" : "applications"
                    color: isCommandMode ? Theme.accent : Theme.dim
                    font.pixelSize: 10
                    opacity: 0.8
                }

                ListView {
                    id: appList
                    anchors.top: modeIndicator.bottom
                    anchors.topMargin: 4
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: searchBar.top
                    anchors.bottomMargin: 10
                    clip: true
                    spacing: 2

                    property var apps: []
                    model: apps

                    currentIndex: apps.length > 0 ? 0 : -1

                    preferredHighlightBegin: 0
                    preferredHighlightEnd: height
                    highlightRangeMode: ListView.ApplyRange
                    highlightMoveDuration: 80

                    highlight: Rectangle {
                        radius: 8
                        opacity: 0.15
                        color: Theme.accent
                    }

                    delegate: Rectangle {
                        id: entryItem
                        required property var modelData
                        required property int index

                        width: appList.width
                        height: 48
                        radius: 8
                        color: mouseArea.containsMouse && !ListView.isCurrentItem ? Qt.rgba(Theme.surface.r, Theme.surface.g, Theme.surface.b, 0.5) : "transparent"

                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: 10
                            spacing: 12

                            Image {
                                source: Quickshell.iconPath(modelData.icon, true)
                                sourceSize.width: 24
                                sourceSize.height: 24
                                Layout.preferredWidth: 24
                                Layout.preferredHeight: 24
                                visible: source !== ""
                            }

                            ColumnLayout {
                                spacing: 1

                                Text {
                                    text: modelData.name
                                    color: ListView.isCurrentItem ? Theme.accent : Theme.fg
                                    font.pixelSize: 14
                                    font.bold: true
                                }

                                Text {
                                    text: modelData.desc || modelData.genericName || modelData.execString || ""
                                    color: ListView.isCurrentItem ? Theme.accent : Theme.dim
                                    font.pixelSize: 11
                                    elide: Text.ElideRight
                                    Layout.maximumWidth: 350
                                }
                            }

                            Item {
                                Layout.fillWidth: true
                            }

                            Text {
                                visible: modelData.runInTerminal || false
                                text: "⌨"
                                color: ListView.isCurrentItem ? Theme.accent : Theme.dim
                                font.pixelSize: 12
                            }
                        }

                        MouseArea {
                            id: mouseArea
                            anchors.fill: parent
                            hoverEnabled: true

                            onClicked: {
                                appList.currentIndex = index;
                                launchItem(modelData);
                            }
                        }
                    }

                    Text {
                        visible: parent.count === 0
                        anchors.centerIn: parent
                        text: isCommandMode ? "No commands found" : "No applications found"
                        color: Theme.dim
                        font.pixelSize: 14
                    }
                }

                Rectangle {
                    id: searchBar
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: 34
                    radius: 10
                    color: Theme.surface
                    border.color: searchInput.activeFocus ? Theme.accent : Theme.dim
                    border.width: searchInput.activeFocus ? 2 : 1

                    Row {
                        anchors.fill: parent
                        anchors.margins: 10
                        spacing: 8

                        Text {
                            text: isCommandMode ? "⚡" : "🔍"
                            font.pixelSize: 13
                            anchors.verticalCenter: parent.verticalCenter
                            opacity: 0.6
                            color: isCommandMode ? Theme.accent : Theme.fg
                        }

                        TextInput {
                            id: searchInput
                            width: parent.width - 28
                            height: parent.height
                            color: Theme.fg
                            font.pixelSize: 13
                            selectByMouse: true
                            verticalAlignment: TextInput.AlignVCenter

                            Text {
                                anchors.fill: parent
                                text: isCommandMode ? "Search commands..." : "Search applications..."
                                color: Theme.dim
                                font.pixelSize: 13
                                verticalAlignment: Text.AlignVCenter
                                visible: searchInput.text.length === 0
                            }

                            onTextChanged: handleInput()

                            Keys.onPressed: event => {
                                if (event.key === Qt.Key_Escape) {
                                    slideDown.start();
                                    event.accepted = true;
                                } else if (event.key === Qt.Key_Down) {
                                    if (appList.currentIndex < appList.count - 1) {
                                        appList.currentIndex++;
                                        appList.positionViewAtIndex(appList.currentIndex, ListView.Contain);
                                    }
                                    event.accepted = true;
                                } else if (event.key === Qt.Key_Up) {
                                    if (appList.currentIndex > 0) {
                                        appList.currentIndex--;
                                        appList.positionViewAtIndex(appList.currentIndex, ListView.Contain);
                                    }
                                    event.accepted = true;
                                } else if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                                    if (appList.count > 0 && appList.currentItem)
                                        launchItem(appList.currentItem.modelData);
                                    event.accepted = true;
                                }
                            }

                            Component.onCompleted: forceActiveFocus()
                        }
                    }
                }

                Text {
                    anchors.top: parent.top
                    anchors.right: parent.right
                    anchors.topMargin: -12
                    text: appList.count + (isCommandMode ? " commands" : " apps")
                    color: Theme.dim
                    font.pixelSize: 10
                    opacity: 0.7
                }
            }
        }

        MouseArea {
            anchors.fill: parent
            z: -1
            onClicked: slideDown.start()
        }

        property bool isCommandMode: false

        function handleInput() {
            const text = searchInput.text;

            // Switch to command mode with > (but don't show > in search)
            if (text === ">") {
                isCommandMode = true;
                searchInput.text = "";  // Clear the >
                filterCommands("");
                return;
            }

            // Switch to app mode with /
            if (text === "/") {
                isCommandMode = false;
                searchInput.text = "";  // Clear the /
                filterApps("");
                return;
            }

            // Normal filtering based on current mode
            const query = text.trim().toLowerCase();
            if (isCommandMode) {
                filterCommands(query);
            } else {
                filterApps(query);
            }
        }

        function filterCommands(query) {
            if (query === "") {
                appList.apps = root.commands;
                return;
            }

            appList.apps = root.commands.filter(cmd => {
                const haystack = [cmd.name, cmd.desc, ...cmd.keywords].join(" ").toLowerCase();
                return haystack.includes(query);
            });
        }

        function filterApps(query) {
            const all = [...DesktopEntries.applications.values];

            if (query === "") {
                appList.apps = all;
                return;
            }

            appList.apps = all.filter(entry => {
                return entry.name.toLowerCase().includes(query) || (entry.genericName && entry.genericName.toLowerCase().includes(query)) || (entry.comment && entry.comment.toLowerCase().includes(query)) || entry.keywords.some(k => k.toLowerCase().includes(query));
            });
        }

        function launchItem(item) {
            if (item.action) {
                item.action();
                slideDown.start();
            } else {
                launchApp(item);
            }
        }

        function launchApp(entry) {
            if (entry.runInTerminal) {
                const term = root.terminalCommand;
                const cmd = buildTerminalCommand(term, entry.command);
                Quickshell.execDetached({
                    command: cmd
                });
            } else {
                entry.execute();
            }
            slideDown.start();
        }

        function buildTerminalCommand(termCmd, appCmd) {
            const term = termCmd[0];

            switch (term) {
            case "alacritty":
            case "ghostty":
                return [...termCmd, "-e", ...appCmd];
            case "gnome-terminal":
            case "kgx":
                return [...termCmd, "--", ...appCmd];
            case "xfce4-terminal":
                return [...termCmd, "-e", appCmd.join(" ")];
            case "konsole":
                return [...termCmd, "-e", ...appCmd];
            case "wezterm":
                return [...termCmd, "start", "--", ...appCmd];
            case "foot":
                return [...termCmd, ...appCmd];
            case "xterm":
            case "urxvt":
            case "rxvt":
                return [...termCmd, "-e", ...appCmd];
            case "kitty":
            default:
                return [...termCmd, "--", ...appCmd];
            }
        }

        Component.onCompleted: {
            isCommandMode = false;
            filterApps("");
        }
    }

    function detectTerminal() {
        const envTerm = Quickshell.env("TERMINAL");
        if (envTerm) {
            return envTerm.split(/\s+/);
        }
        return ["ghostty"];
    }

    function open() {
        launcherVisible = true;
    }
    function toggle() {
        launcherVisible = !launcherVisible;
    }
    function close() {
        launcherVisible = false;
    }
}
