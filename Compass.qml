import QtQuick 2.0

Item {
    id : compass
    width: {
            return 200;
    }

    height: {
            return 240;
    }

    property real heading

    function setBearing(headingIn)
    {
        heading = headingIn
        background.rotation = heading
    }

    Item {
        anchors.centerIn: parent
        width: 200; height: 240

        Image { id: background;

            source: "compass.svg";
        }

    }
}
