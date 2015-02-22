import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2

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

    Timer {
        interval: 100; running: true; repeat: true;
        onTriggered:
        {
            heading += 3
            compasshere.setBearing(heading)
        }
    }

    MainForm {
        anchors.fill: parent
    }

    Compass
    {
        id: compasshere

    }

}
