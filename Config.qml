import QtQuick 2.0

//Set of global properies

Item {

    //actual objects list
    property var objectsRegistry: []

    property var selectedObject: ({})

    //objects count alias
    property int objectsCount: objectsRegistry.length

    //is inspector on choose color
    property bool isOnChooseColor: false

    //is active Inspector field when object clicked
    property bool isOnInspector: false


    signal translateColor(string color)
    signal translateType(string object_type)
}
