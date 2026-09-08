pragma Singleton
import Quickshell
import QtQuick
import "."

Singleton {
    id:root

    // ── Color loader — watches matugen output and updates live ────────────────
    // Use a unique ID to avoid namespace collision with the 'Colors' singleton
    property var _loader: ColorLoader {
        id: internalLoader
    }

    // ── Colors — bound to loader, update automatically when matugen runs ──────
    property color background: internalLoader.background

    property color primary: internalLoader.primary
    property color secondary: internalLoader.secondary
    property color tertiary: internalLoader.tertiary

    property color surface: internalLoader.surface
    property color surface_container: internalLoader.surface_container
    property color surface_container_high: internalLoader.surface_container_high
    property color surface_container_highest: internalLoader.surface_container_highest
    property color surface_container_low: internalLoader.surface_container_low

    property color on_surface: internalLoader.on_surface
    property color on_surface_variant: internalLoader.on_surface_variant

    property color outline: internalLoader.outline
    property color outline_variant: internalLoader.outline_variant

    property color inverse_primary: internalLoader.inverse_primary
}
