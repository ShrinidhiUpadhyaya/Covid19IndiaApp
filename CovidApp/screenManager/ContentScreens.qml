import QtQuick 2.12
import QtQuick.Layouts 1.12

import AppThemes 1.0

Item {
    id: root

    ColumnLayout {
        anchors.fill: parent

        HomeScreen {
            id: homecreen

            Layout.fillHeight: true
            Layout.fillWidth: true
        }

        CountryChartScreen {
            id: countryChartScreen

            Layout.fillHeight: true
            Layout.fillWidth: true
        }

        DateChartsScreen {
            id: dateChartsScreen

            Layout.fillHeight: true
            Layout.fillWidth: true
        }

        Footer {
            Layout.fillHeight: false
            Layout.fillWidth: true
            Layout.preferredHeight: AppThemes.setSize(10)
        }
    }
}
