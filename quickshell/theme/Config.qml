pragma Singleton
import Quickshell

Singleton {

    //-------------------- RESPONSIVE SETTINGS ---------------------------------

    // Breakpoints
    readonly property int breakpointCompact: 1600
    readonly property int breakpointNarrow: 1366

    // calculo
    // retorna 0: pantalla chica
    // retorna 1: pantalla mediana
    // retorna 2: pantalla grande
    function layoutMode(screenWidth) {
        if (screenWidth < breakpointNarrow) {
            return 0;
        }
        if (screenWidth < breakpointCompact) {
            return 1;
        }
        return 2;
    }

    //---------- BAR WIDTHS -------------
    readonly property int sideWide: 505
    readonly property int sideCompact: 350
    readonly property int sideNarrow: 300

    readonly property int centerWide: 900
    readonly property int centerCompact: 500
    readonly property int centerNarrow: 420

    // CALCULOS

    function sideWidthBar(screenWidth) {
        if (screenWidth < breakpointNarrow)
            return sideNarrow;

        if (screenWidth < breakpointCompact)
            return sideCompact;

        return sideWide;
    }

    function centerWidthBar(screenWidth) {
        if (screenWidth < breakpointNarrow)
            return centerNarrow;

        if (screenWidth < breakpointCompact)
            return centerCompact;

        return centerWide;
    }

    //--------- BAR HEIGHT ----------
    readonly property int heightBar: 40

    //--------- BAR COMPONENTS----------
    readonly property int sizeClockWide: 30
    readonly property int sizeClockCompact: 25
    readonly property int sizeClockNarrow: 20
    readonly property string clockFontFamily: "Oi"
}
