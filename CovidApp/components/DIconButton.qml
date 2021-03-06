import QtQuick 2.12

Item {
    id: root

    property string source: icon.source

    signal iconClicked()

    Image {
        id: icon

        source: root.source
        width: height
        height: parent.height
        mipmap: true
        fillMode: Image.PreserveAspectFit
        smooth: true
        asynchronous: true
    }

    MouseArea {
        anchors.fill: parent
        preventStealing: true
        onClicked: {
            root.iconClicked();
        }
    }
}
