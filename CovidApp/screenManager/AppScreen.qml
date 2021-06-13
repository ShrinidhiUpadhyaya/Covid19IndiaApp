import QtQuick 2.12

import "qrc:/components"

Item {
    id: root

    property real screenIndex: -1
    property bool isOverlay: false

    visible: isOverlay ? true : currentScreenIndex === screenIndex
    focus: true

    Keys.onPressed: {
        if (isOverlay && event.key === Qt.Key_Back) {
            if(stackView.depth > 1) {
                stackView.pop();
            } else {
                stackView.clear();
            }
            event.accepted = true;
        }
    }

    Component.onCompleted: {
        root.forceActiveFocus()
    }
}

