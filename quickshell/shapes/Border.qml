import Quickshell
import QtQuick
import qs.theme

PanelWindow {
    id: root

    required property var modelData

    property string edge: "bottom"
    property int thickness: 7
    property int radius: 17
    property color fillColor: Colors.background

    // Monitor donde se dibuja este borde
    screen: modelData

    // Tamaño de cada PanelWindow
    implicitWidth: (edge === "left" || edge === "right") ? (thickness + radius) : 0
    implicitHeight: (edge === "bottom") ? (thickness + radius) : 0

    color: "transparent"

    // El borde no reserva espacio para las ventanas
    exclusionMode: ExclusionMode.Ignore

    anchors {
        left: edge === "left" || edge === "bottom"
        right: edge === "right" || edge === "bottom"

        bottom: true

        // Los laterales se extienden desde arriba hasta abajo.
        // El borde inferior solamente se ancla abajo.
        top: edge !== "bottom"
    }

    /*
     * Los bordes laterales empiezan debajo de la barra.
     *
     */
    margins {
        top: edge !== "bottom" ? Config.heightBar : 0

        // Evita que los laterales invadan la curva inferior.
        bottom: edge !== "bottom" ? radius : 0
    }

    Canvas {
        id: shape

        anchors.fill: parent

        onWidthChanged: requestPaint()
        onHeightChanged: requestPaint()

        Connections {
            target: root

            function onFillColorChanged() {
                shape.requestPaint();
            }

            function onThicknessChanged() {
                shape.requestPaint();
            }

            function onRadiusChanged() {
                shape.requestPaint();
            }

            function onEdgeChanged() {
                shape.requestPaint();
            }
        }

        onPaint: {
            var ctx = getContext("2d");

            ctx.reset();
            ctx.fillStyle = root.fillColor;
            ctx.beginPath();

            var w = width;
            var h = height;
            var t = root.thickness;
            var r = root.radius;

            /*
             * LEFT BORDER
             *
             *   ───────╮
             *          │
             *          │
             *          │
             */
            if (root.edge === "left") {

                // Esquina exterior superior izquierda
                ctx.moveTo(0, 0);

                // Extensión horizontal para generar el "melt"
                ctx.lineTo(t + r, 0);

                // Curva hacia el borde vertical
                ctx.arcTo(t, 0, t, r, r);

                // Borde vertical
                ctx.lineTo(t, h);

                // Exterior
                ctx.lineTo(0, h);

                ctx.closePath();
            } else

            /*
             * RIGHT BORDER
             *
             * ╭───────
             * │
             * │
             * │
             */
            if (root.edge === "right") {

                // Esquina exterior superior derecha
                ctx.moveTo(w, 0);

                // Extensión horizontal
                ctx.lineTo(w - (t + r), 0);

                // Curva hacia el borde vertical
                ctx.arcTo(w - t, 0, w - t, r, r);

                // Borde vertical
                ctx.lineTo(w - t, h);

                // Exterior
                ctx.lineTo(w, h);

                ctx.closePath();
            } else

            /*
             * BOTTOM BORDER
             *
             * │                       │
             * ╰───────────────────────╯
             */
            if (root.edge === "bottom") {

                // Exterior inferior
                ctx.moveTo(0, 0);

                ctx.lineTo(0, h);
                ctx.lineTo(w, h);
                ctx.lineTo(w, 0);

                /*
                 * Esquina inferior derecha interna
                 */
                ctx.lineTo(w - t, 0);

                ctx.arcTo(w - t, h - t, w - t - r, h - t, r);

                /*
                 * Línea inferior interna
                 */
                ctx.lineTo(t + r, h - t);

                /*
                 * Esquina inferior izquierda interna
                 */
                ctx.arcTo(t, h - t, t, 0, r);

                ctx.lineTo(t, 0);

                ctx.closePath();
            }

            ctx.fill();
        }
    }
}
