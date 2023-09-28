import QtQuick 2.15
import QtQuick.Layouts 1.15

CardBase{
    id: main_volume

    Column {

        LabelMain{
            text: qsTr("Main Volume")
            anchors{
                left: parent.left
                leftMargin: 15
            }

            width: 100
            height: 30
        }

        Rectangle{
            width: 120
            height: 1
            anchors{
                left: parent.left
                leftMargin: 5
            }

            color: "#4e555f"
        }

        Item{
            height: 20
            width: 1
        }

        MainVolumePart{
            height: main_volume.height-50
            width: main_volume.width
            onMainVolumeChanged: {
                console.debug("VolumeChanged="+value)
            }
        }

        Item{
            height: 30
            width: 1
        }
    }
}
