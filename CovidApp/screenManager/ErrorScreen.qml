import QtQuick 2.12

import AppThemes 1.0

import "qrc:/components"

Rectangle {
    color: AppThemes.whiteSmokeColorCode

    Image {
        id: icon

        source: "qrc:/icons/maskIcon.png"
        width: height
        height: AppThemes.setSize(24)
        mipmap: true
        fillMode: Image.PreserveAspectFit
        smooth: true
        asynchronous: true
        anchors.horizontalCenter: parent.horizontalCenter
    }

    DText {
        text: "Wear A Face Mask, Stay Safe.\n#IndiaFightsCorona COVID-19"
        width: parent.width
        wrapMode: Text.WordWrap
        color: AppThemes.greytTextColor
        anchors {
            top: icon.bottom
            horizontalCenter: parent.horizontalCenter
        }
    }

    DText {
        id: couldnotfetctText
        anchors.centerIn: parent
        text: "Could Not Connect To The Internet. Please Check Your Network."
        width: parent.width
        wrapMode: Text.WordWrap
        padding: 5
        color: AppThemes.greytTextColor
        visible: appManager.configError
    }

    DText {
        text: "Try Again"
        color: AppThemes.confirmedColor
        visible: appManager.configError
        anchors {
            top: couldnotfetctText.bottom
            horizontalCenter: parent.horizontalCenter
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                appManager.refreshData()
            }
        }
    }

    DText {
        anchors.centerIn: parent
        text: "Fetching Data"
        color: AppThemes.greytTextColor
        font.family: AppThemes.fontFamilyType
        visible: !couldnotfetctText.visible
    }
}
