import QtQuick 2.12
import QtQuick.Layouts 1.12

import AppThemes 1.0

Item {
    id: root

    property var headerTextData:[]
    property var minorTextData:[]
    property var textData:[]
    property var colorData:[]

    property real headerFontSize: AppThemes.setSize(6)
    property real minorTextFontSize: AppThemes.setSize(5)
    property real textFontSize: AppThemes.setSize(6)

    property int count: 0

    GridLayout {
        anchors.fill: parent
        rows: 2
        columns: 2

        Repeater {
            model: root.count

            DHeaderBox {
                Layout.fillHeight: true
                Layout.fillWidth: true
                headerText: root.headerTextData[index]
                minorText: root.minorTextData[index] === "" ? "" : "+" + root.minorTextData[index]
                color: root.colorData[index]
                text: root.textData[index]
                headerT.font.pixelSize: root.headerFontSize
                minorT.font.pixelSize: root.minorTextFontSize
                textT.font.pixelSize: root.textFontSize
            }
        }
    }
}
