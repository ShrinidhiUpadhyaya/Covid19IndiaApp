import QtQuick 2.12
import QtQuick.Layouts 1.12

import AppThemes 1.0
import "qrc:/components"

GridLayout {
    id: root

    property alias model: repeater.model

    property real currentIndex: 0

    signal iconClicked(real index)

    rowSpacing: 0

    Repeater {
        id: repeater

        Rectangle {
            id: iconItem

            Layout.fillHeight: true
            Layout.fillWidth: true
            color: root.currentIndex === index ? AppThemes.highlightColor : AppThemes.transparentColorCode
            radius: 4

            Image {
                id: icon

                source: iconSrc
                width: height
                height: parent.height * 0.6
                mipmap: true
                fillMode: Image.PreserveAspectFit
                smooth: true
                asynchronous: true
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
            }


            DText {
                anchors.bottom: parent.bottom
                height: root.height-icon.height
                font.pixelSize: height * 0.9
                anchors.horizontalCenter: parent.horizontalCenter
                scale: root.activeFocus ? 1.2 : 1
                text: iconTxt
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if(currentIndex !== index) {
                        iconItem.forceActiveFocus();
                        root.iconClicked(index);
                        root.currentIndex = index;
                    }
                }
            }
        }
    }
}
