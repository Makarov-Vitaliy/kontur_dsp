import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item{

    property int default_dim: 0
    property int channel_count: 10

    Rectangle{
        anchors.fill: parent

        gradient: Gradient {
            GradientStop { position: 0.0; color: "#2c2f36" }
            GradientStop { position: 1.0; color: "#1c1f26" }
        }
    }

    GridView{
        id: grid

        anchors{
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: dimension_card.top
            bottomMargin: 3
        }

        clip: true
        cellWidth: (grid.width)/2
        cellHeight: grid.height/4

        Component {
            id: contactsDelegate

            Item{
                width: grid.cellWidth
                height: grid.cellHeight

                CardBase{
                    id: card
                    width: grid.cellWidth-7
                    height: grid.cellHeight-7
                    anchors.centerIn: parent

                    DelayControls{
                        width: parent.width
                        height: parent.height
                        text: name
                    }
                }
            }
        }

        model: channels
        delegate: contactsDelegate
    }

    CardBase{
        id: dimension_card
        anchors{
            bottom: parent.bottom
            left: parent.left
            leftMargin: 2
            rightMargin: 2
            right: parent.right
        }

        height: 40

        ButtonGroup{
            id: btnGroup
        }

        Item{
            width: dimension_card.width
            height: dimension_card.height

            Row{
                id: btn_row

                anchors{
                    verticalCenter: parent.verticalCenter
                    horizontalCenter: parent.horizontalCenter
                }

                spacing: 5

                Repeater{
                    model: ["ms","m", "in"]

                    ButtonText{
                        checkable: true
                        text: modelData
                        width: dimension_card.width/3 -btn_row.spacing*3
                        height: dimension_card.height-5
                        ButtonGroup.group: btnGroup

                        Component.onCompleted: {
                            if (index==default_dim) {
                                checked=true
                            }
                        }
                    }
                }
            }
        }
    }
}
