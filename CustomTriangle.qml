import QtQuick 2.0
import QtGraphicalEffects 1.0

import "ComponentCreation.js" as ComponentFabric

Item{
    id:root

    property alias cloneBorderColor: triangleOriginalInstance.border
    readonly property real triangleSideSize: 101.0

    function updateColor(color)
    {
        config.selectedObject.fillStyle = color;
        triangle.requestPaint();
        config.selectedObject.color = "blue";
        triangle.requestPaint();
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
            case "Square":
                config.selectedObject.height = 0;
                config.selectedObject.width = 0;

                var uniqueSquare = ComponentFabric.createSpriteObjects("CustomSquare", config.selectedObject);
                uniqueSquare.enabled = false;
                config.translateType.disconnect(updateType)
                break;
        }
    }

    function sign (p1, p2, p3)
    {
        return (p1.x - p3.x) * (p2.y - p3.y) - (p2.x - p3.x) * (p1.y - p3.y);
    }

    function pointInTriangle (pt, v1, v2, v3)
    {
        var d1, d2, d3;
        var has_neg = false ;
        var has_pos = false;

        d1 = sign(pt, v1, v2);
        d2 = sign(pt, v2, v3);
        d3 = sign(pt, v3, v1);

        has_neg = (d1 < 0) || (d2 < 0) || (d3 < 0);
        has_pos = (d1 > 0) || (d2 > 0) || (d3 > 0);

        return !(has_neg && has_pos);
    }

    function isOnTriangleClick(mouse){
        var triangleP1 = {}, triangleP2 = {}, triangleP3 = {};
        triangleP1.x = 0;
        triangleP1.y = triangleSideSize;

        triangleP2.x = 50;
        triangleP2.y = 0;

        triangleP3.x = triangleSideSize;
        triangleP3.y = triangleSideSize;
        var isPointOnTriangle = pointInTriangle(mouse, triangleP1, triangleP2, triangleP3);
        return isPointOnTriangle;
    }

    Rectangle  {
        id: triangleOriginalInstance
        width: 100; height: 100;
        color: "transparent"

        property var border: triangle
        property var fillStyleCloneColor: triangle.fillStyle

        Canvas {
          id: triangle
          z: triangleMouseArea.drag.active ||  triangleMouseArea.pressed ? 2 : 1

          Drag.active: triangleMouseArea.drag.active

          height: 100
          width: 100

          property int triangleWidth: 60
          property int triangleHeight: 60
          property int trbase: 100
          property real hFactor: 1    // height factor
          property var color:  "white"
          property color fillStyle: "#24ff00"
          property int lineWidth: 4
          property bool fill: false
          property bool stroke: true
          property real alpha: 1.0
          property real rotAngle: 0

          onLineWidthChanged:requestPaint();
          onFillChanged:requestPaint();
          onStrokeChanged:requestPaint();
          onColorChanged: requestPaint();

          onPaint: {
              var ctx = getContext("2d");
              ctx.save();
              ctx.clearRect(0,0,triangle.width, triangle.height);
              ctx.strokeStyle = triangle.color;
              ctx.lineWidth = triangle.lineWidth
              ctx.fillStyle = triangle.fillStyle
              ctx.globalAlpha = triangle.alpha
              ctx.lineJoin = "round";
              ctx.beginPath();

              ctx.translate(parent.width/2, 10)
              ctx.moveTo(0, -6); // left point of triangle

              var trheight = Math.sqrt(Math.pow(trbase, 2) - Math.pow(trbase / 2, 2))
              trheight = trheight * Math.abs(hFactor)
              var hfBase = trbase * Math.abs(hFactor)
              ctx.lineTo(hfBase / -2, trheight) // left arm
              ctx.lineTo(hfBase / 2, trheight) // right arm

              ctx.closePath();
              ctx.fill();
              ctx.stroke();
              ctx.restore();
          }

          MouseArea{
              id: triangleMouseArea
              anchors.fill: triangle
              drag.target: triangle

              onReleased: {
                  if (triangle.Drag.drop() !== Qt.IgnoreAction)
                      drag.target = null
              }
              onClicked: {
                  resetBorderColor();

                  const isTriangleClicked = isOnTriangleClick(mouse);

                  if(isTriangleClicked){
                      config.selectedObject = triangle;
                      config.isOnInspector = true;

                      config.translateColor.connect(updateColor);
                      config.translateType.connect(updateType);

                      cloneBorderColor.color = "blue";
                    }
              }
          }

        }


    }
}
