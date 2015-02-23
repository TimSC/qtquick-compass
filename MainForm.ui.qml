import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1

Item {
    width: 640
    height: 480

    ColumnLayout {
        id: columnLayout1
        x: 8
        y: 373
        width: 278
        height: 99

        TextEdit {
            id: x
            width: 80
            height: 20
            text: qsTr("Text Edit")
            font.pixelSize: 12
        }

        TextEdit {
            id: y
            width: 80
            height: 20
            text: qsTr("Text Edit")
            font.pixelSize: 12
        }

        TextEdit {
            id: z
            width: 80
            height: 20
            text: qsTr("Text Edit")
            font.pixelSize: 12
        }
    }


}
