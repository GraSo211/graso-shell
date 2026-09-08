import QtQuick
import Quickshell
import QtQuick.Layouts
import qs.shapes
import qs.theme
import qs.components.bar.left
import qs.components.bar.center
import qs.components.bar.right

PanelWindow {
    id: bar

    required property var modelData
    implicitHeight: Config.heightBar
    readonly property int layoutMode: Config.layoutMode(modelData.width)

    readonly property real sideWidthBar: Config.sideWidthBar(modelData.width)

    readonly property real centerWidthBar: Config.centerWidthBar(modelData.width)

    readonly property real dynamicSpacing: if (Config.layoutMode(modelData.width) == 0) {
        return 3;
    } else if (layoutMode == 1) {
        return 5;
    } else {
        return 8;
    }

    screen: modelData

    anchors {
        top: true
        left: true
        right: true
    }

    color: "transparent"
    TopBarShape {

        leftWidth: bar.sideWidthBar
        centerWidth: bar.centerWidthBar
        rightWidth: bar.sideWidthBar
    }

    Rectangle {
        id: topRect
        height: parent.height

        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }

        color: 'transparent'

        // IZQUIERDA
        LeftBar {
            width: bar.sideWidthBar
        }

        // CENTRO
        CenterBar {
            width: bar.centerWidthBar
        }

        // DERECHA
        RightBar {
            width: bar.sideWidthBar
        }
    }
}
