import QtQuick 2.12
import QtQuick.Layouts 1.12

Rectangle {
    id: root

    property alias leftText: leftText.text
    property alias rightText: rightText.text
    property alias leftTextColor: leftText.color
    property alias rightTextColor: rightText.color
    property alias fontSize: leftText.font.pixelSize
    property alias leftT: leftText
    property alias rightT: rightText
    property alias arrow: arrowText.visible

    signal buttonClicked();

    radius: 4
    color: AppThemes.notSelectedColor

    RowLayout {
        anchors.fill: parent
        spacing: 0

        Item{
            Layout.fillWidth: true
            Layout.fillHeight: true
            visible: leftText.text.length > 0

            DText {
                id: leftText

                font.pixelSize: AppThemes.setSize(4)
                anchors.centerIn: parent
                font.underline: true
                width: parent.width
            }
        }

        Item{
            Layout.fillWidth: true
            Layout.fillHeight: true
            visible: rightText.text.length > 0

            DText {
                id: rightText

                font.pixelSize: leftText.font.pixelSize
                anchors.centerIn: parent
                width: parent.width
            }
        }
    }


    DText {
        id: arrowText

        text: ">"
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin:root.height / 4
        font.pixelSize: AppThemes.setSize(6)
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            root.forceActiveFocus();
            root.buttonClicked();
        }
    }
}
