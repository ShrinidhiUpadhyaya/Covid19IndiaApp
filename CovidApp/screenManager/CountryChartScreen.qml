import QtQuick 2.12
import QtQuick.Layouts 1.12

import AppThemes 1.0
import AppData 1.0

import "qrc:/components"
import "qrc:/components/multiComponents"
import "qrc:/screenManager/chartScreenManager"

AppScreen {
    id: root

    screenIndex: AppData.screenId.countryChartScreen

    property var dailyConfirmedData: appManager.dailyData["confirmed"]
    property var dailyRecoveredData: appManager.dailyData["recovered"]
    property var dailyDeceasedData: appManager.dailyData["deceased"]
    property var dailyDateData: appManager.dailyData["date"]

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

        DTabBar {
            id: mainTabBar

            Layout.fillWidth: true
            Layout.fillHeight: false
            Layout.preferredHeight: parent.height * 0.05
            values: ["Daily", "Cumulative"]
        }

        DTabBar {
            id: subDailyTabBar

            Layout.fillWidth: true
            Layout.fillHeight: false
            Layout.preferredHeight: parent.height * 0.05
            values: ["7 Days", "30 Days", "Beginning"]
            visible: mainTabBar.currentIndex == 0
        }

        DAxisBarCharts {
            Layout.fillHeight: true
            Layout.fillWidth: true
            rows: 3
            columns: 1
            xValues: [root.dailyConfirmedData.slice(dataSize-days,dataSize),
                root.dailyRecoveredData.slice(dataSize-days,dataSize),
                root.dailyDeceasedData.slice(dataSize-days,dataSize)]

            yValues: root.dailyDateData.slice(dataSize-days,dataSize)
            visible: mainTabBar.currentIndex == 0 && subDailyTabBar.currentIndex === 1
            headerTexts: ["Confirmed","Recovered","Deceased"]
            headerTextColors: [AppThemes.confirmedTextColor,AppThemes.recoveredTextColor,AppThemes.deceasedTextColor]
            colors:[AppThemes.vaccinationBackgroundColor,AppThemes.vaccinationBackgroundColor,AppThemes.vaccinationBackgroundColor]
            barColors: [AppThemes.confirmedColor,AppThemes.recoveredColor,AppThemes.deceasedTextColor]

            property real dataSize: root.dailyConfirmedData.length
            property real days: 30
        }

        DAxisBarCharts {
            Layout.fillHeight: true
            Layout.fillWidth: true
            rows: 3
            columns: 1
            xValues: [root.dailyConfirmedData.slice(dataSize-days,dataSize),
                root.dailyRecoveredData.slice(dataSize-days,dataSize),
                root.dailyDeceasedData.slice(dataSize-days,dataSize)]

            yValues: root.dailyDateData.slice(dataSize-days,dataSize)
            visible: mainTabBar.currentIndex == 0 && subDailyTabBar.currentIndex === 0
            headerTexts: ["Confirmed","Recovered","Deceased"]
            headerTextColors: [AppThemes.confirmedTextColor,AppThemes.recoveredTextColor,AppThemes.deceasedTextColor]
            colors:[AppThemes.vaccinationBackgroundColor,AppThemes.vaccinationBackgroundColor,AppThemes.vaccinationBackgroundColor]
            barColors: [AppThemes.confirmedColor,AppThemes.recoveredColor,AppThemes.deceasedTextColor]

            property real dataSize: root.dailyConfirmedData.length
            property real days: 7
        }

        CumalativeCharts {
            Layout.fillHeight: true
            Layout.fillWidth: true
            visible: mainTabBar.currentIndex === 1
        }

        DailyCharts {
            Layout.fillHeight: true
            Layout.fillWidth: true
            visible: mainTabBar.currentIndex === 0 && subDailyTabBar.currentIndex === 2
        }
    }
}
