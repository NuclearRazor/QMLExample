import QtQuick 2.0

import QtQuick.Dialogs 1.0
import QtQuick.Controls 2.0

Item {
    id: root
    z: 3

    Rectangle {
        id: inspectorField
        x: parent.parent.width - parent.parent.width / 6 + 1
        width: parent.parent.width / 6
        height: parent.parent.height
        color: "white"
        border.color: "black"
        visible: config.isOnInspector

        Rectangle{
            id: inspectorBlock
            width: parent.width
            height: parent.height / 10
            border.color: "black"

            Text {
                anchors.centerIn: parent
                text: "Inspector"
                color: "black"
                font.pointSize: 10
            }
        }

        ColorDialog {
            id: colorDialog
            visible: config.isOnChooseColor
            property bool exit: config.isOnChooseColor
            title: "Please choose a color"
            onAccepted: {
                colorBlock.color = colorDialog.color
                config.isOnChooseColor = false;
                config.translateColor(colorDialog.color);
            }
            onRejected: {
                config.isOnChooseColor = false
            }
        }

        Text {
            id: colorBlockTitle
            anchors.left: colorBlock.left
            anchors.bottom: colorBlock.top
            text: "Color"
            font.pointSize: 10
        }

        Rectangle{
            id: colorBlock
            width: parent.width / 1.5
            height: parent.height / 18
            radius: 5

            x: parent.width/6
            y: parent.height/6

            border.color: "black"

            MouseArea {
                id: rectColorSelectable
                anchors.fill: colorBlock

                onClicked: {
                    config.isOnChooseColor = true;
                }
            }
        }

        Text {
            id: typeBlockTitle
            anchors.left: typeBlock.left
            anchors.bottom: typeBlock.top
            text: qsTr("Type")
            font.pointSize: 10
        }

        Rectangle{
            id: typeBlock
            width: parent.width / 1.5
            height: parent.height / 18

            border.color: "black"
            radius: 5

            x: parent.width/6
            y: parent.height/3.5

            ComboBox {
                editable: false
                anchors.fill: parent

                background: Rectangle {
                    implicitWidth: 120
                    implicitHeight: 40
                    border.color: "black"
                    radius: 5
                }

                model: ListModel {
                    id: typesModelList
                    ListElement { text: "Square" }
                    ListElement { text: "Circle" }
                    ListElement { text: "Triangle" }
                }
                onAccepted: {
                    if (find(editText) === -1)
                    {
                        model.append({text: editText})
                    }

                }

                onCurrentIndexChanged: config.translateType(typesModelList.get(currentIndex).text)
            }

        }

    }
}
