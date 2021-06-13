import QtQuick 2.12
import QtQuick.Controls 2.12

import AppThemes 1.0

import "qrc:/components"

Item {
    id: root

    property alias model: control.model

    Tumbler {
        id: control

        anchors.fill: parent

        delegate: DText {
            text: modelData
            opacity: 1.0 - Math.abs(Tumbler.displacement) / (control.visibleItemCount / 2)
            font.pixelSize: AppThemes.setSize(8) * opacity
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    control.currentIndex = index
                }
            }
        }
    }
}
