import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

import AppThemes 1.0

import "qrc:/components"

AppScreen {
    id: root

    ColumnLayout{
        width: parent.width
        height: parent.height

        Rectangle {
            Layout.fillHeight: false
            Layout.preferredHeight: AppThemes.setSize(8)
            Layout.fillWidth: true

            DText {
                width: parent.width
                text: "Hospitals"
                anchors.centerIn: parent
                font.pixelSize: AppThemes.setSize(6)
            }
        }

        DText {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignCenter
            text: "No Data Available"
            font.pixelSize: AppThemes.setSize(6)
            color: AppThemes.confirmedColor
            visible: mainListView.count < 1
        }

        ListView {
            id: mainListView

            Layout.fillHeight: true
            Layout.fillWidth: true
            model: appManager.hospitalListData
            spacing: 5
            clip: true
            add: Transition {
                    SmoothedAnimation { properties: "x,y"; from: 100; duration: 1000 }
                }
            delegate: DCustomDropDown {
                width: mainListView.width
                height: expanded ? mainListView.height * 0.3 : mainListView.height * 0.1
                text: appManager.hospitalListData[index].name
                values: [appManager.hospitalListData[index].city, appManager.hospitalListData[index].ownership,
                    appManager.hospitalListData[index].admissionCapacity, appManager.hospitalListData[index].hospitalBeds];
                fontSize: AppThemes.setSize(4);
            }
        }
    }
}
