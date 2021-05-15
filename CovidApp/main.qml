import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

import "qrc:/screenManager"

ApplicationWindow {
    id: windowRoot

    width: 640
    height: 480
    visible: true
//    Material.theme: Material.Dark

    StackView {
        id: stackView

        initialItem: "qrc:/screenManager/HomeScreen.qml"
        anchors.fill: parent
    }
}
