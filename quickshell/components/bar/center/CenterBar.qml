import Quickshell
import QtQuick

Rectangle {
    id: centerBar
    color: 'transparent'
  
    width: bar.centerWidthBar

    anchors {
        verticalCenter: parent.verticalCenter
        horizontalCenter: parent.horizontalCenter
    }

    bottomLeftRadius: 80
    bottomRightRadius: 80

    // WORKSPACES
    Workspaces {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 20
    }

    // CLOCK
    Clock {
        id: clock
        anchors.centerIn: parent
    }
      height: clock.hovered ? 60 : 30

    // MEDIA PLAYER
    MediaPlayer {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: 20
    }
}
