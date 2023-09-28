import QtQuick 2.15
import QtQuick.Controls.Material 2.1
import QtGraphicalEffects 1.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.2

Item {
    id: dialogRoot
    anchors.fill: parent
    property alias title: m_title.text
    property alias text: textInput.displayText
    Material.accent: "#5594f1"

    signal accepted()
    signal rejected()
    signal finish()

    Component.onCompleted: textInput.forceActiveFocus()
    Component.onDestruction: Qt.inputMethod.hide()

    MouseArea{
        anchors.fill: parent
    }

    Item {
        anchors.fill: parent

        Rectangle {
            id: bgSource
            color: "#2c2f36"
            anchors.fill: dialogBox
            radius: 4
            border.color: "#4e555f"
            border.width: 1
        }

        DropShadow{
            anchors.fill: bgSource
            verticalOffset: 3
            horizontalOffset: 3
            radius: 8.0
            samples: 15
            color: "black"
            source: bgSource
        }

        MouseArea {
            anchors.fill: dialogBox
        }

        ColumnLayout{
            id: dialogBox
            anchors.centerIn: parent
            anchors.verticalCenterOffset: -((Qt.inputMethod.keyboardRectangle.height / Screen.devicePixelRatio)/2)
            spacing: 8
            width:  300

            Item {
                width: 1
                height: 8
            }

            Text {
                id: m_title
                Layout.preferredWidth: parent.width - 48
                Layout.alignment: Qt.AlignHCenter
                font.pixelSize: 20
                color: "#5b5b5b"
            }

            TextField {
                id: textInput
                inputMethodHints: Qt.ImhNoPredictiveText
                focus: true

                Layout.preferredWidth: parent.width - 50
                Layout.alignment: Qt.AlignHCenter
                font.pixelSize: 20
            }

            RowLayout{
                spacing: 8
                Layout.alignment: Qt.AlignRight
                Layout.rightMargin: 8


                Repeater {
                    model: [qsTr("Cancel") ,qsTr("Rename")]

                    Button {
                        id: button
                        padding: 8
                        contentItem: Item {
                            id: buttonRoot
                            implicitWidth: label.implicitWidth + 16 > 64 ? label.implicitWidth + 16 : 64
                            implicitHeight: 36

                            Text{
                                id: label
                                text: modelData
                                color: Material.accent
                                anchors.centerIn: parent
                                font.weight: Font.DemiBold
                                font.pixelSize: 16
                            }
                        }

                        background:  ItemDelegate {
                            onClicked: button.clicked()
                        }

                        onClicked: {
                            if (index == 0)
                                rejected()
                            else if (index == 1)
                                accepted()
                            finish()
                        }
                    }
                }
            }
        }
    }
}



