import QtQuick 2.12
import QtGraphicalEffects 1.0

Item {
    id: root

    property alias text: iconText.text

    property string source: icon.source

    signal iconClicked()

    Image {
        id: icon

        source: root.source
        width: height
        height: parent.height * 0.6
        mipmap: true
        fillMode: Image.PreserveAspectFit
        smooth: true
        asynchronous: true
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
        }
    }

    DText {
        id: iconText

        height: root.height - icon.height
        font.pixelSize: height * 0.9
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
        }
    }

    MouseArea {
        anchors.fill: parent
        preventStealing: true
        onClicked: {
            root.iconClicked();
        }
    }
}
