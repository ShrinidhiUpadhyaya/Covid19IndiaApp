import QtQuick 2.12
import QtQuick.Layouts 1.12

import AppThemes 1.0

import "qrc:/components"

Item {
    id: root

    property var dailyConfirmedData: appManager.dailyData["confirmed"]
    property var dailyRecoveredData: appManager.dailyData["recovered"]
    property var dailyDeceasedData: appManager.dailyData["deceased"]
    property var dailyDateData: appManager.dailyData["date"]

    property bool chartLoaded: false

    focus: true

    width: parent.width
    height: parent.height

    Timer {
        interval: 10
        running: !chartLoaded && visible
        onTriggered: {
            dataSource.createLineChart(dailyConfirmedChart.series(0),root.dailyDateData,root.dailyConfirmedData);
            dataSource.createLineChart(dailyRecoveredChart.series(0),root.dailyDateData,root.dailyRecoveredData);
            dataSource.createLineChart(dailyDeceasedChart.series(0),root.dailyDateData,root.dailyDeceasedData);
            root.chartLoaded = true
        }
    }

    ColumnLayout {
       anchors.fill: parent

        DLineChart {
            id: dailyConfirmedChart

            Layout.fillHeight: true
            Layout.fillWidth: true
            headerText:"Confirmed"
            textColor: AppThemes.confirmedTextColor
            dateData: root.dailyDateData
            valueData: root.dailyConfirmedData
        }

        DLineChart {
            id: dailyRecoveredChart

            Layout.fillHeight: true
            Layout.fillWidth: true
            headerText:"Recovered"
            textColor: AppThemes.recoveredTextColor
            dateData: root.dailyDateData
            valueData: root.dailyRecoveredData
        }

        DLineChart {
            id: dailyDeceasedChart

            Layout.fillHeight: true
            Layout.fillWidth: true
            headerText:"Deceased"
            textColor: AppThemes.deceasedTextColor
            dateData: root.dailyDateData
            valueData: root.dailyDeceasedData
        }
    }
}
