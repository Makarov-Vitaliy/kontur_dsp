import QtQuick 2.15
import QtQuick.Controls 2.15

MenuItem {
    id: root

    property color activeBackgroundColor: "#2c2f36"
    property color passiveBackgroundColor: "#2c2f36"//"#1c1f26"

    implicitWidth: 220
    implicitHeight: 50

    arrow: Item {}

    indicator: Item {}

    contentItem: Text {
        anchors.fill: parent
        leftPadding: 16
        rightPadding: root.arrow.width + root.arrow.anchors.rightMargin
        text: root.text

        font {
            pixelSize: 14
        }

        opacity: enabled ? 1.0 : 0.3
        color: root.highlighted ? "#5794ef": (root.checked ? "#5794ef"
                                                           : "#FFFFFF")
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        implicitWidth: root.implicitWidth
        implicitHeight: root.implicitHeight
        color: (root.highlighted || root.checked) ? activeBackgroundColor : passiveBackgroundColor
    }
}
