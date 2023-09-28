import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.1

Button {
    id: button
    width: 100
    height: 40
    //Material.foreground:

    font{
        pixelSize: 14
        capitalization: Font.MixedCase
    }

    contentItem: Item{

        Text {
            text: button.text
            font: button.font

            anchors{
                fill: parent
            }

            opacity: enabled ? 1.0 : 0.3
            color: (button.down || button.checked) ? "#ffffff" : "#b0b7c1"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight

            //bottomPadding: -3
        }
    }

    background: Rectangle {
        implicitWidth: button.width
        implicitHeight: button.height
        color: button.down || button.checked ? "#3a4a61" : "#282f39" //
        border.color: "#4e555f"
        border.width: 1
        radius: 4
    }
}
