import QtQuick 2.4
import QtQuick.Window 2.2

Window {
    id: win
    width: 1200
    height: 600
    title: "Drag & drop example"
    visible: true

    Config {id: config}

    PalettesField{
        id: palettesField
    }

    DropField{
        id: dropField
    }

    InspectorField{
        id: inspectorField
    }

}
