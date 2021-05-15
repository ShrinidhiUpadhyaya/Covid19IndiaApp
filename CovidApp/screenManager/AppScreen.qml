import QtQuick 2.12
import "qrc:/components"

Item {
    id: root

    Keys.onPressed: {
       if (event.key === Qt.Key_Back) {
           event.accepted = true;
           stackView.pop();
       }
    }

    Component.onCompleted: {
        root.forceActiveFocus()
    }
}
