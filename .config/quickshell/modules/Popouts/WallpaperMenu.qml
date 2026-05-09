import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import "../../theme"

Loader {
    id: root

    property string wallpaperDir: "/home/chain/Pictures/wallpapers"
    property var onSelected: null
    property string configPath: Quickshell.stateDir + "/wallpaper.json"

    active: false

    sourceComponent: PanelWindow {
        id: menuWindow

        anchors.bottom: true

        implicitWidth: 900
        implicitHeight: 460

        WlrLayershell.layer: WlrLayer.Overlay
        WlrLayershell.exclusionMode: ExclusionMode.Ignore
        WlrLayershell.namespace: "wallpaper-menu"
        WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

        color: "transparent"

        Item {
            id: slider
            width: parent.width
            height: parent.height
            y: parent.height

            NumberAnimation {
                id: slideUp
                target: slider
                property: "y"
                from: menuWindow.height
                to: 0
                duration: 320
                easing.type: Easing.OutCubic
            }

            NumberAnimation {
                id: slideDown
                target: slider
                property: "y"
                from: 0
                to: menuWindow.height
                duration: 260
                easing.type: Easing.InCubic
                onFinished: root.active = false
            }

            Component.onCompleted: slideUp.start()

            // Main panel — rounded top corners, flat bottom
            Rectangle {
                id: menuRect
                anchors.fill: parent
                color: Theme.bg
            }

            // Content sits on top of everything
            Item {
                id: content
                anchors.fill: parent
                focus: true

                Text {
                    id: titleText
                    anchors.top: parent.top
                    anchors.topMargin: 14
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Select Wallpaper"
                    color: Theme.fg
                    font.pixelSize: 14
                    font.bold: true
                }

                Text {
                    id: counter
                    anchors.top: titleText.bottom
                    anchors.topMargin: 4
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: filteredModel.count > 0 ? (coverflow.currentIndex + 1) + " / " + filteredModel.count : "No wallpapers"
                    color: Theme.dim
                    font.pixelSize: 12
                    opacity: 0.8
                }

                Item {
                    id: coverflow
                    anchors.top: counter.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: searchBar.top
                    anchors.topMargin: 10
                    anchors.leftMargin: 16
                    anchors.rightMargin: 16
                    anchors.bottomMargin: 12

                    property int currentIndex: 0
                    property int count: filteredModel.count
                    property real itemWidth: 480
                    property real itemHeight: 280
                    property real peekOffset: 60
                    property real centerX: width / 2

                    MouseArea {
                        anchors.fill: parent
                        onWheel: wheel => {
                            if (wheel.angleDelta.y > 0)
                                coverflow.goLeft();
                            else
                                coverflow.goRight();
                        }
                    }

                    function goLeft() {
                        if (count === 0)
                            return;
                        currentIndex = (currentIndex - 1 + count) % count;
                    }

                    function goRight() {
                        if (count === 0)
                            return;
                        currentIndex = (currentIndex + 1) % count;
                    }

                    Repeater {
                        model: filteredModel

                        delegate: Item {
                            id: card

                            property int distance: {
                                let d = index - coverflow.currentIndex;
                                let c = coverflow.count;
                                if (c === 0)
                                    return 0;
                                if (d > c / 2)
                                    d -= c;
                                if (d < -c / 2)
                                    d += c;
                                return d;
                            }
                            property bool isCurrent: index === coverflow.currentIndex

                            x: coverflow.centerX - coverflow.itemWidth / 2 + (distance * (coverflow.itemWidth - coverflow.peekOffset))
                            y: coverflow.height / 2 - coverflow.itemHeight / 2

                            scale: isCurrent ? 1.0 : 0.85
                            opacity: Math.abs(distance) > 1 ? 0 : (isCurrent ? 1.0 : 0.6)

                            width: coverflow.itemWidth
                            height: coverflow.itemHeight
                            z: isCurrent ? 100 : -Math.abs(distance)

                            Behavior on x {
                                NumberAnimation {
                                    duration: 300
                                    easing.type: Easing.OutCubic
                                }
                            }
                            Behavior on scale {
                                NumberAnimation {
                                    duration: 300
                                    easing.type: Easing.OutCubic
                                }
                            }
                            Behavior on opacity {
                                NumberAnimation {
                                    duration: 200
                                }
                            }

                            Rectangle {
                                anchors.fill: parent
                                color: Theme.surface

                                Image {
                                    anchors.fill: parent
                                    source: model.path
                                    fillMode: Image.PreserveAspectCrop
                                    asynchronous: true

                                    opacity: status === Image.Ready ? 1 : 0
                                    Behavior on opacity {
                                        NumberAnimation {
                                            duration: 200
                                        }
                                    }
                                }
                            }

                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    if (isCurrent)
                                        selectWallpaper(model.path);
                                    else
                                        coverflow.currentIndex = index;
                                }
                            }
                        }
                    }
                }

                Rectangle {
                    id: searchBar
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.margins: 16
                    anchors.bottomMargin: 18
                    height: 34
                    radius: 10
                    color: Theme.surface
                    border.color: Theme.dim
                    border.width: 1

                    Row {
                        anchors.fill: parent
                        anchors.margins: 10
                        spacing: 8

                        Text {
                            text: "🔍"
                            font.pixelSize: 13
                            anchors.verticalCenter: parent.verticalCenter
                            opacity: 0.6
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
                                text: "Search wallpapers..."
                                color: Theme.dim
                                font.pixelSize: 13
                                verticalAlignment: Text.AlignVCenter
                                visible: searchInput.text.length === 0
                            }

                            onTextChanged: filterModel()

                            Keys.onPressed: event => {
                                if (event.key === Qt.Key_Escape) {
                                    slideDown.start();
                                    event.accepted = true;
                                } else if (event.key === Qt.Key_Left) {
                                    coverflow.goLeft();
                                    event.accepted = true;
                                } else if (event.key === Qt.Key_Right) {
                                    coverflow.goRight();
                                    event.accepted = true;
                                } else if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                                    if (filteredModel.count > 0)
                                        selectWallpaper(filteredModel.get(coverflow.currentIndex).path);
                                    event.accepted = true;
                                }
                            }

                            Component.onCompleted: forceActiveFocus()
                        }
                    }
                }

                Keys.onLeftPressed: coverflow.goLeft()
                Keys.onRightPressed: coverflow.goRight()
                Keys.onReturnPressed: {
                    if (filteredModel.count > 0)
                        selectWallpaper(filteredModel.get(coverflow.currentIndex).path);
                }
                Keys.onEscapePressed: slideDown.start()
            }
        }

        ListModel {
            id: wallpaperModel
        }
        ListModel {
            id: filteredModel
        }

        function scanDir() {
            wallpaperModel.clear();
            filteredModel.clear();
            dirScanner.command = ["find", root.wallpaperDir, "-maxdepth", "1", "-type", "f", "(", "-iname", "*.png", "-o", "-iname", "*.jpg", "-o", "-iname", "*.jpeg", ")"];
            dirScanner.running = true;
        }

        function filterModel() {
            let previousPath = null;
            if (filteredModel.count > 0 && coverflow.currentIndex >= 0 && coverflow.currentIndex < filteredModel.count)
                previousPath = filteredModel.get(coverflow.currentIndex).path;

            filteredModel.clear();
            let term = searchInput.text.toLowerCase();

            for (let i = 0; i < wallpaperModel.count; i++) {
                let item = wallpaperModel.get(i);
                let name = item.path.split("/").pop().toLowerCase();
                if (term.length === 0 || name.includes(term))
                    filteredModel.append(item);
            }

            if (previousPath) {
                for (let i = 0; i < filteredModel.count; i++) {
                    if (filteredModel.get(i).path === previousPath) {
                        coverflow.currentIndex = i;
                        return;
                    }
                }
            }

            coverflow.currentIndex = 0;
        }

        function loadState() {
            fileReader.command = ["bash", "-c", "cat '" + root.configPath + "' 2>/dev/null || echo '{}'"];

            fileReader.running = true;
        }

        function saveState(path) {
            let json = JSON.stringify({
                path: path,
                lastPath: path
            });

            let escaped = json.replace(/'/g, "'\\''");

            let cmd = `
        mkdir -p "$(dirname '${root.configPath}')"
        echo '${escaped}' > '${root.configPath}'
    `;

            fileWriter.command = ["bash", "-c", cmd];
            fileWriter.running = true;
        }

        function selectWallpaper(path) {
            if (root.onSelected)
                root.onSelected(path);
            saveState(path);
            slideDown.start();
        }

        Process {
            id: dirScanner
            command: []
            stdout: SplitParser {
                onRead: data => {
                    let lines = data.trim().split("\n");
                    for (let i = 0; i < lines.length; i++) {
                        let path = lines[i].trim();
                        if (path)
                            wallpaperModel.append({
                                path: path
                            });
                    }
                    filterModel();
                    loadState();
                }
            }
        }

        Process {
            id: fileReader
            command: []
            stdout: SplitParser {
                onRead: data => {
                    try {
                        let text = data.trim();
                        if (!text || text === "{}") {
                            coverflow.currentIndex = Math.floor(filteredModel.count / 2);
                            return;
                        }

                        let json;
                        json = JSON.parse(text);

                        let savedPath = json.lastPath || json.path;
                        if (savedPath) {
                            for (let i = 0; i < filteredModel.count; i++) {
                                if (filteredModel.get(i).path === savedPath) {
                                    coverflow.currentIndex = i;
                                    return;
                                }
                            }
                        }
                    } catch (e) {
                        console.log("Failed to load state:", e);
                    }

                    coverflow.currentIndex = Math.floor(filteredModel.count / 2);
                }
            }
        }

        Process {
            id: fileWriter
            command: []
        }

        Component.onCompleted: scanDir()
    }

    function open() {
        active = true;
    }
    function toggle() {
        active = !active;
    }
    function close() {
        active = false;
    }
}
