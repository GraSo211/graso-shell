import QtQuick
import Quickshell.Io

// ============================================================
// ColorsLoader — watches ~/.cache/graso_shell/colors.json
// and exposes parsed color properties.
//
// Not a singleton. Instantiated as a property inside Theme.qml.
// Theme.qml reads loader.background, loader.active etc.
// ============================================================

QtObject {
    id: root

    // ─────────────────────────────────────────────
    // Material You / Matugen
    // ─────────────────────────────────────────────

    property color background: "#131313"

    property color primary: "#bec8c9"
    property color secondary: "#c4c7c7"
    property color tertiary: "#d8c2b9"

    property color primary_container: "#667071"
    property color secondary_container: "#464a4a"
    property color tertiary_container: "#7c6a63"

    property color on_background: "#e4e2e1"

    property color on_primary: "#293233"
    property color on_secondary: "#2d3131"
    property color on_tertiary: "#3b2d28"

    property color on_primary_container: "#ffffff"
    property color on_secondary_container: "#e2e4e4"
    property color on_tertiary_container: "#ffffff"

    // ─────────────────────────────────────────────
    // Surface
    // ─────────────────────────────────────────────

    property color surface: "#131313"
    property color surface_dim: "#131313"
    property color surface_bright: "#393939"

    property color surface_container_lowest: "#0e0e0e"
    property color surface_container_low: "#1b1c1c"
    property color surface_container: "#1f2020"
    property color surface_container_high: "#2a2a2a"
    property color surface_container_highest: "#353535"

    property color surface_variant: "#434848"

    property color on_surface: "#e4e2e1"
    property color on_surface_variant: "#c3c7c8"

    property color surface_tint: "#bec8c9"

    // ─────────────────────────────────────────────
    // Outline
    // ─────────────────────────────────────────────

    property color outline: "#8d9292"
    property color outline_variant: "#434848"

    // ─────────────────────────────────────────────
    // Inverse
    // ─────────────────────────────────────────────

    property color inverse_primary: "#566061"
    property color inverse_surface: "#e4e2e1"
    property color inverse_on_surface: "#303030"

    // ─────────────────────────────────────────────
    // Error
    // ─────────────────────────────────────────────

    property color error: "#ffb4ab"
    property color error_container: "#93000a"
    property color on_error: "#690005"
    property color on_error_container: "#ffdad6"

    // ─────────────────────────────────────────────
    // Misc
    // ─────────────────────────────────────────────

    property color shadow: "#000000"
    property color scrim: "#000000"

    // ─────────────────────────────────────────────
    // Aliases propios de tu shell
    // ─────────────────────────────────────────────

    // Así tus componentes viejos siguen funcionando.
    readonly property color active: primary
    readonly property color text: on_surface
    readonly property color subtext: on_surface_variant
    readonly property color icon: on_surface_variant
    readonly property color iconFont: primary
    readonly property color border: outline_variant

    // ─────────────────────────────────────────────
    // File watcher
    // ─────────────────────────────────────────────

    property var _file: FileView {
        id: colorsFile

        watchChanges: true

        onFileChanged: reload()

        onLoaded: {
            root._parse(colorsFile.text())
        }
    }

    property var _homeProc: Process {
        command: [
            "bash",
            "-c",
            "echo $HOME"
        ]

        running: true

        stdout: SplitParser {
            onRead: function(line) {
                const home = line.trim()

                if (home !== "")
                    colorsFile.path =
                        home + "/.cache/graso_shell/colors.json"
            }
        }
    }

    // ─────────────────────────────────────────────
    // Parser
    // ─────────────────────────────────────────────

    function _setColor(obj, name) {
        if (obj[name] !== undefined)
            root[name] = obj[name]
    }

    function _parse(raw) {
        if (!raw || raw.trim() === "")
            return

        try {
            const obj = JSON.parse(raw)

            // Base
            _setColor(obj, "background")

            _setColor(obj, "primary")
            _setColor(obj, "secondary")
            _setColor(obj, "tertiary")

            _setColor(obj, "primary_container")
            _setColor(obj, "secondary_container")
            _setColor(obj, "tertiary_container")

            _setColor(obj, "on_background")

            _setColor(obj, "on_primary")
            _setColor(obj, "on_secondary")
            _setColor(obj, "on_tertiary")

            _setColor(obj, "on_primary_container")
            _setColor(obj, "on_secondary_container")
            _setColor(obj, "on_tertiary_container")

            // Surface
            _setColor(obj, "surface")
            _setColor(obj, "surface_dim")
            _setColor(obj, "surface_bright")

            _setColor(obj, "surface_container_lowest")
            _setColor(obj, "surface_container_low")
            _setColor(obj, "surface_container")
            _setColor(obj, "surface_container_high")
            _setColor(obj, "surface_container_highest")

            _setColor(obj, "surface_variant")

            _setColor(obj, "on_surface")
            _setColor(obj, "on_surface_variant")

            _setColor(obj, "surface_tint")

            // Outline
            _setColor(obj, "outline")
            _setColor(obj, "outline_variant")

            // Inverse
            _setColor(obj, "inverse_primary")
            _setColor(obj, "inverse_surface")
            _setColor(obj, "inverse_on_surface")

            // Error
            _setColor(obj, "error")
            _setColor(obj, "error_container")
            _setColor(obj, "on_error")
            _setColor(obj, "on_error_container")

            // Misc
            _setColor(obj, "shadow")
            _setColor(obj, "scrim")

        } catch (e) {
            console.warn(
                "ColorLoader: error parsing colors.json:",
                e
            )
        }
    }
}