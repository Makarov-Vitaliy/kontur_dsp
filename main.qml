import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15
import QtQuick.Controls.Material 2.1


ApplicationWindow {
    id: app
    width: 360
    height: 640
    visible: true
    title: qsTr("KonturDSP")
    color: "#1c1f26"

    readonly property real max_delay_ms: 8.00
    property int animationTime: 150
    readonly property string source_body: "qrc:/Resources/"
    readonly property var menu_string: ["Main", "Delay", "EQ",  "Mixer"] //"Output",

    Component.onCompleted: {
        testTimer.start()
    }

    Header{
        id: header
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }

        text: menu_string[menu_swipe.currentIndex]
    }

    SwipeView {
        id: mswipe
        interactive: false

        states:[

            State {
                name: "connecting"
                PropertyChanges { target: mswipe; currentIndex: 1 }
                PropertyChanges { target: list; enabled: false }
            },

            State {
                name: "disconnected"
                PropertyChanges { target: mswipe; currentIndex: 0 }
                PropertyChanges { target: list; enabled: false }
            },

            State {
                name: "connected"
                PropertyChanges { target: mswipe; currentIndex: 2 }
                PropertyChanges { target: list; enabled: true }
            }

        ]

        anchors {
            top: header.bottom
            topMargin: 1
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        currentIndex: 1

        FailConnection{

            onClicked: {
                 mswipe.state="connecting"
                testTimer.conn=true
                testTimer.start()
            }
        }

        LoadingScreen{
            visible: true
            message: qsTr("Connecting...","Подключение...")
        }

        SwipeView {
            id: menu_swipe

            currentIndex: 0

            onCurrentIndexChanged: {
                menu_swipe.currentIndex
            }

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

                       spacing: 2

                       CardMainVolume{
                           Layout.preferredWidth: parent.width-10
                           Layout.alignment: Qt.AlignHCenter
                           Layout.preferredHeight: 100
                           Layout.fillHeight: true
                       }


                       CardBase{
                           id: preset_container
                           Layout.preferredWidth: parent.width-10
                           Layout.alignment: Qt.AlignHCenter
                           Layout.preferredHeight: columnPreset.implicitHeight

                           Column {
                               id: columnPreset

                               LabelMain{
                                   text: qsTr("Presets")
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
                                   width: preset_container.width
                                   height: 70

                                   ListView {
                                       id: presetList
                                       clip: true
                                       anchors{
                                           left: parent.left
                                           right: parent.right
                                           leftMargin: 5
                                           rightMargin: 5
                                           top: parent.top
                                           bottom: parent.bottom
                                           bottomMargin: 10
                                       }
                                      // height: parent.height
                                       orientation: Qt.Horizontal
                                       model: presets
                                       spacing: 5


                                       ScrollBar.horizontal: ScrollBar {
                                           height: 5
                                           active: true
                                       }

                                       delegate: ButtonText {
                                           width: (presetList.width)/3  - presetList.spacing
                                           height: 50
                                           anchors.verticalCenter: parent ? parent.verticalCenter : undefined
                                           text: name
                                           onPressAndHold: {
                                               dialog.open_preset_rename(index,name)
                                              // dialogs.showRenameDialog()
                                           }
                                       }
                                   }
                               }
                           }
                       }
                   }
               }

               DelayMenu{

               }

               Eq{
                   id: eq
               }

               MixerMenu{
                   id: mixer
               }


           }
 }

    Timer{
        id: testTimer
        property bool conn: false
        interval: 1000

        onTriggered: {
            if (!conn) {
                mswipe.state="disconnected"
            } else {
                mswipe.state="connected"
            }
        }
    }

    footer: Item{
        height: 60
        width: parent.width

        Rectangle{
            anchors{

                fill: parent
                leftMargin: 3
                rightMargin: 3
                topMargin: 3
                bottomMargin: 3
            }
            radius: 15
            color: "#3a4a61"

            ListView{
                id: list

                readonly property int m_margins: 4
                readonly property int num_buttons: 4
                readonly property var res:["main.png","delay.png","eq.png","mixer.png"] //"output.png"

                enabled: false

                anchors{
                    left:parent.left
                    right: parent.right
                    leftMargin: m_margins
                    rightMargin: m_margins
                }

                height: parent.height
                clip: true
                model: menu_string
                spacing: 5
                orientation: Qt.Horizontal
                currentIndex:  enabled ? menu_swipe.currentIndex :  -1

                delegate: ButtonMenu{
                    text: modelData
                    width: (list.width+list.m_margins)/list.num_buttons -list.spacing
                    height: list.height
                    checked: list.currentIndex===index
                    ButtonGroup.group: btnGroup
                    image:  source_body+ list.res[index]

                    onClicked: {
                         menu_swipe.currentIndex=index
                    }
                }


            }
        }
    }

    ButtonGroup{
        id: btnGroup
    }

    //Старая реализация на Loader
    DialogCustom{
        id: dialogs
        anchors.fill: parent

    }

    Dialog {
        id: dialog
        anchors.centerIn: parent
        modal: true
        Material.accent: "#5594f1"
        standardButtons: Dialog.Ok | Dialog.Cancel
        property var accepted_callback

        function open_channel_rename(mindex, value) {
            textInput.text=""
            textInput.placeholderText=value
            accepted_callback=()=> {
                channels.set_channel_name(mindex,textInput.text)
            }
            title=qsTr("Enter new name of channel")
            dialog.open()
        }

        function open_preset_rename(mindex, value) {
            textInput.text=""
            textInput.placeholderText=value
            title=qsTr("Enter new name of preset")
            accepted_callback=()=> {
                presets.set_preset_name(mindex,textInput.text)
            }
            dialog.open()
        }

        onAccepted: {
            accepted_callback()
        }

        Overlay.modal: Rectangle{
            anchors.fill: parent
            color: "#A0000000"
        }

        onVisibleChanged: {
            if (visible) {
                textInput.forceActiveFocus()
                dialog.standardButton(Dialog.Ok).text = qsTr("Ok")
                dialog.standardButton(Dialog.Cancel).text = qsTr("Cancel")
            }
        }

        contentItem:
            TextField {
                id: textInput
                inputMethodHints: Qt.ImhNoPredictiveText
                focus: true
                font.pixelSize: 20
            }
    }

    Dialog {
        id: dialogAbout

        anchors.centerIn: parent
        modal: true
        width: 250
        height: 200
        Material.accent: "#5594f1"
        title:  qsTr("About KonturDSP")
        standardButtons: Dialog.Ok

       Text {
            font.pixelSize: 16
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width-10
            color: "#b0b7c1"

            text: qsTr("Bla-Bla-BlaBla-Bla. www.kontur-audio.ru")
            wrapMode : Text.WordWrap
        }

        Overlay.modal: Rectangle{
            anchors.fill: parent
            color: "#A0000000"
        }

        onVisibleChanged: {
            if (visible) {
                dialogAbout.standardButton(Dialog.Ok).text = qsTr("Ok")
               // dialogQuit.standardButton(Dialog.Cancel).text = qsTr("Cancel")
            }
        }
    }

    Dialog {
        id: dialogQuit
        anchors.centerIn: parent
        modal: true
        Material.accent: "#5594f1"
        title:  qsTr("Do you really want to quit?")
        standardButtons: Dialog.Ok | Dialog.Cancel


        onAccepted: {
           Qt.quit()
        }

        Overlay.modal: Rectangle{
            anchors.fill: parent
            color: "#A0000000"
        }

        onVisibleChanged: {
            if (visible) {
                dialogQuit.standardButton(Dialog.Ok).text = qsTr("Ok")
                dialogQuit.standardButton(Dialog.Cancel).text = qsTr("Cancel")
            }
        }
    }
}
