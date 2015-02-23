import QtQuick 2.0

Item {
    id : compassui
    anchors.fill: parent

    property real heading

    function setBearing(headingIn)
    {
        heading = headingIn
        background.rotation = -heading
    }

    Item {
        //anchors.centerIn: parent
        anchors.fill: parent
        Image { id: background;
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            source: "compass.svg";
        }

    }
}
