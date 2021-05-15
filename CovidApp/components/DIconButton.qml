import QtQuick 2.12

Item {
    id: root

    property string source: icon.source

    signal clicked()

    Image {
        id: icon

        source: root.source
        width: height
        height: parent.height
        mipmap: true
    }

    MouseArea {
        anchors.fill: parent
        preventStealing: true
        onClicked: {
            root.clicked();
        }
    }
}


