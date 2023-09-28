import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item{

    Rectangle{
        anchors.fill: parent

        gradient: Gradient {
            GradientStop { position: 0.0; color: "#2c2f36" }
            GradientStop { position: 1.0; color: "#1c1f26" }
        }
    }

    ColumnLayout{
        anchors.fill: parent
        anchors.margins: 3

        CardBase{
            id: sCard
            Layout.preferredHeight: 400
            Layout.preferredWidth: parent.width

            GridView{
                id: grid

                anchors{
                    top: parent.top
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                    bottomMargin: 3
                }

                clip: true
                cellWidth: (grid.width)/2
                cellHeight: grid.height/4

                Component {
                    id: delayDelegate

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
                delegate: delayDelegate
            }
        }

         CardBase{
            id: channelCard
            Layout.preferredHeight: 90
            Layout.preferredWidth: parent.width

            GridView {
                id: gridch
                clip: true

                anchors{
                    left: parent.left
                    right: parent.right
                    leftMargin: 7
                    rightMargin: 7
                    top: parent.top
                    topMargin: 3
                    bottom: parent.bottom
                    bottomMargin: 5
                }

                flow: GridView.FlowTopToBottom
                layoutDirection: GridView.LeftToRight
                cellWidth: (gridch.width)/4
                cellHeight: gridch.height/2
                model: channels
                currentIndex: channels.length!==0 ? 0 : -1

                ScrollBar.horizontal: ScrollBar {
                    height: 5
                    active: true
                }

                ButtonGroup{
                    id: btnChannelGroup
                }

                delegate: Item{
                    width: gridch.cellWidth
                    height: gridch.cellHeight

                    ButtonText {
                        id: btn
                        width: 80
                        height: 40
                        checkable: true
                        ButtonGroup.group: btnChannelGroup
                        anchors.centerIn: parent
                        text: name
                        checked: gridch.currentIndex===index

                        onPressAndHold: {
                            dialog.open_channel_rename(index,btn.text)
                        }
                    }
                }
            }
        }
    }
}
