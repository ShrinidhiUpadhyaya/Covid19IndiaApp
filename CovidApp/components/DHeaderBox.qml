import QtQuick 2.12

Rectangle {
    id: root

    property alias text: buttonText.text
    property alias fontSize: buttonText.font.pixelSize
    property alias headerText: headerText.text
    property alias minorText: minorText.text
    property alias headerT: headerText
    property alias minorT: minorText
    property alias textT: buttonText

    signal buttonClicked();

    radius: 4

    MouseArea {
        id: rootMouseArea

        anchors.fill: parent

        onClicked: {
            root.forceActiveFocus();
            root.buttonClicked();
        }
    }

    Rectangle {
        width: parent.width - parent.width * 0.2
        height: 2
        anchors.top: headerText.bottom
        anchors.topMargin: root.height * 0.04
        anchors.horizontalCenter: parent.horizontalCenter
    }

    DText {
        id: headerText

        font.pixelSize: AppThemes.setSize(6)
        color: AppThemes.whiteColor
        anchors.horizontalCenter: parent.horizontalCenter
        topPadding: root.height * 0.2 / 3
    }

    DText {
        id: minorText

        font.pixelSize: AppThemes.setSize(6)
        color: AppThemes.whiteColor
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: buttonText.top
        anchors.bottomMargin: root.height * 0.15 / 2
    }

    DText {
        id: buttonText

        font.pixelSize: AppThemes.setSize(6)
        color: AppThemes.whiteColor
        anchors.bottom: parent.bottom
        anchors.bottomMargin: root.height * 0.2 / 2
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
