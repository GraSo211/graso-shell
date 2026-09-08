import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs.theme

Row {
    anchors.fill: parent
    spacing: 10
    anchors.leftMargin: 10

    Wlogout {}

    Text {
        anchors.verticalCenter: parent.verticalCenter
        width: parent.width - 45

        text: Hyprland.activeToplevel.title ? Hyprland.activeToplevel.title : "Desconocido"

        color: "white"
        font.family: shellRoot.mainFont
        font.pixelSize: 10
        font.weight: Font.DemiBold

        elide: Text.ElideRight
    }
}
