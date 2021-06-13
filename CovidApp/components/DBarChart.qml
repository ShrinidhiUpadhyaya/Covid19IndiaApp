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
    property int currentIndex: isAxisChart ? values.length-1 : -1

    property bool isAxisChart: false

    signal currentValueChanged(real value);

    onCurrentIndexChanged: {
        currentValueChanged(root.values[currentIndex])
    }

    RowLayout {
        id: mainRowLayout

        width: parent.width - (parent.width * 0.1)
        height: parent.height - (root.isAxisChart ? 0 : AppThemes.setSize(4))
        spacing: 0
        anchors.centerIn: parent

        Repeater {
            model: root.values

            Item {
                Layout.fillHeight: true
                Layout.fillWidth: true

                MouseArea {
                    anchors.fill: parent
                    enabled: isAxisChart
                    onClicked: {
                        root.currentIndex = index
                        rectComp.forceActiveFocus()
                    }
                }

                Rectangle {
                    id: rectComp

                    width: parent.width / 1.5
                    height:  (mainRowLayout.height * (root.values[index] / root.maxDailyValue)) -
                             (root.topValue.length > 0 ? AppThemes.setSize(4) : 0) -
                             (root.bottomValue.length > 0 ? AppThemes.setSize(4) : 0)
                    color: (root.currentIndex === index && root.isAxisChart) ? AppThemes.blackSmokeColorCode : root.barColor
                    radius: 4
                    anchors {
                        bottom: parent.bottom
                        bottomMargin: root.bottomValue.length > 1 ? root.height * 0.1 : 0
                        horizontalCenter: parent.horizontalCenter
                    }

                    Behavior on height {
                        SmoothedAnimation { duration: 1000; easing.type: Easing.InOutQuad;}
                    }
                }

                DText {
                    height: font.pixelSize
                    text: root.topValue.length > 0 ? root.topValue[index] : ""
                    color: root.topTextColor
                    font.pixelSize: AppThemes.setSize(4)
                    visible: rectComp.height > 0 && root.topValue
                    anchors {
                        top: rectComp.top
                        topMargin: -height
                        horizontalCenter: parent.horizontalCenter
                    }
                }

                DText {
                    height: font.pixelSize
                    text: root.bottomValue.length > 0 ?  root.bottomValue[index] : ""
                    color: root.bottomTextColor
                    font.pixelSize: AppThemes.setSize(4)
                    visible: root.bottomValue
                    anchors {
                        bottom: parent.bottom
                        horizontalCenter: parent.horizontalCenter
                    }
                }
            }
        }
    }
}
