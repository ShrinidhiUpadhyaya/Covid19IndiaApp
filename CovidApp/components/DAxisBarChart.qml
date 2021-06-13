import QtQuick 2.12
import QtQuick.Layouts 1.12

import AppThemes 1.0

Item {
    id: root

    property var xValues;
    property var yValues;
    property string headerText;
    property string headerTextColor;
    property string color;
    property string barColor;
    property string valueTextAppend;

    width: parent.width
    height: parent.height

    Rectangle {
        id: rectRoot

        anchors.fill: parent
        color: root.color

        ColumnLayout {
            anchors.fill: parent
            spacing: 0

            Item {
                Layout.fillWidth: true
                Layout.fillHeight: false
                Layout.preferredHeight: rectRoot.height * 0.1

                DText {
                    height: parent.height
                    text: root.headerText
                    color: root.headerTextColor
                    anchors {
                        left: parent.left
                        verticalCenter: parent.verticalCenter
                    }
                }

                DText {
                    id: currentText

                    height: parent.height
                    anchors {
                        right: parent.right
                        rightMargin: AppThemes.setSize(4)
                        verticalCenter: parent.verticalCenter
                    }
                    color: root.headerTextColor
                }
            }

            Rectangle {
                Layout.fillHeight: true
                Layout.fillWidth: true
                color: AppThemes.transparentColorCode

                Item {
                    id: gridItem

                    width: parent.width
                    height:  parent.height - AppThemes.setSize(5)
                    anchors.bottom: parent.bottom

                    property real temp: 5

                    property int gridCount: 10
                    property int maxValue: calcMaxValue()
                    property int currentIndex: root.xValue.length - 1

                    function calcMaxValue() {
                        var digits = Math.max(Math.floor(Math.log10(Math.abs(chart.maxDailyValue))), 0) + 1;
                        temp = "1";
                        for(var i=0;i<digits-2;i++) {
                            temp = temp + "0"
                        }
                        return Math.ceil(chart.maxDailyValue/temp)*temp
                    }

                    Repeater {
                        id: gridLinesRepeater

                        model: gridItem.gridCount + 1

                        width: parent.width
                        height: parent.height

                        Item {
                            width: root.width
                            y: index === 0 ? gridLinesRepeater.height : gridLinesRepeater.height - (gridLinesRepeater.height * (index/gridItem.gridCount))
                            Rectangle {
                                id: lineRect

                                width: root.width
                                height: 1
                                color: AppThemes.greytTextColor
                                opacity: 0.6
                            }

                            DText {
                                text: (gridItem.maxValue / gridItem.gridCount) * index
                                anchors.bottom: lineRect.top
                                font.pixelSize: AppThemes.setSize(3)
                            }
                        }
                    }
                }

                DBarChart {
                    id: chart

                    width: parent.width - AppThemes.setSize(15)
                    height: parent.height - AppThemes.setSize(5)
                    values: xValues
                    barColor: root.barColor
                    isAxisChart: true
                    anchors {
                        right: parent.right
                        bottom: parent.bottom
                    }

                    onCurrentValueChanged: {
                        currentText.text = value + " " + AppThemes.getDate(yValue,AppThemes.dateFormat2)
                    }
                }
            }
        }
    }
}
