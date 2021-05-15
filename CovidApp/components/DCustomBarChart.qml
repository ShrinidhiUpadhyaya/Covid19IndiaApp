import QtQuick 2.12
import QtQuick.Layouts 1.12

import AppThemes 1.0

Item {
    id: root

    property var topValue: []
    property var bottomValue: []
    property var values: []

    property string barColor: AppThemes.barChartColor
    property string topTextColor: AppThemes.barChartColor
    property string bottomTextColor: AppThemes.barChartColor

    property int maxDailyValue: Math.max(...values);

    RowLayout {
        width: parent.width - (parent.width * 0.1)
        height: parent.height
        spacing: 0
        anchors.centerIn: parent

        Repeater {
            model: 5

            Item {
                Layout.fillHeight: true
                Layout.fillWidth: true

                Rectangle {
                    id: rectComp

                    width: parent.width / 1.5
                    height:  (root.height * (root.values[index] / root.maxDailyValue)) - root.height * 0.2
                    color: root.barColor
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: root.height * 0.1
                    anchors.horizontalCenter: parent.horizontalCenter
                    radius: 4

                    Behavior on height {
                        SmoothedAnimation { duration: 1000; easing.type: Easing.InOutQuad;}
                    }
                }

                DText {
                    height: font.pixelSize
                    text: root.topValue[index]
                    anchors.top: rectComp.top
                    anchors.topMargin: -height
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: root.topTextColor
                    font.pixelSize: AppThemes.setSize(4)
                    visible: rectComp.height > 0
                }

                DText {
                    height: font.pixelSize
                    text: root.bottomValue[index]
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: root.bottomTextColor
                    font.pixelSize: AppThemes.setSize(4)
                }
            }
        }
    }
}
