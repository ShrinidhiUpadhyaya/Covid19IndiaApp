import QtQuick 2.12
import QtQuick.Layouts 1.12

import AppThemes 1.0

import "qrc:/components"

Item {
    id: root

    ColumnLayout{
        anchors.fill: parent

        Item {
            Layout.fillHeight: false
            Layout.preferredHeight: AppThemes.setSize(8)
            Layout.fillWidth: true

            DIconButton {
                id: refreshIcon

                source: "qrc:/icons/refreshIcon.png"
                width: height
                height: parent.height
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.topMargin: AppThemes.setSize(1)

                onClicked: {
                    appManager.refreshData();
                }
            }

            DText {
                anchors.centerIn: parent
                text: "Covid19 India"
                font.pixelSize: AppThemes.setSize(7)
                anchors.top: parent.top
                anchors.topMargin: AppThemes.setSize(1)
            }

            DIconButton {
                id: chartIcon

                source: "qrc:/icons/chartIcon.png"
                width: height
                height: parent.height
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: AppThemes.setSize(1)

                onClicked: {
                    appManager.sortOverallConfirmedData({});
                    stackView.push("qrc:/screenManager/CountryChartScreen.qml");
                }
            }
        }

        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: lastUpdateText.height

            DText {
                id: lastUpdateText

                width: parent.width
                text: "Last Updated Time: " + appManager.totalData[0].lastUpdatedTime
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        DCustomDataBox {
            Layout.fillHeight: true
            Layout.fillWidth: true
            count: 4
            headerTextData: ["Confirmed", "Active", "Recovered", "Deceased"]
            minorTextData: [appManager.totalData[0].todayConfirmedCases,"",appManager.totalData[0].todayRecoveredCases, appManager.totalData[0].todayDeceasedCases]
            colorData: [AppThemes.confirmedColor,AppThemes.activeColor,AppThemes.recoveredColor, AppThemes.deceasedColor]
            textData: [appManager.totalData[0].confirmedCases,appManager.totalData[0].activeCases,appManager.totalData[0].recoveredCases,appManager.totalData[0].deceasedCases]
        }

        Item {
            id: vaccinatedItem

            Layout.fillHeight: false
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height * 0.06

            Rectangle {
                width: parent.width - (parent.width * 0.1)
                height: parent.height
                color: AppThemes.vaccinationBackgroundColor
                anchors.centerIn: parent
                radius: 4

                DText {
                    text: appManager.totalVaccineDoses;
                    color: AppThemes.vaccinationTextColor
                    anchors.top: parent.top
                    anchors.topMargin: parent.height * 0.1
                    font.pixelSize: AppThemes.setSize(6)
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                DText {
                    text: "Vaccine Doses Administered"
                    color: AppThemes.vaccinationTextColor
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: AppThemes.setSize(4)
                }
            }
        }

        Item {
            Layout.fillHeight: false
            Layout.fillWidth: true
            Layout.preferredHeight: vaccinatedItem.height

            Rectangle {
                width: parent.width - (parent.width * 0.1)
                height: parent.height
                color: AppThemes.testDataBoxBackGround
                radius: 4
                anchors.centerIn: parent

                DText {
                    anchors.top: parent.top
                    anchors.topMargin: parent.height * 0.1
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: AppThemes.testDataTextColor
                    text: "Tested " + "(" + Qt.formatDateTime(appManager.overallTestData["date"],"dd MMMM") +")"
                    font.pixelSize: AppThemes.setSize(4)
                }


                DText {
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: AppThemes.testDataTextColor
                    text: appManager.overallTestData["totalTests"]
                    font.pixelSize: AppThemes.setSize(6)
                }

                DText {
                    anchors.right: parent.right
                    anchors.rightMargin: parent.height * 0.1
                    color: AppThemes.testDataTextColor
                    text: "Source"
                    font.underline: true
                    anchors.verticalCenter: parent.verticalCenter

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            Qt.openUrlExternally(appManager.overallTestData["source"]);
                        }
                    }
                }
            }
        }


        DBox {
            Layout.fillHeight: false
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height * 0.05
            leftText: "State / UT"
            rightText: "Active Cases"
            leftTextColor: AppThemes.greytTextColor
            rightTextColor: AppThemes.greytTextColor
            fontSize: height * 0.6
            arrow: false
            leftT.font.underline: false
            color: AppThemes.transparentColorCode
        }

        ListView {
            id: mainListView

            Layout.fillHeight: true
            Layout.fillWidth: true
            model: appManager.statesData
            spacing: 5
            clip: true
            delegate: DBox {
                width: mainListView.width
                height: mainListView.height * 0.1
                leftText: appManager.statesData[index].stateName
                rightText: appManager.statesData[index].activeCases

                onButtonClicked: {
                    console.log(appManager.statesData[index].stateCode);
                    appManager.sortSatesDailyData(appManager.statesData[index].stateCode);
                    appManager.sortStateDistrictData(leftText);
                    appManager.getCurrentStateTotalVaccinated(leftText);
                    stackView.push("qrc:/screenManager/StateScreen.qml", {index: index});
                }
            }
        }
    }
}
