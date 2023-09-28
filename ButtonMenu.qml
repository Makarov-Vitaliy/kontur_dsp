import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button {
    id: btn
    property alias image: img.source
    checkable: true
    autoExclusive: true
    anchors.verticalCenter: parent.verticalCenter

    font{
        pixelSize: 12
        capitalization: Font.Capitalize
    }

    contentItem: Item{

        Text {
            text: btn.text
            font: btn.font

            anchors{
                fill: parent
            }

            opacity: enabled ? 1.0 : 0.3
            color: btn.down || btn.checked ? "#ffffff" : "#b0b7c1"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignBottom
            bottomPadding: -3
        }
    }


    background: Rectangle {
        color: "transparent"//btn.checked ? "#1e2432" : "#474747"
        border.color: "#FFFFFF"
        border.width:  btn.checked ? 1 :0
        radius: 15

        Image{
            id: img
            anchors{
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                topMargin: 5

            }
            opacity: enabled ? 1.0 : 0.3
            width: 16
            height: 16

            layer {
                enabled: !btn.checked

                effect: ColorOverlay {
                    color: "#b0b7c1"
                }
            }
        }
    }
}
