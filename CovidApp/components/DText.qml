import QtQuick 2.12

Text {
    id: root

    font.bold: true
    elide: Text.ElideRight
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    font.family: AppThemes.fontFamilyType

    Behavior on scale {
        SmoothedAnimation { duration: 150 }
    }
}
