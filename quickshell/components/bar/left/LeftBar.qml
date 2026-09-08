import QtQuick

Rectangle {
    implicitWidth: parent.width
    height: 30
    color: "transparent"

    property bool wide: false

    clip: true
    anchors {
        left: parent.left
        
        verticalCenter: parent.verticalCenter
    }
    WindowTitle {}
}
