pragma Singleton
import Quickshell

Singleton {

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
    property string time: Qt.formatDateTime(clock.date, "h:mm a")
    property string hour: Qt.formatDateTime(clock.date, "hh")
    property string minute: Qt.formatDateTime(clock.date, "mm")
    property string seconds: Qt.formatDateTime(clock.date, "ss")




    function getDigit(number,index){
        return number[index]
    }
}
