import Quickshell
import QtQuick
import qs.components.bar
import qs.services
import qs.shapes

ShellRoot {
    id: shellRoot

    readonly property string mainFont: "Montserrat"

    SysMonitor {
        id: sysMonitor
    }

    Variants {
        model: Quickshell.screens

        delegate: Component {
            Scope {
                id: screenScope

                required property var modelData

                Bar {
                    modelData: screenScope.modelData
                }

                Border {
                    modelData: screenScope.modelData
                    edge: "left"
                }

                Border {
                    modelData: screenScope.modelData
                    edge: "right"
                }

                Border {
                    modelData: screenScope.modelData
                    edge: "bottom"
                }
            }
        }
    }
}