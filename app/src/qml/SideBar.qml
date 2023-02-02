/*
 * Copyright (C) 2021 YoyoOS Team.
 *
 * Author:     revenmartin <revenmartin@gmail.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.4
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import Youi 1.0 as Youi

Item {
    implicitWidth: 230

    property int itemRadiusV: 8

    property alias view: listView
    property alias currentIndex: listView.currentIndex
    property color wallpaperColor

    property var category: [qsTr("Network and connection"),qsTr("Display and appearance"),qsTr("System"),qsTr("Test")]
    Rectangle {
        anchors.fill: parent
        color: Youi.Theme.darkMode ? Qt.lighter(Youi.Theme.backgroundColor, 1.5)
                                     : Qt.darker(Youi.Theme.backgroundColor, 1.05)
        opacity: rootWindow.compositing ? 0.7 : 1.0

        Behavior on color {
            ColorAnimation {
                duration: 250
                easing.type: Easing.Linear
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 0
        spacing: 0

        anchors.topMargin: rootWindow.header.height

        ListView {
            id: listView
            Layout.fillHeight: true
            Layout.fillWidth: true
            clip: true
            model: dataObjectModel

            spacing: Youi.Units.smallSpacing
            leftMargin: Youi.Units.largeSpacing
            rightMargin: Youi.Units.largeSpacing
            topMargin: 0
            bottomMargin: Youi.Units.largeSpacing

            ScrollBar.vertical: ScrollBar {}

            highlightFollowsCurrentItem: true
            highlightMoveDuration: 0
            highlightResizeDuration : 0
            highlight: Rectangle {
                radius: Youi.Theme.smallRadius
                color: Qt.rgba(Youi.Theme.textColor.r,
                               Youi.Theme.textColor.g,
                               Youi.Theme.textColor.b, 0.05)
                smooth: true
            }

            section.property: "category"
            section.delegate: Item {
                width: ListView.view.width - ListView.view.leftMargin - ListView.view.rightMargin
                height: Youi.Units.fontMetrics.height + Youi.Units.largeSpacing + Youi.Units.smallSpacing

                Text {
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.leftMargin: Qt.application.layoutDirection === Qt.RightToLeft ? 0 : Youi.Units.smallSpacing
                    anchors.rightMargin: Youi.Units.smallSpacing
                    anchors.topMargin: Youi.Units.largeSpacing
                    anchors.bottomMargin: Youi.Units.smallSpacing
                    color: Youi.Theme.disabledTextColor
                    font.pointSize: 8
                    text: category[section]
                }
            }

            Youi.WheelHandler {
                target: listView
            }

            delegate: Item {
                id: item
                width: ListView.view.width - ListView.view.leftMargin - ListView.view.rightMargin
                height: 35

                property bool isCurrent: listView.currentIndex === index

                Rectangle {
                    anchors.fill: parent

                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        acceptedButtons: Qt.LeftButton
                        onClicked: listView.currentIndex = index
                    }

                    radius: Youi.Theme.smallRadius
                    color: mouseArea.pressed ? Qt.rgba(Youi.Theme.textColor.r,
                                                       Youi.Theme.textColor.g,
                                                       Youi.Theme.textColor.b, Youi.Theme.darkMode ? 0.05 : 0.1) :
                           mouseArea.containsMouse || isCurrent ? Qt.rgba(Youi.Theme.textColor.r,
                                                                          Youi.Theme.textColor.g,
                                                                          Youi.Theme.textColor.b, Youi.Theme.darkMode ? 0.1 : 0.05) :
                                                                  "transparent"

                    smooth: true
                }

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: Youi.Units.smallSpacing
                    spacing: Youi.Units.smallSpacing

                    Rectangle {
                        id: iconRect
                        width: 26
                        height: 26
                        Layout.alignment: Qt.AlignVCenter
                        radius: width /2
                        //color: model.iconColor
                        color: Youi.Theme.highlightColor

                        Label{
                            id: icon
                            anchors.centerIn: parent
                            text: model.iconId
                            font.family: "FluentSystemIcons-Regular"
                            color: "#FFFFFF"
                            font.pixelSize: 16
                            Layout.alignment: Qt.AlignVCenter
                            antialiasing: false
                            smooth: false
                        }
                    }

                    Label {
                        id: itemTitle
                        text: model.title
                        color: Youi.Theme.darkMode ? Youi.Theme.textColor : "#363636"
                        font.pointSize: 8
                    }

                    Item {
                        Layout.fillWidth: true
                    }
                }
            }
        }
    }

    function removeItem(name) {
        for (var i = 0; i < listModel.count; ++i) {
            if (name === listModel.get(i).name) {
                listModel.remove(i)
                break
            }
        }
    }

}
