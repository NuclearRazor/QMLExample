import QtQuick 2.0

Item {
    id: root
    z: 1

    function resetBorderColor(){
        for(var object in config.objectsRegistry){
           config.objectsRegistry[object].object.cloneBorderColor.color = "white";
        }
    }

    Rectangle {
        id: dropField
        width: 3*parent.parent.width / 2
        height: parent.parent.height
        x: parent.parent.width / 6 - 1
        anchors.leftMargin: 10
        color: "white"
        border.color: "black"

        Rectangle {
            id: objectsCounterBlock
            x: 0
            y: parent.height - parent.height / 20
            width: parent.width + parent.parent.width
            height: parent.height / 20
            border.color: "black"

            Text {
                text: "Number of objects: " + config.objectsCount
                color: "black"
                font.pointSize: 10
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 20
            }
        }

        DropArea {
            property bool dropped: false
            id: dropFieldArea
            anchors.fill: parent

            onExited: {
                dropped = false;
            }
            onDropped:
            {
                dropped = true;
                drop.accept()
                config.objectsCount += 1
            }
        }

        MouseArea {
            id: rectFieldSelectable
            anchors.fill: dropField

            onClicked: {
                resetBorderColor();

                config.isOnInspector = false;
            }
        }
    }
}

