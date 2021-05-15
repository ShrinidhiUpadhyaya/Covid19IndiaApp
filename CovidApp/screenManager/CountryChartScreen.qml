import QtQuick 2.12
import QtQuick.Layouts 1.12

import AppThemes 1.0

import "qrc:/components"

AppScreen {
    id: root

    property var dateData: appManager.overallConfirmedData["date"]
    property var overallConfirmedData: appManager.overallConfirmedData["total"]
    property var overallRecoveredData: appManager.overallConfirmedData["recovered"]
    property var overallDeceasedData: appManager.overallConfirmedData["deceased"]

    focus: true

    ColumnLayout {
        anchors.fill: parent

        Rectangle {
            Layout.fillHeight: false
            Layout.preferredHeight: root.height * 0.05
            Layout.fillWidth: true

            DText {
                width: parent.width
                text: "Charts"
                anchors.centerIn: parent
                font.pixelSize: AppThemes.setSize(6)
            }
        }

        DCustomLineChart {
            id: confirmedChart

            Layout.fillHeight: true
            Layout.fillWidth: true
            headerText:"Confirmed"
            valueText: "\n" + appManager.totalData[0].confirmedCases
            textColor: AppThemes.confirmedTextColor
            minorText: "+" + appManager.totalData[0].todayConfirmedCases
            maxValue: 60000000
            factor: 10000000
            yAxisLabel: AppThemes.croreNotation

            Component.onCompleted: {
                dataSource.createLineChart(confirmedChart.series(0),root.dateData,root.overallConfirmedData);
            }
        }

        DCustomLineChart {
            id: recoveredChart

            Layout.fillHeight: true
            Layout.fillWidth: true
            headerText:"Recovered"
            valueText: "\n" + appManager.totalData[0].recoveredCases
            backgroundColor: AppThemes.recoveredChartColor
            textColor: AppThemes.recoveredTextColor
            minorText:  "+" + appManager.totalData[0].todayRecoveredCases
            maxValue: 30000000
            factor: 10000000
            yAxisLabel: AppThemes.croreNotation

            Component.onCompleted: {
                dataSource.createLineChart(recoveredChart.series(0),root.dateData,root.overallRecoveredData);
            }
        }

        DCustomLineChart {
            id: deceasedChart

            Layout.fillHeight: true
            Layout.fillWidth: true
            headerText:"Deceased"
            valueText:  "\n" + appManager.totalData[0].deceasedCases
            backgroundColor: AppThemes.deceasedChartColor
            textColor: AppThemes.deceasedTextColor
            minorText: "+" + appManager.totalData[0].todayDeceasedCases
            maxValue: 900000
            factor: 100000
            yAxisLabel: AppThemes.lakhsNotation

            Component.onCompleted: {
                dataSource.createLineChart(deceasedChart.series(0),root.dateData,root.overallDeceasedData);
            }
        }
    }
}
