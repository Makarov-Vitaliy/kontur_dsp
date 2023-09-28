import QtQuick 2.15
import QtQuick.Controls 2.15

Label{
    id: label
    width: 80
    height: 50

    font{
        pixelSize: 18
    }

    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter

    color:"#000000"
    background: Rectangle{
        radius: 8
        color: "#5b93e8"
        border{
            width: 1
            color: "#1c1f26"
        }

    }
}
