import QtQuick
import qs.theme

Row {
    id: root

    property string icon: ""
    property string value: ""

    // Texto usado únicamente para reservar ancho
    property string reserveText: "100"

    property color accent: Colors.primary

    property int iconSize: 14
    property int valueSize: 11
    property int metricSpacing: 2

    spacing: root.metricSpacing

    Text {
        anchors.verticalCenter: parent.verticalCenter

        text: root.icon
        color: root.accent

        font {
            family: "JetBrainsMono Nerd Font"
            pixelSize: root.iconSize
        }
    }

    TextMetrics {
        id: valueMetrics

        font: valueText.font
        text: root.reserveText
    }

    Text {
        id: valueText

        anchors.verticalCenter: parent.verticalCenter

        width: valueMetrics.advanceWidth

        text: root.value
        color: Colors.on_surface

        horizontalAlignment: Text.AlignRight

        font {
            family: shellRoot.mainFont
            pixelSize: root.valueSize
            bold: true
        }
    }
}