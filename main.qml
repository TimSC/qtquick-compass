import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtSensors 5.0

ApplicationWindow {
    title: qsTr("Compass test")
    width: 640
    height: 480
    visible: true

    property real heading

    menuBar: MenuBar {
        Menu {
            title: qsTr("&File")
            MenuItem {
                text: qsTr("&Open")
                onTriggered: messageDialog.show(qsTr("Open action triggered"));
            }
            MenuItem {
                text: qsTr("E&xit")
                onTriggered: Qt.quit();
            }
        }
    }

    Magnetometer {
        id: mag
        dataRate: 5
        active:true

        onReadingChanged: {
            //var newX = comp.reading.z

            //console.log("Mag:", mag.reading.x, ",", mag.reading.y, ",", mag.reading.z);
            //console.log("Accel:", accel.reading.x, ",", accel.reading.y, ",", accel.reading.z);

            var accelVec = [accel.reading.x, accel.reading.y, accel.reading.z]
            var magEast = crossProduct([mag.reading.x, mag.reading.y, mag.reading.z], accelVec)
            var magNorth = crossProduct(accelVec, magEast)

            magEast = normVec(magEast)
            magNorth = normVec(magNorth)
            //console.log("magEast:", magEast[0], ",", magEast[1], ",", magEast[2]);

            var deviceHeading = [0., 1., 0.]
            var dotWithEast = dotProduct(deviceHeading, magEast)
            var dotWithNorth = dotProduct(deviceHeading, magNorth)
            var bearingRad = Math.atan2(dotWithEast, dotWithNorth)
            var bearingDeg = bearingRad * 180. / Math.PI
            //console.log("bearingDeg:", bearingDeg);

            //if (isNaN(comp.reading.x))
            //   return;

            //heading = newX
            compasshere.setBearing(bearingDeg)
        }
    }

    Accelerometer
    {
        id: accel
        dataRate: 5
        active: true
        onReadingChanged: {
            //if (isNaN(accel.reading))
             //   return;
            //console.log("Accel:", accel.reading.x, ",", accel.reading.y, ",", accel.reading.z);
        }
    }

    function crossProduct(a, b) {

      // Check lengths
      if (a.length != 3 || b.length != 3) {
         return;
      }

      return [a[1]*b[2] - a[2]*b[1],
              a[2]*b[0] - a[0]*b[2],
              a[0]*b[1] - a[1]*b[0]];

    }

    function normVec(a) {
        var compSq = 0.
        for(var i=0;i<a.length;i++)
            compSq += Math.pow(a[i], 2)
        var mag = Math.pow(compSq, 0.5)
        if(mag == 0.) return
        var out = []
        for(var i=0;i<a.length;i++)
            out.push(a[i]/mag)
        return out
    }

    function dotProduct(a, b)
    {
        if (a.length != b.length) return;
        var comp = 0.
        for(var i=0;i<a.length;i++)
            comp += a[i] * b[i]
        return comp
    }

    MainForm {
        anchors.fill: parent
    }

    CompassUi
    {
        id: compasshere

    }

    MessageDialog {
        id: messageDialog
        title: qsTr("May I have your attention, please?")

        function show(caption) {
            messageDialog.text = caption;
            messageDialog.open();
        }
    }

}
