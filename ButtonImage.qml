import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button {
    id: btn
    property alias m_image: img.source
    property alias border_width: rect.border.width

    signal buttonPressed()

    onPressed: {
       buttonPressed()
    }

    onPressAndHold: {
        repeat_tmr.start()
    }

    onPressedChanged: {
        if (!pressed) {
            repeat_tmr.stop()
        }
    }

    Timer {
        id: repeat_tmr

        repeat: true
        interval: 70

        onTriggered: {
            buttonPressed()
        }
    }

    background: Rectangle {
        id: rect

        color: "transparent"//btn.checked ? "#1e2432" : "#474747"
        border.color:  btn.pressed ? "#FFFFFF" : "#b0b7c1"
        border.width:  1//btn.checked ? 1 :0
        radius: 4
        anchors.fill: parent

        Image{
            id: img
            anchors.centerIn: parent
            opacity: enabled ? 1.0 : 0.3
            width: btn.width
            height: btn.height

            layer {
                enabled: btn.pressed

                effect: ColorOverlay {
                    color: btn.pressed ? "#3c82f1" : "#b0b7c1"
                }
            }
        }
    }
}
