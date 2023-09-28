import QtQuick 2.15
import QtQuick.Layouts 1.15

ColumnLayout {
    id: root
    property alias text: txt.text

    Item{
        Layout.preferredHeight: 2
        Layout.preferredWidth: parent.width
    }

    Item{
        id: header
        Layout.preferredHeight: 20
        Layout.preferredWidth: parent.width

        Text{
            id: txt
            anchors{
                left: parent.left
                right: parent.right
                leftMargin: 7
                rightMargin: 7
                top: parent.top
                bottom: parent.bottom
            }

            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
            color: "#FFFFFF"
        }
    }

    Item{
        //Layout.preferredHeight: 20
        Layout.preferredWidth: parent.width
        Layout.fillHeight: true
        //height: root.height-header.height

        RowLayout{
            anchors{
                left: parent.left
                right: parent.right
                leftMargin: 15
                rightMargin: 5
                top: parent.top
                bottom: parent.bottom
                bottomMargin: 10
            }

            Item{
                Layout.preferredWidth: 30
                Layout.preferredHeight: parent.height

                ButtonImage {
                    id: plus

                    anchors{
                        left: parent.left
                        top: parent.top
                    }

                    width: 24
                    height: 24
                    m_image:  source_body+ "plus.png"
                    border_width: 0

                    onButtonPressed: {
                        delay_slider.value++
                    }
                }

                ButtonImage {
                    id: minus

                    anchors{
                        left: parent.left
                        bottom: parent.bottom
                    }

                    width: 24
                    height: 24
                    m_image:  source_body+ "minus.png"

                    onButtonPressed: {
                        delay_slider.value--
                    }
                }
            }

            Item{
                Layout.preferredWidth: 80
                Layout.preferredHeight: parent.height

                TextValue{
                    opacity: delay_slider.value!=0.00 ? 1 :0
                    anchors.centerIn: parent
                    width: 70
                    height: 30

                    font{
                        pixelSize: 14
                    }

                    text: (Math.round(max_delay_ms*100*delay_slider.value)/10000).toFixed(2)

                    Behavior on opacity {
                        NumberAnimation {duration: 150; easing.type: Easing.InOutQuad;}
                    }
                }
            }

            Item{
                Layout.preferredWidth: 30
                Layout.preferredHeight: parent.height

                CustomSlider {
                    id: delay_slider
                    anchors.verticalCenter: parent.verticalCenter
                    from: 0
                    to: 100
                    stepSize: 1
                    orientation: Qt.Vertical
                    width: parent.width
                    height: parent.height-10
                }
            }
        }
    }
}
