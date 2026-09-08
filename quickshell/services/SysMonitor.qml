import Quickshell
import Quickshell.Io
import QtQuick

Scope {
    id: root
    // Metricas
    property real ramUsagePercent: 0
    property real swapUsagePercent: 0
    property real cpuUsagePercent: 0
    property real cpuTemp: 0

    // Variables internas para el cálculo de CPU
    property real prevIdle: 0
    property real prevTotal: 0

    // GPU
    property real gpuUsagePercent: 0
    property real gpuTemp: 0

    // MEMORIA
    FileView {
        id: memFile
        path: "/proc/meminfo"
        onTextChanged: {
            if (!text())
                return;
            let lines = text().split("\n");
            let totalRam = 0, availRam = 0;
            let totalSwap = 0, availSwap = 0;
            for (let l of lines) {
                if (l.startsWith("MemTotal:"))
                    totalRam = parseInt(l.match(/\d+/)[0]);
                if (l.startsWith("MemAvailable:"))
                    availRam = parseInt(l.match(/\d+/)[0]);
                if (l.startsWith("SwapTotal:"))
                    totalSwap = parseInt(l.match(/\d+/)[0]);
                if (l.startsWith("SwapFree:"))
                    availSwap = parseInt(l.match(/\d+/)[0]);
            }
            if (totalRam > 0)
                root.ramUsagePercent = (totalRam - availRam) * 100 / totalRam;
            if (totalSwap > 0) {
                root.swapUsagePercent = (totalSwap - availSwap) * 100 / totalSwap;
            } else {
                root.swapUsagePercent = 0;
            }
        }
    }

    // TEMPERATURA PROCESADOR
    FileView {
        id: cpuTempFile
        path: "/sys/class/hwmon/hwmon2/temp1_input"
        onTextChanged: {
            if (!text())
                return;
            let val = parseInt(text().trim());
            if (!isNaN(val)) {
                root.cpuTemp = val / 1000;
            }
        }
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: {
            memFile.reload();
            cpuTempFile.reload();
        }
    }

    // PROCESADOR
    FileView {
        id: cpuStatFile
        path: "/proc/stat"
        onTextChanged: {
            if (!text())
                return;
            let firstLine = text().split("\n")[0];
            let parts = firstLine.trim().split(/\s+/);

            if (parts[0] === "cpu") {
                // Tiempos individuales
                let user = parseInt(parts[1]);
                let nice = parseInt(parts[2]);
                let system = parseInt(parts[3]);
                let idle = parseInt(parts[4]);
                let iowait = parseInt(parts[5]);
                let irq = parseInt(parts[6]);
                let softirq = parseInt(parts[7]);
                let steal = parseInt(parts[8]);

                let currentIdle = idle + iowait;
                let currentNonIdle = user + nice + system + irq + softirq + steal;
                let currentTotal = currentIdle + currentNonIdle;

                // Calcular diferencias respecto a la muestra anterior
                let totalDiff = currentTotal - root.prevTotal;
                let idleDiff = currentIdle - root.prevIdle;

                if (totalDiff > 0) {
                    root.cpuUsagePercent = ((totalDiff - idleDiff) * 100) / totalDiff;
                }

                // Guardar estado para el próximo ciclo
                root.prevTotal = currentTotal;
                root.prevIdle = currentIdle;
            }
        }
    }

    // GPU
    Process {
        id: gpuProcess
        running: true
        command: ["nvidia-smi", "--query-gpu=temperature.gpu,utilization.gpu", "--format=csv,noheader,nounits"]
        stdout: StdioCollector {
            onStreamFinished: {
                let output = text.trim().replace(/\s/g, '').split(",");
                root.gpuTemp = parseFloat(output[0]);
                root.gpuUsagePercent = parseFloat(output[1]);
            }
        }
    }

    Timer {
        interval: 3500
        running: true
        repeat: true
        onTriggered: {
            cpuStatFile.reload();
            if (!gpuProcess.running)
                gpuProcess.running = true;
        }
    }
}
