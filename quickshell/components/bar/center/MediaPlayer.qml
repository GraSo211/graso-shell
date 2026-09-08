import QtQuick
import QtQuick.Effects
import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.Mpris
import qs.theme

Item {
    id: root

    readonly property var player: {
        const players = Mpris.players.values;

        if (players.length === 0)
            return null;

        const playing = players.find(p => p.isPlaying);

        if (playing)
            return playing;

        const playerWithTrack = players.find(p => p.trackTitle);

        return playerWithTrack ?? null;
    }

    Behavior on width {
        NumberAnimation {
            duration: 350
            easing.type: Easing.OutCubic
        }
    }

    property bool noPlayerHovered: false

    readonly property real playerWidth: bar.layoutMode == 2 ? 220 : bar.layoutMode == 1 ? 190 : 130

    readonly property real collapsedWidth: 35

    width: player ? playerWidth : noPlayerHovered ? playerWidth : collapsedWidth

    height: Config.heightBar - 5

    Loader {
        anchors.fill: parent

        sourceComponent: root.player ? playerComponent : emptyComponent
    }

    // ─────────────────────────────
    // PLAYER
    // ─────────────────────────────

    Component {
        id: playerComponent

        Rectangle {
            radius: 18
            color: "transparent"

            Image {
                id: albumArt
                anchors.fill: parent

                source: root.player?.trackArtUrl ?? ""
                fillMode: Image.PreserveAspectCrop

                layer.enabled: true
                layer.effect: MultiEffect {
                    maskEnabled: true
                    maskSource: mask
                }
            }

            Rectangle {
                id: mask

                anchors.fill: parent
                radius: parent.radius

                visible: false
                layer.enabled: true
            }

            // Overlay oscuro
            Rectangle {
                anchors.fill: parent
                radius: parent.radius
                color: "#66000000"
            }

            Row {
                anchors {
                    fill: parent
                    leftMargin: 12
                    rightMargin: 12
                }

                spacing: 8

                Text {
                    anchors.verticalCenter: parent.verticalCenter

                    width: bar.layoutMode == 2 ? 170 : bar.layoutMode == 1 ? 140 : 90

                    text: root.player?.trackTitle ?? ""

                    color: "white"
                    elide: Text.ElideRight
                    font.bold: true
                }

                Text {
                    anchors.verticalCenter: parent.verticalCenter

                    text: root.player?.isPlaying ? "󰏤" : "󰐊"

                    color: "white"

                    scale: playArea.containsMouse ? 1.4 : 1

                    Behavior on scale {
                        NumberAnimation {
                            duration: 100
                        }
                    }

                    MouseArea {
                        id: playArea

                        anchors.fill: parent
                        hoverEnabled: true

                        onClicked: {
                            if (root.player?.canTogglePlaying)
                                root.player.togglePlaying();
                        }
                    }
                }
            }
        }
    }

    // ─────────────────────────────
    // SIN PLAYER
    // ─────────────────────────────

    Component {
        id: emptyComponent

        Rectangle {
            id: noPlayer

            anchors.fill: parent

            radius: height / 2

            color: playArea.containsMouse ? Colors.surface : Colors.background

            border.width: 1
            border.color: playArea.containsMouse ? Colors.secondary : Colors.background

            clip: true

            Behavior on color {
                ColorAnimation {
                    duration: 150
                }
            }

            Row {
                anchors {
                    fill: parent
                    leftMargin: 4
                    rightMargin: 10
                }

                spacing: 7

                Item {
                    width: 28
                    height: parent.height

                    Image {
                        id: vinilo

                        anchors.centerIn: parent

                        width: 50
                        height: width

                        source: "/home/graso/.config/quickshell/assets/vinilo.png"
                        fillMode: Image.PreserveAspectFit

                        rotation: root.noPlayerHovered ? 360 : 0

                        Behavior on rotation {
                            NumberAnimation {
                                duration: 500
                                easing.type: Easing.OutCubic
                            }
                        }
                    }
                }

                Text {
                    anchors.verticalCenter: parent.verticalCenter

                    text: "YouTube Music"

                    color: Colors.primary

                    font {
                        pixelSize: 11
                        bold: true
                    }

                    opacity: root.noPlayerHovered ? 1 : 0

                    Behavior on opacity {
                        NumberAnimation {
                            duration: 180
                        }
                    }
                }

                Text {
                    anchors.verticalCenter: parent.verticalCenter

                    text: "›"
                    color: Colors.primary

                    font.pixelSize: 17

                    opacity: root.noPlayerHovered ? 1 : 0

                    Behavior on opacity {
                        NumberAnimation {
                            duration: 180
                        }
                    }
                }
            }

            MouseArea {
                id: playArea

                anchors.fill: parent
                hoverEnabled: true

                cursorShape: Qt.PointingHandCursor

                onContainsMouseChanged: root.noPlayerHovered = containsMouse

                onClicked: {
                    Quickshell.execDetached(["zen-browser", "https://music.youtube.com"]);
                }
            }
        }
    }
}
