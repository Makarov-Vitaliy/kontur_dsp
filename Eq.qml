import QtQuick 2.15
import QtCharts 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

Item{

   id: root

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
            id: eqCard
            Layout.preferredHeight: 100
            Layout.preferredWidth: parent.width

            ChartView {
                id: chart
                visible: true
                backgroundRoundness: 0
                anchors.fill: parent

                // plotArea: Qt.rect(10, 10,  300 - 20, 200-20)
                plotArea :  Qt.rect(10, 10,  parent.width - 20, parent.height-40)

                onPlotAreaChanged: {
                    //  axis_y.max= 40
                    //  axis_y.min= -20
                }

                //needRender: true
                Component.onCompleted: {
                    graph1.append(30,23)
                    graph1.append(100,13)
                    graph1.append(3000,-13)
                    graph1.append(10000,1)
                    // plotArea=  Qt.rect(10, 10,  parent.width - 20, parent.height-20)
                }

                onVisibleChanged:  {

                    plotArea= Qt.rect(10, 10,  parent.width - 20, parent.height-20)
                    //  axis_y.rangeChanged(-30,40)
                }
                onWidthChanged: {
                    // axis_y.rangeChanged(-30,40)
                    plotArea= Qt.rect(10, 10,  parent.width - 20, parent.height-20)
                }
                onHeightChanged: {
                    //axis_y.rangeChanged(-30,40)
                    axis_y.gridVisible=false
                    axis_y.gridVisible=true

                    plotArea= Qt.rect(10, 10,  parent.width - 20, parent.height-20)
                }

                antialiasing: true
                legend.visible: false
                backgroundColor: "transparent"

                AreaSeries {
                    id: area_filter1
                    color: "#66FDD835"
                    borderColor: "#66FDD835"
                    borderWidth: 0
                    axisX: axis_x
                    axisY: axis_y

                    upperSeries: LineSeries {
                        id: graph1
                    }

                    lowerSeries: LineSeries{
                        XYPoint { x:  20; y: 0}
                        XYPoint { x:  22000; y: 0 }
                    }
                }

                //        AreaSeries {
                //            id: area_filter2
                //            color: "#6605C6F9"
                //            borderColor: "#6605C6F9"
                //            borderWidth: 0
                //            axisX: axis_x
                //            axisY: axis_y

                //            upperSeries: LineSeries {
                //                id: graph2
                //            }

                //            lowerSeries: LineSeries{
                //                XYPoint { x:  1; y: 0}
                //                XYPoint { x:  22000; y: 0 }
                //            }

                //        }

                //        AreaSeries {
                //            id: area_filter3
                //            color: "#66FF0002"
                //            borderColor: "#66FF0002"
                //            borderWidth: 1
                //            axisX: axis_x
                //            axisY: axis_y

                //            upperSeries: LineSeries {
                //                id: graph3
                //            }

                //            lowerSeries: LineSeries{
                //                XYPoint { x:  1; y: 0}
                //                XYPoint { x:  22000; y: 0 }
                //            }
                //        }

                //        AreaSeries {
                //            id: area_filter4
                //            color: "#6607E075"
                //            borderColor: "#6607E075"
                //            borderWidth: 0
                //            axisX: axis_x
                //            axisY: axis_y

                //            upperSeries: LineSeries {
                //                id: graph4
                //            }

                //            lowerSeries: LineSeries{
                //                XYPoint { x:  1; y: 0}
                //                XYPoint { x: 22000; y: 0 }
                //            }
                //        }

                //    LineSeries {
                //        id: vline
                //        width: 1
                //        property double xpos: 0;
                //        useOpenGL: false
                //        XYPoint { x: vline.xpos; y:  parametricEQ.minGainDbLevel()}
                //        XYPoint { x: vline.xpos; y:  parametricEQ.maxGainDbLevel() }
                //        color: colorScheme[activeBand]
                //    }

                //    LineSeries {
                //        id: graph
                //        width: 1
                //        useOpenGL: false
                //        color: "#777777"
                //    }

                LogValueAxis {
                    id: axis_x
                    base: 10
                    labelsVisible: false

                    gridVisible:true
                    minorGridVisible: true
                    minorTickCount: -1
                    lineVisible: true
                    min: 20
                    max: 22000//plotArea.width

                }

                ValueAxis {
                    id: axis_y
                    labelsVisible: false
                    gridVisible: true
                    lineVisible: true
                    minorTickCount: -1
                    minorGridVisible: true
                    min:  -40
                    max:  +20
                }
            }

        }

        CardBase{
            id: dataCard
            Layout.preferredHeight: 80
            Layout.preferredWidth: parent.width
            Layout.fillHeight: true
        }

        CardBase{
            id: sCard
            Layout.preferredHeight: 90
            Layout.preferredWidth: parent.width

            Column{

                EqSliderRow{
                    width: sCard.width
                    height: 30
                    text_label: qsTr("Gain:","Усиление:")
                    text_value: sliderObj.value
                }

                EqSliderRow{
                    width: sCard.width
                    height: 30
                    text_label: qsTr("Freq:","Частота:")
                    text_value: sliderObj.value
                }

                EqSliderRow{
                    width: sCard.width
                    height: 30
                    text_label: "Q:"
                    text_value: sliderObj.value
                }
            }
        }

        CardBase{
            id: channelCard
            Layout.preferredHeight: 90
            Layout.preferredWidth: parent.width

            GridView {
                id: grid
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
                cellWidth: (grid.width)/4
                cellHeight: grid.height/2
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
                    width: grid.cellWidth
                    height: grid.cellHeight

                    ButtonText {
                        id: btn
                        width: 80
                        height: 40
                        checkable: true
                        ButtonGroup.group: btnChannelGroup
                        anchors.centerIn: parent
                        text: name
                        checked: grid.currentIndex===index

                        onPressAndHold: {
                            dialog.open_channel_rename(index,btn.text)
                        }
                    }
                }
            }
        }
    }
}
