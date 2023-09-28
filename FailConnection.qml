import QtQuick 2.0
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.1


Item {

    id: root
    signal clicked()

    Rectangle{
        anchors.fill: parent

        gradient: Gradient {
            GradientStop { position: 0.0; color: "#2c2f36" }
            GradientStop { position: 1.0; color: "#1c1f26" }
        }
    }

    MultiPointTouchArea{
        anchors.fill: parent
    }

    Text{
        id: message

        anchors{
            verticalCenter: parent.verticalCenter
            horizontalCenter: parent.horizontalCenter
        }

        font{
            family: "Roboto"
            pixelSize: 15
        }

        text: qsTr("Please, check wifi connection to Kontur DSP!", "Проверьте WiFi.....")
        color: "white"
        width: parent.width - 50
        wrapMode: Text.WordWrap
        elide: Text.ElideRight
        horizontalAlignment: Text.AlignHCenter
    }

    ButtonText {
        id: btn
        //checkable: true

        anchors{
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
        }

        text: "Connect"
        width: 90
        height: 50


        onClicked: {
            root.clicked()
            //list.currentIndex=index
        }
    }
}


