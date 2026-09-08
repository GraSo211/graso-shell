import Quickshell
import QtQuick
import Quickshell.Io 
Image{
    source:"../../../assets/arch-logo.png"
    width: 25
    height: width

    
    Process{
        id: proc
        command: ["wlogout"]
    }

   
    MouseArea{
        id: wlogoutArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            proc.running = true
        }
        
        
    }
}
