import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import AppThemes 1.0

Rectangle {
    id: root

    property alias text: txt.text

    property var values: []

    property real fontSize: 4

    property bool expanded: false

    color: AppThemes.greyColor1

    Behavior on height {
        SmoothedAnimation { duration: 150 }
    }

    DText {
        id: txt

        width: parent.width - AppThemes.setSize(8)
        height: AppThemes.setSize(4)
        anchors {
            top: parent.top
            topMargin: root.expanded ?  AppThemes.setSize(3) : (parent.height/2) - (height / 2)
        }
        font.pixelSize: root.fontSize
        wrapMode: Text.WordWrap
        elide: Text.ElideRight
        visible: !root.expanded
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            root.expanded = !root.expanded;
        }
    }

    Rectangle {
        id: infoBox

        width: parent.width
        height: root.expanded ? root.height - txt.height : 0
        color: AppThemes.whiteColor
        anchors.top: txt.bottom

        Behavior on height {
            SmoothedAnimation { duration: 150 }
        }

        ColumnLayout {
            anchors.fill: parent
            visible: root.expanded

            DText {
                Layout.fillWidth: true
                Layout.fillHeight: false
                Layout.preferredHeight: AppThemes.setSize(12)
                wrapMode: Text.WordWrap
                text: txt.text

                DIconButton {
                    width: AppThemes.setSize(8);
                    height: width
                    source: "qrc:/icons/browserIcon.png"
                    z: 4
                    anchors {
                        right: parent.right
                        rightMargin: AppThemes.setSize(8);
                        top: parent.bottom
                        topMargin: -AppThemes.setSize(3);
                    }

                    property string searchString: "https://www.google.com/search?q=" + txt.text

                    onIconClicked: {
                        Qt.openUrlExternally(searchString);
                    }
                }
            }

            Row {
                Layout.fillHeight: true
                Layout.fillWidth: true

                ColumnLayout {
                    width: parent.width / 2
                    height: parent.height

                    DText {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        text: "City"
                        font.pixelSize: AppThemes.setSize(4)
                        color: AppThemes.greytTextColor
                    }

                    DText {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        text: "Ownership"
                        color: AppThemes.greytTextColor
                        font.pixelSize: AppThemes.setSize(4)
                    }

                    DText {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        text: "Admission Capacity"
                        color: AppThemes.greytTextColor
                        font.pixelSize: AppThemes.setSize(4)
                    }

                    DText {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        text: "Hospital Beds"
                        color: AppThemes.greytTextColor
                        font.pixelSize: AppThemes.setSize(4)
                    }
                }

                ColumnLayout {
                    width: parent.width / 2
                    height: parent.height

                    DText {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        text: root.values[0]
                        font.pixelSize: AppThemes.setSize(3.2)
                    }

                    DText {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        text: root.values[1]
                        font.pixelSize: AppThemes.setSize(3.2)
                    }

                    DText {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        text: root.values[2]
                        font.pixelSize: AppThemes.setSize(3.2)
                    }

                    DText {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        text: root.values[3]
                        font.pixelSize: AppThemes.setSize(3.2)
                    }
                }
            }
        }
    }

    DText {
        id: arrowText

        text: ">"
        y: txt.y - 2
        font.pixelSize: AppThemes.setSize(6)
        rotation: root.expanded ? -90 : 90
        anchors {
            right: parent.right
            rightMargin: AppThemes.setSize(3);
        }


        Behavior on rotation {
            SmoothedAnimation { duration: 150 }
        }
    }
}
