import QtQuick 2.0
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.1


Item {
    //anchors.fill: parent
    property alias message : message.text


    Rectangle{
        anchors.fill: parent
        color: "#1c1f26"
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#2c2f36" }
            GradientStop { position: 1.0; color: "#1c1f26" }
            //GradientStop { position: 1.0; color: "#050505" }
        }
    }

    MultiPointTouchArea{
        anchors.fill: parent
    }

    BusyIndicator{
        id: indicator
        anchors.centerIn: parent
        Material.accent: "#5594f1"
        running: true
    }

    Text{
        id: message

        anchors{
            bottom: indicator.top
            bottomMargin: 50
            horizontalCenter: parent.horizontalCenter
        }

        font{
          //  family: "Roboto"
            pixelSize: 15
        }

        color: "white"
        width: parent.width - 50
        wrapMode: Text.WordWrap
        elide: Text.ElideRight
        horizontalAlignment: Text.AlignHCenter
    }
}


