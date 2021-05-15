import QtQuick 2.12
import QtCharts 2.1
import QtQuick.Controls 2.12

import AppThemes 1.0

ChartView {
    id: root

    legend.visible: false
    antialiasing: true
    backgroundColor: "#FFE5E7"

    property alias valueText: valueText.text
    property alias minorText: minorText.text

    property string headerText: ""
    property string textColor: ""
    property string yAxisLabel: ""

    property int minValue: 0
    property int maxValue: 0
    property int factor: 0

    DText {
        id: headerText

        anchors.top: parent.top
        anchors.topMargin: font.pixelSize
        anchors.horizontalCenter: parent.horizontalCenter
        text: root.headerText + "  " + Qt.formatDateTime(new Date(),"dd MMMM")
        color: root.textColor
    }

    DText {
        id: valueText

        anchors.top: headerText.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        color: root.textColor
    }

    DText {
        id: minorText

        anchors.top: valueText.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        color: root.textColor
        font.pixelSize: AppThemes.setSize(4)
    }

    CategoryAxis {
        id: axisY
        min: 0
        max: root.maxValue
        gridVisible: false
        labelsFont.family: AppThemes.fontFamilyType
        labelsPosition: CategoryAxis.AxisLabelsPositionOnValue
        labelsColor: root.textColor
        labelsFont.pixelSize:  AppThemes.setSize(4)

        CategoryRange {
            label: (endValue/root.factor) + root.yAxisLabel
            endValue: root.maxValue / 3
        }

        CategoryRange {
            label: (endValue/root.factor)  + root.yAxisLabel
            endValue: root.maxValue - (root.maxValue / 3)
        }

        CategoryRange {
            label: (endValue/root.factor)  + root.yAxisLabel
            endValue: root.maxValue
        }
    }

    DateTimeAxis {
        id: axisX

        min: "2020-03-10"
        max: Qt.formatDateTime(new Date(),"yyyy/MM/dd")
        format: "dd MMM yyyy"
        tickCount: 2
        labelsFont.family: AppThemes.fontFamilyType
        gridVisible: false
        labelsColor: root.textColor
        labelsFont.pixelSize:  AppThemes.setSize(4)
    }

    LineSeries {
        axisX: axisX
        axisY: axisY
        color: root.textColor
        width: 6
    }
}
