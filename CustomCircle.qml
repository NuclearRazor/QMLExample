import QtQuick 2.0
import QtGraphicalEffects 1.0

import "ComponentCreation.js" as ComponentFabric

Item{
    id:root

    property alias cloneBorderColor: circleCloneInstance.border
    property alias cloneColor: circleCloneInstance.color

    function updateColor(color)
    {
        config.selectedObject.color = color;
    }

    function resetBorderColor(){
        for(var object in config.objectsRegistry){
           config.objectsRegistry[object].object.cloneBorderColor.color = "white";
        }
    }

    function updateType(object_type)
    {
        switch(object_type){
            case "Square":
                config.selectedObject.height = 0;
                config.selectedObject.width = 0;

                var uniqueSquare = ComponentFabric.createSpriteObjects("CustomSquare", config.selectedObject);
                uniqueSquare.enabled = false;
                config.translateType.disconnect(updateType);
                break;
            case "Triangle":
                config.selectedObject.height = 0;
                config.selectedObject.width = 0;

                var uniqueTriangle = ComponentFabric.createSpriteObjects("CustomTriangle", config.selectedObject);
                uniqueTriangle.enabled = false;
                config.translateType.disconnect(updateType);
                break;
        }
    }

    Rectangle{

        id: circleCloneInstance
        width: 100; height: 100; radius: width/2

        border { width:4; color: "white" }
        color: "#fff44f"

        z: circleMouseArea.drag.active ||  circleMouseArea.pressed ? 2 : 1

        Drag.active: circleMouseArea.drag.active

        MouseArea {
            id: circleMouseArea
            anchors.fill: circleCloneInstance
            drag.target: circleCloneInstance

            onReleased: {
                if (circleCloneInstance.Drag.drop() !== Qt.IgnoreAction)
                    drag.target = null;
            }
            onClicked: {
                resetBorderColor();
                circleCloneInstance.border.color = "blue";

                config.isOnInspector = true;
                config.selectedObject = circleCloneInstance;

                config.translateColor.connect(updateColor)
                config.translateType.connect(updateType)
            }
        }

    }
}
