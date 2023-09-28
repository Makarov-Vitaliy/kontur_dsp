import QtQuick 2.15

Item{
    id: root
    property alias text : caption.text

    Text{
        id: caption
        anchors.centerIn: parent
        font.weight: Font.Normal
        font.pixelSize: 13
        color: "#656565"
    }
}
