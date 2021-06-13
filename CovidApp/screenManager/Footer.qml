import QtQuick 2.12
import QtQuick.Layouts 1.12

import "qrc:/components/multiComponents"

Item {
    id: root

    ListModel {
        id: footerModel

        ListElement {
            iconSrc: "qrc:/icons/homeIcon.png"
            iconTxt: "Home"
        }
        ListElement {
            iconSrc: "qrc:/icons/chartIcon.png"
            iconTxt: "Charts"
        }
        ListElement {
            iconSrc: "qrc:/icons/calendarIcon.png"
            iconTxt: "Date"
        }
    }

    DIconTextButtons {
        model: footerModel
        anchors.fill: parent

        onIconClicked: {
            currentScreenIndex = index
        }
    }
}
