import QtQuick
import Quickshell.Hyprland
import qs.theme
Row {

    spacing: bar.dynamicSpacing

    Repeater {
        model: Hyprland.workspaces.values
        Rectangle {
            id: ws
            required property int index
            required property var modelData
            property color btnColor : Colors.primary
            property color secondaryBtnColor: Colors.secondary
            property color activeBtnColor : Colors.tertiary
            width: isFocused ? 24 : 8
            height: 8

            

            readonly property bool isFocused: modelData.focused
            readonly property bool hasWindows: modelData.toplevels.values.length > 0
            color: isFocused ? activeBtnColor 
                : hasWindows? secondaryBtnColor
                    : btnColor
            

            radius: height / 2

            scale: wsArea.containsMouse && !isFocused ? 2 : 1

            Behavior on width {
                NumberAnimation {
                    duration: 150
                }
            }

            Behavior on scale {
                NumberAnimation {
                    duration: 150
                }
            }

            MouseArea {
                id: wsArea
                hoverEnabled: true
                anchors.fill: parent
                onClicked: {
                    modelData.activate();
                }
            }
        }
    }
}
