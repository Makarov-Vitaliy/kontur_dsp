import QtQuick 2.15
import QtQuick.Layouts 1.15

Item{

    property alias text_label: txtlabel.text
    property alias text_value: txtvalue.text
    property alias sliderObj: slider

    RowLayout{
        anchors{
            left: parent.left
            leftMargin: 10
            right: parent.right
            rightMargin: 10
        }

        height: parent.height

        Text{
            id: txtlabel
            Layout.preferredWidth:  30
            Layout.preferredHeight: parent.height
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

            font {
                 pixelSize: 14
            }

            color: "#FFFFFF"
        }

        Text{
            id: txtvalue
            Layout.preferredWidth:  40
            Layout.preferredHeight: parent.height
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

            font {
                 pixelSize: 14
            }

            color: "#407cfe"
        }

        CustomSlider{
            id: slider
            Layout.preferredWidth:  180
            Layout.preferredHeight: parent.height
            Layout.fillWidth: true
            from: 0
            to: 100
            stepSize: 1
            orientation: Qt.Horizontal
        }
    }
}
