pragma Singleton

import QtQuick 2.12

Item {
    id: root

    readonly property alias specificData: specificData
    readonly property alias screenId: screenId
    readonly property alias completeData: completeData

    QtObject {
        id: completeData

        property var totalData0:appManager.totalData[0]
        property var overallConfirmedData:appManager.overallConfirmedData
    }

    QtObject {
        id: specificData

        property string todayConfirmedCases: completeData.totalData0.todayConfirmedCases
        property string todayRecoveredCases: completeData.totalData0.todayRecoveredCases
        property string todayDeceasedCases: completeData.totalData0.todayDeceasedCases
        property string lastUpdatedTime: completeData.totalData0.lastUpdatedTime

        property string confirmedCases: completeData.totalData0.confirmedCases
        property string activeCases: completeData.totalData0.activeCases
        property string recoveredCases: completeData.totalData0.recoveredCases
        property string deceasedCases: completeData.totalData0.deceasedCases

        property var overallTestData: appManager.overallTestData
        property string totalVaccineDoses: appManager.totalVaccineDoses;

        property var dateData: completeData.overallConfirmedData["date"]
        property var overallConfirmedData: completeData.overallConfirmedData["total"]
        property var overallRecoveredData: completeData.overallConfirmedData["recovered"]
        property var overallDeceasedData: completeData.overallConfirmedData["deceased"]
    }

    QtObject {
        id: screenId

        property real homeScreen: 0
        property real countryChartScreen: 1
        property real dateChartScreen: 2
        property real statesScreen: 3
    }

}
