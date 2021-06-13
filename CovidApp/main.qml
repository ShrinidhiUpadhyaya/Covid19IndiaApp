import QtQuick 2.12
import QtQuick.Controls 2.12
//import QtQuick.Controls.Material 2.12

ApplicationWindow {
    id: windowRoot

    width: 640
    height: 480
    visible: true
    //    Material.theme: Material.Dark

    property real currentScreenIndex: 0

    property bool loadContent: appManager.totalData.length  > 0

    onLoadContentChanged: {
        if(windowRoot.loadContent) {
            stackView.clear();
            stackView.push("qrc:/screenManager/ContentScreens.qml")
        }
    }

    StackView {
        id: stackView

        anchors.fill: parent
        initialItem: "qrc:/screenManager/ErrorScreen.qml"
    }
}
