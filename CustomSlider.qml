import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.1
import QtQuick.Controls.Material.impl 2.1
import QtGraphicalEffects 1.15

Slider {
    id: control
    property int borderWidth: 1
    snapMode: Slider.SnapAlways

    background: Rectangle {
        x: control.leftPadding + (horizontal ? 0 : (control.availableWidth - width) / 2)
        y: control.topPadding + (horizontal ? (control.availableHeight - height) / 2 : 0)
        implicitWidth: horizontal ? control.width : control.height
        implicitHeight: horizontal ?   control.height : control.width
        width: horizontal ? control.availableWidth : 4+2*borderWidth
        height: horizontal ? 4: control.availableHeight
        color: "#474747"
        //scale: horizontal && control.mirrored ? -1 : 1
        radius: 5

        border{
            color: "#4e555f"//"#a5a6a7"
            width: borderWidth
        }

//        layer{
//            enabled: true

//            effect: DropShadow {
//                transparentBorder: true
//                horizontalOffset: 3
//                verticalOffset: 3
//                radius: 4.0
//                samples: 9
//                color: "#AA000000"
//            }
//        }


        Rectangle {
            x: control.horizontal ? 0 : (parent.width - width) / 2
            y: control.horizontal ? (parent.height - height) / 2 : control.visualPosition * parent.height-3
            width: control.horizontal ? control.position * parent.width : 2
            height: control.horizontal ? 2 : control.position * parent.height
            color: "#407cfe"//control.enabled ? "#5594f1" : "#5594f1" //TODO?
            radius: 3
        }
    }

    handle: Item {
        id: handle_slider
        width: 1
        height: 1


        x: control.leftPadding  + (horizontal ? control.visualPosition * (control.availableWidth) - width/2 : (control.availableWidth - width) / 2)
        y: control.topPadding  + (horizontal ? (control.availableHeight - height) / 2 : control.visualPosition * (control.availableHeight)- height/2)
        property real value:  control.value
        property bool handlePressed: control.pressed
        readonly property bool horizontal: control.horizontal
        readonly property var control: parent

        Rectangle{
            width: 14
            height: 24
            radius: 3
            rotation: parent.horizontal ? 90 : 0
            anchors.centerIn: parent

            gradient: Gradient {
                GradientStop { position: 0.0; color: "#f1f1f1" }
                GradientStop { position: 1.0; color: "#a4a4a4" }
            }

            border{
                color: "#a5a6a7"
                width: borderWidth
            }

//            Behavior on scale {
//                NumberAnimation {
//                    duration: 250
//                }
//            }

            Rectangle{
                id: center_rect
                width:  parent.width//parent.horizontal ? 0.7*parent.width : parent.width
                height: 0.7*parent.height//parent.horizontal ? parent.height : 0.7*parent.height
                radius: 1

                anchors{
                    centerIn: parent
                }

                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#a4a4a4" }
                    GradientStop { position: 1.0; color: "#f1f1f1" }
                }

                Repeater{
                    anchors.fill: parent
                    model: 3


                    Rectangle{
                        width: parent.width-(index!=1 ? 8: 4)
                        radius: 1
                        height: 1
                        color: "#646464"
                        anchors{
                            horizontalCenter: parent.horizontalCenter
                            verticalCenter: parent.verticalCenter
                            verticalCenterOffset: {
                                var d=[-4,0,4]
                                return d[index]
                            }
                        }
                    }
                }
            }
        }
    }
}
