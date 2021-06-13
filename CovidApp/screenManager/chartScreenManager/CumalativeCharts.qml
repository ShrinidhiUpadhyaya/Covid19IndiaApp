import QtQuick 2.12
import QtQuick.Layouts 1.12

import AppThemes 1.0
import AppData 1.0

import "qrc:/components"

Item {
    id: root

    width: parent.width
    height: parent.height

    property bool loadChart: false

    onVisibleChanged: {
        if(visible && !loadChart)
            root.loadChart = true
    }

    Loader {
        anchors.fill: parent
        active: root.loadChart

        sourceComponent: ColumnLayout {
            anchors.fill: parent

            Timer {
                interval: 1
                running: true
                onTriggered: {
                    dataSource.createLineChart(confirmedChart.series(0),AppData.specificData.dateData,AppData.specificData.overallConfirmedData);
                    dataSource.createLineChart(recoveredChart.series(0),AppData.specificData.dateData,AppData.specificData.overallRecoveredData);
                    dataSource.createLineChart(deceasedChart.series(0),AppData.specificData.dateData,AppData.specificData.overallDeceasedData);
                }
            }

            DLineChart {
                id: confirmedChart

                Layout.fillHeight: true
                Layout.fillWidth: true
                headerText:"Confirmed"
                valueText: "\n" + AppData.specificData.confirmedCases
                textColor: AppThemes.confirmedTextColor
                minorText: "+" + AppData.specificData.todayConfirmedCases
                dateData: AppData.specificData.dateData
                valueData: AppData.specificData.overallConfirmedData
            }

            DLineChart {
                id: recoveredChart

                Layout.fillHeight: true
                Layout.fillWidth: true
                headerText:"Recovered"
                valueText: "\n" + AppData.specificData.recoveredCases
                backgroundColor: AppThemes.recoveredChartColor
                textColor: AppThemes.recoveredTextColor
                minorText:  "+" + AppData.specificData.todayRecoveredCases
                dateData: AppData.specificData.dateData
                valueData: AppData.specificData.overallRecoveredData
            }

            DLineChart {
                id: deceasedChart

                Layout.fillHeight: true
                Layout.fillWidth: true
                headerText:"Deceased"
                valueText:  "\n" + AppData.specificData.deceasedCases
                backgroundColor: AppThemes.deceasedChartColor
                textColor: AppThemes.deceasedTextColor
                minorText: "+" + AppData.specificData.todayDeceasedCases
                dateData: AppData.specificData.dateData
                valueData: AppData.specificData.overallDeceasedData
            }
        }
    }
}
