import QtQuick 2.12
import QtQuick.Layouts 1.12

import AppThemes 1.0

Item {
    id: root

    property alias rows: layout.rows
    property alias columns: layout.columns

    property var values: []

    property string textColor: AppThemes.greytTextColor

    property int currentIndex: 0

    GridLayout {
        id: layout

        height: parent.height
        width: parent.width - (parent.width * 0.1)
        anchors.centerIn: parent
        rows: 1
        columns: 3

        Repeater {
            model: root.values

            Rectangle {
                id: buttonRect

                Layout.fillHeight: true
                Layout.fillWidth: true
                color: root.currentIndex === index ? AppThemes.highlightColor : AppThemes.whiteSmokeColorCode
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
