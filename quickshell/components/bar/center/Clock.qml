import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.theme

Item {
    id: clockRoot
    property bool hovered: clockMouseArea.containsMouse

    implicitWidth: clockRow.implicitWidth
    implicitHeight: clockRow.implicitHeight

    property int clockSize: {
        if (bar.layoutMode == 2)
            return Config.sizeClockWide;
        else if (bar.layoutMode == 1)
            return Config.sizeClockCompact;
        else
            return Config.sizeClockNarrow;
        {}
    }

    RowLayout {
        id: clockRow

        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

        spacing: 0

        Text {
            text: Time.getDigit(Time.hour, 0)
            color: Colors.primary
            font.family: Config.clockFontFamily
            font.pixelSize: clockSize
        }

        Text {
            text: Time.getDigit(Time.hour, 1)
            color: Colors.secondary
            font.family: Config.clockFontFamily
            font.pixelSize: clockSize
        }

        Text {
            text: ":"
            color: Colors.tertiary
            font.family: Config.clockFontFamily
            font.pixelSize: clockSize
        }

        Text {
            text: Time.getDigit(Time.minute, 0)
            color: Colors.primary
            font.family: Config.clockFontFamily
            font.pixelSize: clockSize
        }

        Text {
            text: Time.getDigit(Time.minute, 1)
            color: Colors.secondary
            font.family: Config.clockFontFamily
            font.pixelSize: clockSize
        }
    }
    

    MouseArea {
        id: clockMouseArea
        anchors.fill: clockRow

        hoverEnabled: true
        
    }
}
