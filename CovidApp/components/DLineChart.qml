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

    property var dateData: []
    property var valueData: []

    property string headerText: ""
    property string textColor: ""
    property string yAxisLabel: "L"
    property string minDate: dateData[0]
    property string maxDate: dateData[dateData.length-1]

    property int maxDailyValue: Math.max(...valueData);
    property int minValue: 0
    property int maxValue: 0
    property int factor: 0
    property int tempMaxValue;
    property int digits;

    margins { right: 0; bottom: 0; left: 0;}

    onMaxDailyValueChanged: {
        root.digits = Math.max(Math.floor(Math.log10(Math.abs(root.maxDailyValue))), 0) + 1;
        root.factor = "1";
        for(var i=0;i<digits-1;i++) {
            root.factor = root.factor + "0"
        }

        root.tempMaxValue = root.maxDailyValue / root.factor;
        root.tempMaxValue++;

        while (tempMaxValue % 3 !== 0) {
            root.tempMaxValue++;
        }

        root.maxValue = root.tempMaxValue * root.factor
        setNotation();
    }

    function setNotation() {
        switch(root.digits-1) {
        case 0:
        case 1:
        case 2:
            break;
        case 3:
        case 4:
            root.yAxisLabel = "K"
            break;
        case 5:
        case 6:
            root.yAxisLabel = "L"
            break;
        case 7:
        case 8:
            root.yAxisLabel = "Cr"
            break;
        }
    }

    DText {
        id: headerText

        text: root.headerText + "  " + AppThemes.getDate(root.maxDate,AppThemes.dateFormat1)
        color: root.textColor
        anchors {
            top: parent.top
            topMargin: font.pixelSize
            horizontalCenter: parent.horizontalCenter
        }
    }

    DText {
        id: valueText

        color: root.textColor
        text: root.valueData[root.valueData.length-1]
        anchors {
            top: headerText.bottom
            horizontalCenter: parent.horizontalCenter
        }
    }

    DText {
        id: minorText

        color: root.textColor
        font.pixelSize: AppThemes.setSize(4)
        anchors {
            top: valueText.bottom
            horizontalCenter: parent.horizontalCenter
        }
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
            label: ((root.maxValue / 3)/root.factor) + root.yAxisLabel
            endValue: root.maxValue / 3
        }

        CategoryRange {
            label: ((root.maxValue - (root.maxValue / 3))/root.factor)  + root.yAxisLabel
            endValue: root.maxValue - (root.maxValue / 3)
        }

        CategoryRange {
            label: (root.maxValue/root.factor)  + root.yAxisLabel
            endValue: root.maxValue
        }
    }

    DateTimeAxis {
        id: axisX

        min: root.minDate
        max: root.maxDate
        format: AppThemes.dateFormat2
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
        //        useOpenGL: true
    }
}
