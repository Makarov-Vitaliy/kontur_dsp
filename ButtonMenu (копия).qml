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
            color: btn.down || btn.checked ? "#f1f1f1" : "#a2a2a2"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignBottom
            bottomPadding: -3
        }
    }


    background: Rectangle {
        color: btn.checked ? "#1e2432" : "#474747"
        border.color: "#FFFFFF"
        border.width:  btn.checked ? 1 :0
        radius: 4

        Image{
            id: img
            anchors{
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                topMargin: 5

            }
            width: 16
            height: 16

            layer {
                enabled: btn.checked

                effect: ColorOverlay {
                    color: "#0dbde2"
                }
            }
        }
    }

    onClicked: {
         menu_swipe.currentIndex=index
    }
}
