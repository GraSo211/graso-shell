import QtQuick
import QtQuick.Layouts
import qs.theme

RowLayout {
    id: root

    readonly property bool wide: bar.layoutMode === 2

    readonly property int capsuleHeight: wide ? 32 : 27
    readonly property int capsulePadding: wide ? 14 : 10

    readonly property int capsuleSpacing: wide ? 7 : 4
    readonly property int metricSpacing: wide ? 4 : 2

    readonly property int valueSize: wide ? 12 : 11
    readonly property int defaultIconSize: wide ? 16 : 14

    spacing: wide ? 6 : 3

    anchors {
        right: parent.right
        verticalCenter: parent.verticalCenter
        rightMargin: 5
    }

    // ─────────────────────────────
    // LABEL
    // ─────────────────────────────

    component CategoryLabel: Text {
        visible: root.wide

        anchors.verticalCenter: parent.verticalCenter

        color: Colors.on_surface_variant

        font {
            family: shellRoot.mainFont
            pixelSize: 10
            bold: true
        }
    }

    // ─────────────────────────────
    // SEPARADOR
    // ─────────────────────────────

    component Separator: Rectangle {
        width: 1
        height: root.wide ? 15 : 12

        anchors.verticalCenter: parent.verticalCenter

        color: Colors.outline_variant
    }

    // ─────────────────────────────
    // RAM / SWAP
    // ─────────────────────────────

    Rectangle {
        Layout.preferredHeight: root.capsuleHeight
        Layout.preferredWidth:
            memoryRow.implicitWidth + root.capsulePadding

        radius: height / 2

        color: "transparent"

       

        Row {
            id: memoryRow

            anchors.centerIn: parent
            spacing: root.capsuleSpacing

            CategoryLabel {
                text: "RAM"
            }

            Metric {
                icon: ""

                value:
                    sysMonitor.ramUsagePercent.toFixed()
                    + (root.wide ? "%" : "")

                reserveText: root.wide ? "100%" : "100"

                accent: Colors.primary

                iconSize: root.defaultIconSize
                valueSize: root.valueSize
                metricSpacing: root.metricSpacing
            }

            Separator {}

            Metric {
                icon: "󰓡"

                value:
                    sysMonitor.swapUsagePercent.toFixed()
                    + (root.wide ? "%" : "")

                reserveText: root.wide ? "100%" : "100"

                accent: Colors.primary

                iconSize: root.wide ? 17 : 15
                valueSize: root.valueSize
                metricSpacing: root.metricSpacing
            }
        }
    }

    // ─────────────────────────────
    // CPU
    // ─────────────────────────────

    Rectangle {
        Layout.preferredHeight: root.capsuleHeight
        Layout.preferredWidth:
            cpuRow.implicitWidth + root.capsulePadding

        radius: height / 2

        color: "transparent"

        

        Row {
            id: cpuRow

            anchors.centerIn: parent
            spacing: root.capsuleSpacing

            CategoryLabel {
                text: "CPU"
            }

            Metric {
                icon: ""

                value:
                    sysMonitor.cpuUsagePercent.toFixed()
                    + (root.wide ? "%" : "")

                reserveText: root.wide ? "100%" : "100"

                accent: Colors.secondary

                iconSize: root.defaultIconSize
                valueSize: root.valueSize
                metricSpacing: root.metricSpacing
            }

            Separator {}

            Metric {
                icon: ""

                value:
                    sysMonitor.cpuTemp.toFixed()
                    + (root.wide ? "°C" : "°")

                reserveText: root.wide ? "100°C" : "100°"

                accent: Colors.secondary

                iconSize: root.defaultIconSize
                valueSize: root.valueSize
                metricSpacing: root.metricSpacing
            }
        }
    }

    // ─────────────────────────────
    // GPU
    // ─────────────────────────────

    Rectangle {
        Layout.preferredHeight: root.capsuleHeight
        Layout.preferredWidth:
            gpuRow.implicitWidth + root.capsulePadding

        radius: height / 2

        color: "transparent"

  
        Row {
            id: gpuRow

            anchors.centerIn: parent
            spacing: root.capsuleSpacing

            CategoryLabel {
                text: "GPU"
            }

            Metric {
                icon: "󰢮"

                value:
                    sysMonitor.gpuUsagePercent.toFixed()
                    + (root.wide ? "%" : "")

                reserveText: root.wide ? "100%" : "100"

                accent: Colors.tertiary

                iconSize: root.defaultIconSize
                valueSize: root.valueSize
                metricSpacing: root.metricSpacing
            }

            Separator {}

            Metric {
                icon: ""

                value:
                    sysMonitor.gpuTemp.toFixed()
                    + (root.wide ? "°C" : "°")

                reserveText: root.wide ? "100°C" : "100°"

                accent: Colors.tertiary

                iconSize: root.defaultIconSize
                valueSize: root.valueSize
                metricSpacing: root.metricSpacing
            }
        }
    }
}