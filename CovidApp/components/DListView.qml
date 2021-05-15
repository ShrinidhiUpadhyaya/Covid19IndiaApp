import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
    id: root

    property alias model: listView.model
    property alias delegate: listView.delegate

    Rectangle {
        width: parent.width - (parent.width * 0.1)
        height: parent.height
        anchors.centerIn: parent

        color: AppThemes.transparentColorCode
        border.color: AppThemes.notSelectedColor

        ListView {
            id: listView

            anchors.fill: parent

            clip: true

            ScrollBar.vertical: ScrollBar {
                policy: ScrollBar.AsNeeded
            }
        }
    }
}
