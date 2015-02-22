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

    Accelerometer {
        id: accel
        dataRate: 100
        active:true

        onReadingChanged: {
            var newX = (calcRoll(accel.reading.x, accel.reading.y, accel.reading.z) * .1)

            if (isNaN(newX))
                return;

            heading += newX
            compasshere.setBearing(heading)
        }
    }

    function calcRoll(x,y,z) {
         return -(Math.atan(x / Math.sqrt(y * y + z * z)) * 57.2957795);
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
