import QtQuick 2.12
import QtQuick.Layouts 1.12

import AppThemes 1.0
import AppData 1.0

import "qrc:/components"

AppScreen {
    id: root

    screenIndex: AppData.screenId.homeScreen

    ColumnLayout{
        anchors.fill: parent

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: AppThemes.setSize(8)

            DText {
                width: parent.width - refreshIcon
                text: "Last Updated Time: " + AppData.specificData.lastUpdatedTime
                padding: 2
                anchors.verticalCenter: parent.verticalCenter
            }

            DIconButton {
                id: refreshIcon

                source: "qrc:/icons/refreshIcon.png"
                width: height
                height: parent.height
                anchors {
                    right: parent.right
                    top: parent.top
                }
                onIconClicked: {
                    appManager.refreshData();
                }
            }
        }

        DDataBox {
            Layout.fillHeight: true
            Layout.fillWidth: true
            count: 4
            headerTextData: ["Confirmed", "Active", "Recovered", "Deceased"]
            minorTextData: [AppData.specificData.todayConfirmedCases, "", AppData.specificData.todayRecoveredCases, AppData.specificData.todayDeceasedCases]
            colorData: [AppThemes.confirmedColor,AppThemes.activeColor,AppThemes.recoveredColor, AppThemes.deceasedColor]
            textData: [AppData.specificData.confirmedCases, AppData.specificData.activeCases, AppData.specificData.recoveredCases, AppData.specificData.deceasedCases]
        }

        Item {
            id: vaccinatedItem

            Layout.fillHeight: false
            Layout.fillWidth: true
            Layout.preferredHeight: AppThemes.setSize(12)

            Rectangle {
                width: parent.width - (parent.width * 0.1)
                height: parent.height
                color: AppThemes.vaccinationBackgroundColor
                anchors.centerIn: parent
                radius: 4

                DText {
                    text: AppData.specificData.totalVaccineDoses;
                    color: AppThemes.vaccinationTextColor
                    font.pixelSize: AppThemes.setSize(6)
                    anchors {
                        top: parent.top
                        topMargin: parent.height * 0.1
                        horizontalCenter: parent.horizontalCenter
                    }
                }

                DText {
                    text: "Vaccine Doses Administered"
                    color: AppThemes.vaccinationTextColor
                    anchors {
                        bottom: parent.bottom
                        horizontalCenter: parent.horizontalCenter
                    }

                    font.pixelSize: AppThemes.setSize(4)
                }
            }
        }

        Item {
            Layout.fillHeight: false
            Layout.fillWidth: true
            Layout.preferredHeight: AppThemes.setSize(12)

            Rectangle {
                width: parent.width - (parent.width * 0.1)
                height: parent.height
                color: AppThemes.testDataBoxBackGround
                radius: 4
                anchors.centerIn: parent

                DText {
                    color: AppThemes.testDataTextColor
                    text: "Tested " + "(" + Qt.formatDateTime(AppData.specificData.overallTestData["date"],"dd MMMM") +")"
                    font.pixelSize: AppThemes.setSize(4)
                    anchors {
                        top: parent.top
                        topMargin: parent.height * 0.1
                        horizontalCenter: parent.horizontalCenter
                    }
                }


                DText {
                    anchors {
                        bottom: parent.bottom
                        horizontalCenter: parent.horizontalCenter
                    }
                    color: AppThemes.testDataTextColor
                    text: appManager.overallTestData["totalTests"]
                    font.pixelSize: AppThemes.setSize(6)
                }

                DText {
                    color: AppThemes.testDataTextColor
                    text: "Source"
                    font.underline: true
                    anchors {
                        right: parent.right
                        rightMargin: parent.height * 0.1
                        verticalCenter: parent.verticalCenter
                    }

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
