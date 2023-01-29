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
import FishUI 1.0 as FishUI

Item {
    implicitWidth: 230

    property int itemRadiusV: 8

    property alias view: listView
    property alias currentIndex: listView.currentIndex
    property color wallpaperColor

    property var category: [qsTr("Network and connection"),qsTr("Display and appearance"),qsTr("System"),qsTr("Test")]
    Rectangle {
        anchors.fill: parent
        color: FishUI.Theme.darkMode ? Qt.lighter(FishUI.Theme.backgroundColor, 1.5)
                                     : Qt.darker(FishUI.Theme.backgroundColor, 1.05)
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

        Label {
            text: rootWindow.title
            color: rootWindow.active ? FishUI.Theme.textColor : FishUI.Theme.disabledTextColor
            Layout.preferredHeight: rootWindow.header.height
            leftPadding: FishUI.Units.largeSpacing + FishUI.Units.smallSpacing
            rightPadding: FishUI.Units.largeSpacing + FishUI.Units.smallSpacing
            topPadding: FishUI.Units.smallSpacing
            bottomPadding: 0
            font.pointSize: 13
        }

        ListView {
            id: listView
            Layout.fillHeight: true
            Layout.fillWidth: true
            clip: true
            model: dataObjectModel

            spacing: FishUI.Units.smallSpacing
            leftMargin: FishUI.Units.largeSpacing
            rightMargin: FishUI.Units.largeSpacing
            topMargin: 0
            bottomMargin: FishUI.Units.largeSpacing

            ScrollBar.vertical: ScrollBar {}

            highlightFollowsCurrentItem: true
            highlightMoveDuration: 0
            highlightResizeDuration : 0
            highlight: Rectangle {
                radius: FishUI.Theme.mediumRadius
                color: Qt.rgba(FishUI.Theme.textColor.r,
                               FishUI.Theme.textColor.g,
                               FishUI.Theme.textColor.b, 0.05)
                smooth: true
            }

            section.property: "category"
            section.delegate: Item {
                width: ListView.view.width - ListView.view.leftMargin - ListView.view.rightMargin
                height: FishUI.Units.fontMetrics.height + FishUI.Units.largeSpacing + FishUI.Units.smallSpacing

                Text {
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.leftMargin: Qt.application.layoutDirection === Qt.RightToLeft ? 0 : FishUI.Units.smallSpacing
                    anchors.rightMargin: FishUI.Units.smallSpacing
                    anchors.topMargin: FishUI.Units.largeSpacing
                    anchors.bottomMargin: FishUI.Units.smallSpacing
                    color: FishUI.Theme.disabledTextColor
                    font.pointSize: 8
                    text: category[section]
                }
            }

            FishUI.WheelHandler {
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

                    radius: FishUI.Theme.mediumRadius
                    color: mouseArea.pressed ? Qt.rgba(FishUI.Theme.textColor.r,
                                                       FishUI.Theme.textColor.g,
                                                       FishUI.Theme.textColor.b, FishUI.Theme.darkMode ? 0.05 : 0.1) :
                           mouseArea.containsMouse || isCurrent ? Qt.rgba(FishUI.Theme.textColor.r,
                                                                          FishUI.Theme.textColor.g,
                                                                          FishUI.Theme.textColor.b, FishUI.Theme.darkMode ? 0.1 : 0.05) :
                                                                  "transparent"

                    smooth: true
                }

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: FishUI.Units.smallSpacing
                    spacing: FishUI.Units.smallSpacing

                    Rectangle {
                        id: iconRect
                        width: 26
                        height: 26
                        Layout.alignment: Qt.AlignVCenter
                        radius: width /2
                        //color: model.iconColor
                        color: FishUI.Theme.highlightColor

                        FishUI.MaterialIcons{
                            id: icon
                            anchors.centerIn: parent
                            iconId: model.iconId
                            //iconId: "\ue30a"
                            color: "#FFFFFF"
                            iconSize: 12
                            Layout.alignment: Qt.AlignVCenter
                            antialiasing: false
                            smooth: false
                        }
                    }

                    Label {
                        id: itemTitle
                        text: model.title
                        color: FishUI.Theme.darkMode ? FishUI.Theme.textColor : "#363636"
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
