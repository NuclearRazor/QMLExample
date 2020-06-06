var component = null;
var sprite = null;


function createSpriteObjects(object_type, instantiation_parent) {
    //console.log("Create: ", object_type);

    if(instantiation_parent === undefined || instantiation_parent === null){
        console.log("Error: undefined instantiation parent");
        return;
    }

    if(object_type === undefined || object_type === null){
        console.log("Error: undefined generation object type");
        return;
    }

    switch(object_type){
        case "CustomCircle":
            component = Qt.createComponent(object_type + ".qml");
            break;
        case "CustomSquare":
            component = Qt.createComponent(object_type + ".qml");
            break;
        case "CustomTriangle":
            component = Qt.createComponent(object_type + ".qml");
            break;
        default: console.log("Error: undefined object creation type");
    }

    if (component.status === Component.Ready)
        return finishCreation(instantiation_parent);
    else
        component.statusChanged.connect(finishCreation);
}


function finishCreation(_instantiation_parent) {
    if (component.status === Component.Ready) {
        sprite = component.createObject(_instantiation_parent);
        if (sprite === null) {
            // Error Handling
            console.log("Error creating object");
        }
        return sprite;
    } else if (component.status === Component.Error) {
        // Error Handling
        console.log("Error loading component:", component.errorString());
    }
}


