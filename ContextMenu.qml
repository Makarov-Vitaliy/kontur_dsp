import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.0
import "."

Menu {
    id: menu

    property color activeBackgroundColor: "#1c1f26"//"#fff"
    property color passiveBackgroundColor: "#2c2f36"
    property int shadowRadius: 4

    cascade: true
    topPadding: background.radius
    bottomPadding: background.radius

    delegate: ContextMenuItem {
    }

    background: Rectangle {
        id: background

        implicitWidth: 120
        implicitHeight: 40
        radius: 8
        color: menu.delegate.highlighted ? activeBackgroundColor : passiveBackgroundColor

        layer {
            enabled: true

            effect: DropShadow {
                source: background
                anchors.fill: background
                verticalOffset: 1
                horizontalOffset: 1
                radius: shadowRadius
                samples: 9
                spread: 0
                color: "#55ffffff"
            }
        }
    }
}
