import QtQuick 2.15


Item {
    id: dialogsRoot

    property var message


    function showRenameDialog() {
        dialogLoader.sourceComponent = renameCH
    }

    Rectangle {
        id: background
        anchors.fill: parent
        color: "#A0000000"
        visible: false

        MouseArea{
            anchors.fill: parent
        }

        Loader{
            id: dialogLoader
            anchors.centerIn: parent

            onSourceComponentChanged: {
                if(sourceComponent) {
                    hideAnim.stop()
                    showAnim.start()
                } else {
                    showAnim.stop()
                    hideAnim.start()
                }
            }

            Component {
                id: renameCH

                TextInputDialog {
                    title: qsTr("Enter new name of channel")
                    onRejected: {
                        dialogLoader.sourceComponent=null
                    }

                    onAccepted: {
                        if (text.trim().length!==0) {
                                   dialogLoader.sourceComponent=null
                        }
                    }
                }
            }
        }
    }

    SequentialAnimation{
        id: hideAnim
        NumberAnimation{target: background; properties: "opacity"; from: 1; to: 0; duration: animationTime}
        ScriptAction{script: background.visible = false}
    }

    SequentialAnimation{
        id: showAnim
        ScriptAction{script: background.visible = true}
        NumberAnimation{target: background; properties: "opacity"; from: 0; to: 1; duration: animationTime}
    }
}
