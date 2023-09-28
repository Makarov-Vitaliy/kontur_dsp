import QtQuick 2.15
import QtQuick.Layouts 1.15

Item{
    id: rooot
    signal mainVolumeChanged(int value)

//    Timer {
//        id: repeat_tmr
//        property bool up: false

//        repeat: true
//        interval: 100
//        onTriggered: {
//            if (up) {
//                volume_slider.value++
//            } else {
//                volume_slider.value--
//            }
//        }
//    }

    Row{
        id: main_row
        height: parent.height

        anchors{
            top: parent.top
            topMargin: 20
            bottom: parent.bottom
            bottomMargin: 20
            horizontalCenter: parent.horizontalCenter
        }

        CustomSlider {
            id: volume_slider
            from: 0
            to: 100
            stepSize: 1
            orientation: Qt.Vertical
            width: 50//parent.width
            height: main_row.height

            onValueChanged: {
                mainVolumeChanged(value)
            }
        }

        Item{
            width:20
            height: 1
        }

        ColumnLayout{
            width: 60
            height: main_row.height

            Item{
                Layout.preferredHeight: 10
                Layout.preferredWidth: parent.width
            }

            Item{
                Layout.preferredHeight: 36
                Layout.preferredWidth: parent.width

                ButtonImage{
                    width: 36
                    height: 36
                    m_image:  source_body+"big_plus.png"

                    onButtonPressed: {
                        volume_slider.value++
                    }
                }
            }

            Item{
                Layout.fillHeight: true
                Layout.preferredWidth:1
            }

            Item{
                Layout.preferredHeight: 50
                Layout.preferredWidth: parent.width

                TextValue{
                    id: label
                    width: 80
                    height: 50
                    anchors.horizontalCenter: parent.horizontalCenter

                    text: volume_slider.value
                }
            }

            Item{
                Layout.fillHeight: true
                Layout.preferredWidth:1
            }

            Item{
                Layout.preferredHeight: 36
                Layout.preferredWidth: 36

                ButtonImage{
                    width: parent.width
                    height: parent.height
                    m_image: source_body+"big_minus.png"

                    onButtonPressed: {
                        volume_slider.value--
                    }
                }
            }

            Item{
                Layout.preferredHeight: 10
                Layout.preferredWidth: parent.width
            }
        }

    }
}
