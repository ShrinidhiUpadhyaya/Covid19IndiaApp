import QtQuick 2.12
import QtQuick.Layouts 1.12

import AppThemes 1.0

import "qrc:/components"

Item {
    id: root

    property alias rows: gridLayout.rows
    property alias columns: gridLayout.columns

    property var xValues: []
    property var yValues: []
    property var headerTexts: []
    property var headerTextColors: []
    property var colors: []
    property var barColors: []
    property var valueTextAppend: []

    readonly property bool multiCharts: gridLayout.rows > 1 || gridLayout.columns > 1

    width: parent.width
    height: parent.height

    GridLayout {
        id: gridLayout

        anchors.fill: parent
        rowSpacing: 10
        columnSpacing: 5

        Repeater {
            model: root.multiCharts ? root.xValues : 1

            Rectangle {
                id: rectRoot

                Layout.fillHeight: true
                Layout.fillWidth: true
                color: root.colors[index]

                ColumnLayout {
                    anchors.fill: parent
                    spacing: 0

                    Item {
                        Layout.fillWidth: true
                        Layout.fillHeight: false
                        Layout.preferredHeight: rectRoot.height * 0.1

                        DText {
                            height: parent.height
                            text: root.headerTexts[index]
                            color: root.headerTextColors[index]
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
                            color: root.headerTextColors[index]
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
                            property int currentIndex: root.xValues[index].length - 1

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
                            values: modelData
                            barColor: root.barColors[index]
                            isAxisChart: true
                            anchors {
                                right: parent.right
                                bottom: parent.bottom
                            }

                            onCurrentValueChanged: {
                                currentText.text = value + " " + AppThemes.getDate(yValues[currentIndex],AppThemes.dateFormat2)
                            }
                        }
                    }
                }
            }
        }
    }
}
