import QtQuick 2.0
import QtQml.Models 2.1

import "ComponentCreation.js" as ComponentFabric

Item {
    id: root
    z: 2

    function updateObjectsRegistry(object_type, parent_instance){
        var currentObject = ComponentFabric.createSpriteObjects(object_type, parent_instance);
        if(currentObject !== null && currentObject !== undefined)
            config.objectsRegistry.push({"object": currentObject});
    }

    Rectangle{
        id: palettesField
        x: parent.parent.x
        width: parent.parent.width / 6
        height: parent.parent.height
        border.color: "black"

        Rectangle {
            id: palettesBlock
            x: parent.x
            y: parent.y
            width: parent.width
            height: parent.height / 10
            border.color: "black"

            Text {
                anchors.centerIn: parent
                text: "Palettes"
                color: "black"
                font.pointSize: 10
            }
        }

        Rectangle {
            id: circleOriginalInstance
            width: 100; height: 100; radius: width/2
            anchors.horizontalCenter: parent.horizontalCenter
            y: parent.height - parent.height/1.85
            border { width:2; color: "white" }
            color: "#fff44f"

            MouseArea {
                id: mousecircleOriginalArea
                anchors.fill: circleOriginalInstance

                onReleased: {
                    updateObjectsRegistry("CustomCircle", circleOriginalInstance);
                }
                onClicked: {
                    if (circleOriginalInstance.Drag.drop() !== Qt.IgnoreAction)
                        drag.target = null;
                }
            }
        }

        Rectangle {
            id: squareOriginalInstance
            width: 100; height: 100;
            anchors.horizontalCenter: parent.horizontalCenter
            y: parent.height/6
            border { width:2; color: "white" }
            color: "#fe0000"

            MouseArea {
                id: mouseSquareOriginalArea
                anchors.fill: squareOriginalInstance

                onReleased: {
                    updateObjectsRegistry("CustomSquare", squareOriginalInstance);
                }
                onClicked: {
                    if (squareOriginalInstance.Drag.drop() !== Qt.IgnoreAction)
                        drag.target = null;
                }
            }
        }

        Rectangle  {
            id: triangleOriginalInstance
            width: 100; height: 100;
            x: parent.width /4
            y: parent.height - parent.height/4
            color: "transparent"

            Canvas {
              id: triangle
              height: 100
              width: 100

              property int triangleWidth: 50
              property int triangleHeight: 50
              property int trbase: 100
              property real hFactor: 1    // height factor

              property color strokeStyle:  "white"
              property color fillStyle: "#24ff00"
              property int lineWidth: 2
              property bool fill: false
              property bool stroke: true
              property real alpha: 1.0
              property real rotAngle: 0

              onLineWidthChanged:requestPaint();
              onFillChanged:requestPaint();
              onStrokeChanged:requestPaint();

              onPaint: {
                  var ctx = getContext("2d");
                  ctx.save();
                  ctx.clearRect(0,0,triangle.width, triangle.height);
                  ctx.strokeStyle = triangle.strokeStyle;
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
                  id: mouseTriangleOriginalArea
                  anchors.fill: triangle
                  onReleased: {
                        updateObjectsRegistry("CustomTriangle", triangleOriginalInstance);
                  }
                  onClicked: {
                      if (triangle.Drag.drop() !== Qt.IgnoreAction)
                          drag.target = null;

                  }

              }
            }
        }


    }

}
