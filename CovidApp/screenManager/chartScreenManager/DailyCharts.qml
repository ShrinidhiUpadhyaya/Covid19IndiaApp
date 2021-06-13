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
                    dataSource.createLineChart(dailyConfirmedChart.series(0),AppData.specificData.dailyDateData,AppData.specificData.dailyConfirmedData);
                    dataSource.createLineChart(dailyRecoveredChart.series(0),AppData.specificData.dailyDateData,AppData.specificData.dailyRecoveredData);
                    dataSource.createLineChart(dailyDeceasedChart.series(0),AppData.specificData.dailyDateData,AppData.specificData.dailyDeceasedData);
                }
            }

            DLineChart {
                id: dailyConfirmedChart

                Layout.fillHeight: true
                Layout.fillWidth: true
                headerText:"Confirmed"
                textColor: AppThemes.confirmedTextColor
                dateData: AppData.specificData.dailyDateData
                valueData: AppData.specificData.dailyConfirmedData
            }

            DLineChart {
                id: dailyRecoveredChart

                Layout.fillHeight: true
                Layout.fillWidth: true
                headerText:"Recovered"
                textColor: AppThemes.recoveredTextColor
                dateData: AppData.specificData.dailyDateData
                valueData: AppData.specificData.dailyRecoveredData
            }

            DLineChart {
                id: dailyDeceasedChart

                Layout.fillHeight: true
                Layout.fillWidth: true
                headerText:"Deceased"
                textColor: AppThemes.deceasedTextColor
                dateData: AppData.specificData.dailyDateData
                valueData: AppData.specificData.dailyDeceasedData
            }
        }
    }
}
