pragma Singleton

import QtQuick 2.12
import QtQuick.Window 2.12

Item {
    id: root

    property real dpi: Screen.pixelDensity*25.4

    property string confirmedColor:"#FF083A"
    property string activeColor: "#007BFF"
    property string deceasedColor: "#6D757D"
    property string recoveredColor: "#28A745"
    property string confirmedTextColor:"#FF7381"
    property string activeTextColor: "#7FC689"
    property string deceasedTextColor: "#A4A9AF"
    property string recoveredTextColor: "#7FC689"
    property string confirmedChartColor:"#FF7381"
    property string activeChartColor: "#7FC689"
    property string deceasedChartColor: "#F6F6F7"
    property string recoveredChartColor: "#E6F5E8"
    property string vaccinationBackgroundColor: "#FCEAEF"
    property string vaccinationTextColor: "#DB5481"
    property string highlightColor: "#D7DFF7"
    property string notSelectedColor: "#F6F6F7"
    property string greytTextColor: "#6D757D"
    property string barChartColor: "#007BFF"
    property string whiteColor: "white"
    property string greyColor1: "#EDEEEF"
    property string transparentColorCode: "transparent"
    property string whiteSmokeColorCode: "#F1F1F1"
    property string blackSmokeColorCode: "#36454f"
    property string testDataBoxBackGround: "#E2E3F5"
    property string testDataTextColor: "#3C3CAF"
    property string lightGrey: "#D3D3D3"
    property string black: "#000000"

    property string croreNotation: "Cr"
    property string lakhsNotation: "L"
    property string thousandsNotation: "K"

    property string fontFamilyType: fontType.name

    property string dateFormat1: "dd MMMM yyyy"
    property string dateFormat2: "dd MMM yyyy"
    property string dateFormat3: "yyyy-MM-dd"

    FontLoader {
        id: fontType

        source: "Fonts/NexaBold.otf"
    }

    function setSize(x) {
        return Math.max(inchr(x/1000),1);
    }

    function inchr(x) {
        return Math.ceil(x * dpi * 25.4);
    }

    function getDate(value,dateFormat) {
        console.log(value)
        console.log(dateFormat)
        return Qt.formatDateTime(value,dateFormat);
    }
}
