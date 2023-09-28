import QtQuick 2.15
import QtQuick.Controls.Material 2.12
import QtGraphicalEffects 1.12

Item {
    id: root
    width: parent.fill
    height: 40
    property alias text: txt.text

    Rectangle{
        anchors.fill: parent
        color: "#2c2f36"
//        gradient: Gradient {
//            GradientStop { position: 0.0; color: "#2c2f36" }
//            GradientStop { position: 1.0; color: "#1c1f26" }
//        }
    }

    Text{
        id: txt
        anchors.centerIn: parent
        font.weight: Font.Normal
        font.pixelSize: 16
        color: "#5794ef"
    }

    Item{
        anchors{
            right: parent.right
            top: parent.top
            bottom: parent.bottom
            rightMargin: 5

        }
        width: 30

        Rectangle{
            id: rect
            color: "#551c1f26"
            anchors.centerIn: parent
            width:0
            height:width
            radius: width/2

            Behavior on width {
                 NumberAnimation {duration: 140; easing.type: Easing.InOutQuad;}
            }
        }

        Image{
            id: img
            anchors.centerIn: parent
            source: source_body+ "menu.png"
            opacity: enabled ? 1.0 : 0.3
            width: 18
            height: 18

            layer {
                enabled: ma.pressed

                effect: ColorOverlay {
                    color: "#5794ef"
                }
            }
        }



        MouseArea{
            id: ma
            anchors.fill: parent
            onPressedChanged:  {
                if (pressed){
                    rect.width=30

                } else {
                    rect.width=0
                }
            }

            onClicked: {
                var globalPosition = mapToItem(root,mouseX, mouseY)
                console.debug("X="+globalPosition.x+ "==Y="+globalPosition.y)
                contextMenu.openMenu(globalPosition.x,globalPosition.y)
            }

        }
    }

    ContextMenu {
        id: contextMenu

        function openMenu(x,y) {
            open()
            contextMenu.x = x - contextMenu.width
            contextMenu.y = y
        }

        ContextMenuItem {
            text: qsTr("Language")
            onTriggered: {
                //componentsLoader.loadConnection()
            }
        }

        ContextMenuItem {
            text: qsTr("About")
            onTriggered: {
                dialogAbout.open()
            }
        }

        ContextMenuItem {
            text: qsTr("Quit", "Выход")

            onTriggered: {
                dialogQuit.open()
            }
        }
    }
}



