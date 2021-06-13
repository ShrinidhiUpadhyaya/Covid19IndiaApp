import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

import AppThemes 1.0

import "qrc:/components"

AppScreen {
    id: root

    property int index;
    property var chartData: appManager.currentStatesData[dayChartIndex]
    property var dateData: appManager.currentStatesData[3]
    property int dayChartIndex: 0

    isOverlay: true

    ScrollView {
        width: parent.width
        height : parent.height
        contentWidth: mainColumnLayout.width
        contentHeight: mainColumnLayout.height
        clip: true

        ColumnLayout{
            id: mainColumnLayout

            width: parent.width

            Rectangle {
                Layout.fillHeight: false
                Layout.preferredHeight: stateNameText.lineCount > 1 ? AppThemes.setSize(10) : AppThemes.setSize(8)
                Layout.fillWidth: true

                DText {
                    id: stateNameText


                    text: appManager.statesData[root.index].stateName
                    font.pixelSize: lineCount > 1 ? AppThemes.setSize(5) : AppThemes.setSize(6)
                    height: parent.height
                    maximumLineCount: 2
                    wrapMode: Text.WordWrap
                    elide: Text.ElideNone
                    anchors {
                        left: parent.left
                        right: hospitalIcon.left
                        top: parent.top
                        topMargin: AppThemes.setSize(1)
                    }
                }

                DIconButton {
                    id: hospitalIcon

                    source: "qrc:/icons/hospitalIcon.png"
                    width: height
                    height: parent.height
                    anchors {
                        right: refreshIcon.left
                        rightMargin: height / 2
                        top: parent.top
                        topMargin: AppThemes.setSize(1)
                    }

                    onIconClicked: {
                        appManager.sortHospitalListData(stateNameText.text);
                        stackView.push("qrc:/screenManager/HospitalListScreen.qml");
                    }
                }

                DIconButton {
                    id: refreshIcon

                    source: "qrc:/icons/refreshIcon.png"
                    width: height
                    height: parent.height
                    anchors {
                        right: parent.right
                        top: parent.top
                        topMargin: AppThemes.setSize(1)
                    }

                    onIconClicked: {
                        appManager.refreshData();
                    }
                }

            }

            DText {
                Layout.fillWidth: true
                Layout.fillHeight: false
                Layout.preferredHeight: root.height * 0.04
                Layout.alignment: Qt.AlignHCenter
                text: "Last Updated Time: " + appManager.statesData[root.index].lastUpdatedTime
            }

            DDataBox {
                Layout.fillHeight: false
                Layout.fillWidth: true
                Layout.preferredHeight: root.height * 0.3
                count: 4
                headerTextData: ["Confirmed", "Active", "Recovered", "Deceased"]
                minorTextData: [appManager.statesData[root.index].todayConfirmedCases,"",appManager.statesData[root.index].todayRecoveredCases, appManager.statesData[root.index].todayDeceasedCases]
                colorData: [AppThemes.confirmedColor,AppThemes.activeColor,AppThemes.recoveredColor, AppThemes.deceasedColor]
                textData: [appManager.statesData[root.index].confirmedCases,appManager.statesData[root.index].activeCases,appManager.statesData[root.index].recoveredCases,appManager.statesData[root.index].deceasedCases]
            }

            Item {
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
                        text: appManager.currentStateVaccination;
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
                    }
                }
            }

            DTabBar {
                Layout.fillWidth: true
                Layout.fillHeight: false
                Layout.preferredHeight: AppThemes.setSize(12)
                values: ["Confirmed", "Recovered", "Deceased"]

                onCurrentIndexChanged: {
                    root.dayChartIndex = currentIndex
                    root.chartData = appManager.currentStatesData[root.dayChartIndex]
                }
            }

            DBarChart {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.preferredHeight: root.height * 0.3
                topValue: root.chartData
                bottomValue: root.dateData
                values: root.chartData
            }

            Rectangle {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.preferredHeight: root.height * 0.4
                color: "transparent"
                border.color: AppThemes.greytTextColor
                visible: districtListView.count > 0

                Item {
                    width: parent.width
                    height: parent.height - 2
                    anchors.centerIn: parent

                    ListView {
                        id: districtListView

                        width: parent.width / 2
                        height: parent.height
                        model: appManager.stateDistricts
                        spacing: 5
                        clip: true
                        currentIndex: 0

                        Component.onCompleted: {
                            appManager.searchDistrictData(stateNameText.text,appManager.stateDistricts[currentIndex]);
                        }

                        delegate: DBox {
                            width: districtListView.width
                            height: districtListView.height * 0.1
                            leftText: appManager.stateDistricts[index]
                            leftT.font.underline: false
                            arrow: false
                            color: districtListView.currentIndex === index ? AppThemes.highlightColor : AppThemes.notSelectedColor

                            onButtonClicked: {
                                districtListView.currentIndex = index;
                                appManager.searchDistrictData(stateNameText.text,leftText);
                            }
                        }
                    }

                    Item {
                        width: parent.width / 2
                        height: parent.height - (parent.height * 0.1)
                        anchors {
                            left: districtListView.right
                            verticalCenter: parent.verticalCenter
                        }

                        DDataBox {
                            anchors.fill: parent
                            count: 4
                            headerTextData: ["Confirmed", "Active", "Recovered", "Deceased"]
                            minorTextData: [appManager.currentDistrictData["deltaConfirmed"],"",appManager.currentDistrictData["deltaRecovered"], appManager.currentDistrictData["deltaDeceased"]]
                            colorData: [AppThemes.confirmedColor,AppThemes.activeColor,AppThemes.recoveredColor, AppThemes.deceasedColor]
                            textData: [appManager.currentDistrictData["confirmed"],appManager.currentDistrictData["active"],appManager.currentDistrictData["recovered"],appManager.currentDistrictData["deceased"]]
                            headerFontSize: AppThemes.setSize(4)
                            minorTextFontSize:AppThemes.setSize(4)
                            textFontSize: AppThemes.setSize(4)
                        }
                    }
                }
            }
        }
    }
}
