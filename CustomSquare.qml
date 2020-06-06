import QtQuick 2.0
import QtGraphicalEffects 1.0

import "ComponentCreation.js" as ComponentFabric

Item{
    id:root

    property alias cloneBorderColor: squareCloneInstance.border

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
            case "Circle":
                config.selectedObject.height = 0;
                config.selectedObject.width = 0;

                var uniqueCircle = ComponentFabric.createSpriteObjects("CustomCircle", config.selectedObject);
                uniqueCircle.enabled = false;
                config.translateType.disconnect(updateType)
                break;
            case "Triangle":
                config.selectedObject.height = 0;
                config.selectedObject.width = 0;

                var uniqueTriangle = ComponentFabric.createSpriteObjects("CustomTriangle", config.selectedObject);
                uniqueTriangle.enabled = false;
                config.translateType.disconnect(updateType)
                break;
        }
    }

    Rectangle{

        id: squareCloneInstance
        width: 100; height: 100;
        border { width:4; color: "white" }
        color: "#fe0000"

        z: squareMouseArea.drag.active ||  squareMouseArea.pressed ? 2 : 1

        Drag.active: squareMouseArea.drag.active

        MouseArea {
            id: squareMouseArea
            anchors.fill: squareCloneInstance
            drag.target: squareCloneInstance

            onReleased: {
                if (squareCloneInstance.Drag.drop() !== Qt.IgnoreAction)
                    drag.target = null;
            }
            onClicked: {
                resetBorderColor();

                config.selectedObject = squareCloneInstance;

                config.isOnInspector = true;
                config.translateColor.connect(updateColor);
                config.translateType.connect(updateType);

                cloneBorderColor.color = "blue";
            }

        }

    }
}
