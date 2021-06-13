import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Qt.labs.calendar 1.0

Item {
    id: root

    readonly property date currentDate: new Date()
    readonly property int currentYear: currentDate.getFullYear();
    readonly property int currentMonth: currentDate.getMonth();

    property var monthList: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "July", "Aug", "Sept", "Oct", "Nov", "Dec"]

    property bool expanded: false

    signal dateChanged(string date);

    CalendarModel {
        id: calModel
        from: new Date(2020, 0, 1)
        to: new Date(currentYear,currentMonth, 30)

        Component.onCompleted: {
            swipeView.currentIndex = parseInt(calModel.indexOf(new Date(currentYear,currentMonth, 30)));
        }
    }

    ColumnLayout {
        anchors.fill: parent

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: false
            Layout.preferredHeight: expanded ? parent.height * 0.4 : parent.height * 0.1

            Behavior on height {
                SmoothedAnimation { duration: 150 }
            }

            RowLayout {
                anchors.fill: parent
                visible: !root.expanded

                DText {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    text: "<"
                    font.pixelSize: AppThemes.setSize(10)

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            swipeView.currentIndex--;
                        }
                    }
                }

                DText {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    text: monthList[calModel.monthAt(swipeView.currentIndex)] + " " + calModel.yearAt(swipeView.currentIndex)
                    font.pixelSize: AppThemes.setSize(6)

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            root.expanded = !root.expanded
                        }
                    }
                }

                DText {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    text: ">"
                    font.pixelSize: AppThemes.setSize(10)
                    color: enabled ? AppThemes.black : AppThemes.lightGrey
                    enabled: !(swipeView.currentIndex === (swipeView.count-1))

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            swipeView.currentIndex++;
                        }
                    }
                }
            }

            Rectangle {
                anchors.fill: parent
                visible: root.expanded

                RowLayout {
                    width: parent.width - (parent.width * 0.04)
                    height: parent.height
                    anchors.centerIn: parent

                    DTumbler {
                        Layout.fillHeight: true
                        Layout.fillWidth: false
                        Layout.preferredWidth: parent.width * 0.3
                        model: ["2020", "2021"]
                    }

                    DTabBar {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        rows: 3
                        columns: 4
                        values: root.monthList
                        onCurrentIndexChanged: {
                            root.expanded = !root.expanded
                        }
                    }
                }
            }
        }

        SwipeView {
            id: swipeView
            Layout.fillWidth: true
            Layout.fillHeight: true
            enabled: !root.expanded
            opacity: enabled ? 1 : 0.5

            Repeater {
                model: calModel

                GridLayout {
                    columns: 1
                    rows: 2

                    DayOfWeekRow {
                        locale: grid.locale

                        Layout.fillWidth: true

                        delegate: DText {
                            color: AppThemes.greytTextColor
                            text: model.shortName
                        }
                    }

                    MonthGrid {
                        id: grid
                        month: model.month
                        year: model.year
                        locale: Qt.locale("en_US")

                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        spacing: 0

                        background: Rectangle {
                            color: AppThemes.whiteSmokeColorCode
                        }

                        delegate: Rectangle {
                            id: dateRect

                            color: model.today ? AppThemes.activeColor : dateRect.activeFocus ? AppThemes.highlightColor : AppThemes.whiteSmokeColorCode
                            radius: 4

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    dateRect.forceActiveFocus()
                                    dateChanged(AppThemes.getDate(model.date, AppThemes.dateFormat3))
                                }
                            }

                            DText {
                                color: model.today ? AppThemes.whiteColor : model.month === grid.month ? AppThemes.greytTextColor : "#D3D3D3"
                                text: model.day
                                anchors.centerIn: parent
                            }
                        }
                    }
                }
            }
        }
    }
}
