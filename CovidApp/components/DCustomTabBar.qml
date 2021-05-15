import QtQuick 2.12
import QtQuick.Layouts 1.12

import AppThemes 1.0

Item {
    id: root

    property var values: []

    property string textColor: AppThemes.greytTextColor

    property int currentIndex: 0

    RowLayout {
        height: parent.height
        width: parent.width - (parent.width * 0.1)
        anchors.centerIn: parent

        Repeater {
            model: root.values

            Rectangle {
                id: buttonRect

                Layout.fillHeight: true
                Layout.fillWidth: true
                color: root.currentIndex === index ? AppThemes.currentHighlightColor : AppThemes.whiteSmokeColorCode
                radius: 4

                DText {
                    anchors.centerIn: parent
                    text: modelData
                    color: root.textColor
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        buttonRect.forceActiveFocus();
                        root.currentIndex = index;
                    }
                }
            }
        }
    }
}
