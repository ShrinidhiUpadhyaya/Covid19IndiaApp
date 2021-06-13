import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

import AppThemes 1.0
import AppData 1.0

import "qrc:/components"

AppScreen {
    id: root

    width: parent.width
    height: parent.height
    screenIndex: AppData.screenId.dateChartScreen

    property bool expanded: false

    property var specificData: []
    property var statesNames: specificData["regional"]

    ColumnLayout {
        anchors.fill: parent
        spacing: 10

        DCalendar {
            Layout.fillHeight: true
            Layout.fillWidth: true

            onDateChanged: {
                root.specificData = appManager.getSpecificDateData(date);
                root.statesNames = specificData["regional"];
            }
        }

        Rectangle {
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: AppThemes.transparentColorCode
            border.color: AppThemes.greytTextColor

            DText {
                anchors.centerIn: parent
                text: "No Data Available"
                font.pixelSize: AppThemes.setSize(6)
                color: AppThemes.confirmedColor
                visible: districtListView.count < 1
            }

            Item {
                width: parent.width
                height: parent.height - 2
                anchors.centerIn: parent
                visible: districtListView.count > 1

                ListView {
                    id: districtListView

                    width: parent.width / 2
                    height: parent.height
                    model: root.statesNames
                    spacing: 5
                    clip: true
                    currentIndex: 0

                    delegate: DBox {
                        width: districtListView.width
                        height: districtListView.height * 0.1
                        leftText: temp["loc"]
                        leftT.font.underline: false
                        arrow: false
                        color: districtListView.currentIndex === index ? AppThemes.highlightColor : AppThemes.notSelectedColor

                        property var temp: root.statesNames[index]

                        onButtonClicked: {
                            districtListView.currentIndex = index;
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
                        count: 3
                        rows: 3
                        columns: 1
                        minorTextData: []
                        headerTextData: ["Confirmed", "Recovered", "Deceased"]
                        colorData: [AppThemes.confirmedColor,AppThemes.recoveredColor, AppThemes.deceasedColor]
                        textData: [temp["totalConfirmed"],temp["discharged"],temp["deaths"]]

                        property var temp: root.statesNames[districtListView.currentIndex]
                    }
                }
            }
        }
    }

}


//    Calendar {
//        id: cal

//        implicitHeight: parent.height
//        implicitWidth: parent.width
//        anchors.centerIn: parent

//        style: CalendarStyle {
//            gridVisible: false

//            background:
//                Rectangle {
//                color: AppThemes.whiteSmokeColorCode
//            }

//            navigationBar: Rectangle {
//                color: AppThemes.whiteSmokeColorCode
//                width:root.width
//                height: expanded ? root.height * 0.2 : root.height * 0.1

//                Behavior on height {
//                    SmoothedAnimation { duration: 150 }
//                }

//                ColumnLayout {
//                    anchors.fill: parent

//                    RowLayout {
//                        Layout.fillHeight: true
//                        Layout.fillWidth: true
//                        visible: !root.expanded

//                        DText {
//                            Layout.fillHeight: true
//                            Layout.fillWidth: true
//                            text: "<"
//                            font.pixelSize: AppThemes.setSize(10)
//                        }

//                        DText {
//                            Layout.fillHeight: true
//                            Layout.fillWidth: true
//                            text: styleData.title
//                            font.pixelSize: AppThemes.setSize(6)

//                            MouseArea {
//                                anchors.fill: parent
//                                onClicked: {
//                                    cal.visibleMonth = "7"
//                                    root.expanded = !root.expanded
//                                }
//                            }
//                        }

//                        DText {
//                            Layout.fillHeight: true
//                            Layout.fillWidth: true
//                            text: ">"
//                            font.pixelSize: AppThemes.setSize(10)
//                        }
//                    }

//                    RowLayout {
//                        Layout.fillHeight: true
//                        Layout.fillWidth: true
//                        visible: root.expanded

//                        DTumbler {
//                            Layout.fillHeight: true
//                            Layout.fillWidth: false
//                            Layout.preferredWidth: parent.width * 0.2
//                            model: ["2020", "2021"]
//                        }

//                        DCustomTabBar {
//                            Layout.fillHeight: true
//                            Layout.fillWidth: true
//                            rows: 3
//                            columns: 4
//                            values: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "July", "Aug", "Sept", "Oct", "Nov", "Dec"]
//                            onCurrentIndexChanged: {
//                                root.expanded = !root.expanded
//                            }
//                        }
//                    }
//                }
//            }

//            dayOfWeekDelegate: Rectangle {
//                color: AppThemes.whiteSmokeColorCode
//                width:root.width
//                height: root.height * 0.05
//                border.color: "transparent"
//                enabled: !root.expanded
//                opacity: enabled ? 1 : 0.4

//                DText {
//                    text: control.locale.dayName(styleData.dayOfWeek, control.dayOfWeekFormat)
//                    anchors.centerIn: parent
//                    //                      color: AppThemes.greytTextColor
//                }
//            }

//            dayDelegate: Rectangle {
//                color: styleData.selected ? AppThemes.highlightColor : AppThemes.whiteSmokeColorCode;
//                border.color: "transparent"
//                radius: 4
//                enabled: !root.expanded
//                opacity: enabled ? 1 : 0.4
//                DText {
//                    text: styleData.date.getDate()
//                    anchors.centerIn: parent
//                    color: (styleData.visibleMonth && styleData.valid) ? AppThemes.greytTextColor : "#D3D3D3"
//                }
//            }
//        }
//    }
