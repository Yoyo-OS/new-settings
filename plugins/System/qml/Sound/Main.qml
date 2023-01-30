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

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import FishUI 1.0 as FishUI
import Yoyo.Settings 1.0
import Yoyo.Audio 1.0
import "../../"

ItemPage {
    headerTitle: qsTr("Sound")

    function audioIcon(value) {
        if (value <= 0)
            return "\ueb4d"
        else if (value <= 25)
            return "\ueb3b"
        else if (value <= 75)
            return "\ueb40"
        else
            return "\ueb46"
    }

    function microphoneIcon(value) {
        if (value <= 25)
            return "audio-input-microphone-low-symbolic"
        else if (value <= 70)
            return "audio-input-microphone-medium-symbolic"
        else
            return "audio-input-microphone-high-symbolic"
    }

    SinkModel {
        id: paSinkModel
    }

    SourceModel {
        id: paSourceModel
    }

    PulseObjectFilterModel {
        id: paSinkFilterModel
        sortRole: "SortByDefault"
        sortOrder: Qt.DescendingOrder
        filterOutInactiveDevices: true
        sourceModel: paSinkModel
    }

    PulseObjectFilterModel {
        id: paSourceFilterModel
        sortRole: "SortByDefault"
        sortOrder: Qt.DescendingOrder
        filterOutInactiveDevices: true
        sourceModel: paSourceModel
    }

    Scrollable {
        anchors.fill: parent
        contentHeight: layout.implicitHeight

        ColumnLayout {
            id: layout
            anchors.fill: parent

            Label {
                text: qsTr("Output Devices")
                leftPadding: FishUI.Units.largeSpacing
                bottomPadding: FishUI.Units.smallSpacing
                color: FishUI.Theme.disabledTextColor
                visible: sinks.count >= 1
            }

            // Playback Devices
            ListView {
                id: sinks
                Layout.fillWidth: true
                interactive: false
                spacing: FishUI.Units.largeSpacing

                Layout.preferredHeight: {
                    var totalHeight = 0
                    for (var i = 0; i < sinks.visibleChildren.length; ++i) {
                        totalHeight += sinks.visibleChildren[i].height
                    }
                    return totalHeight
                }

                model: paSinkFilterModel

                delegate: Item {
                    width: ListView.view.width
                    height: _itemLayout.implicitHeight + FishUI.Units.largeSpacing * 2

                    readonly property var currentPort: Ports[ActivePortIndex]

                    Rectangle {
                        anchors.fill: parent
                        color: FishUI.Theme.secondBackgroundColor
                        radius: FishUI.Theme.bigRadius
                    }

                    ColumnLayout {
                        id: _itemLayout
                        anchors.fill: parent
                        anchors.margins: FishUI.Units.largeSpacing
                        spacing: FishUI.Units.largeSpacing

                        Label {
                            text: !currentPort ? Description : currentPort.description
                        }

                        RowLayout {
                            spacing: FishUI.Units.largeSpacing

                            Label{
                                font.family: "FluentSystemIcons-Regular"
                                color: FishUI.Theme.textColor
                                font.pixelSize: 16
                                antialiasing: false
                                smooth: false
                                text: audioIcon(slider.value / slider.to * 100)
                            }

                            Slider {
                                id: slider
                                Layout.fillWidth: true
                                value: Volume
                                from: PulseAudio.MinimalVolume
                                to: PulseAudio.NormalVolume
                                enabled: VolumeWritable
                                visible: HasVolume

                                ToolTip {
                                    parent: slider.handle
                                    visible: slider.pressed
                                    text: (slider.value / slider.to * 100).toFixed(0)
                                }

                                onMoved: {
                                    Volume = value
                                    Muted = (value === 0)
                                }
                            }
                        }
                    }
                }
            }

            Item {
                height: FishUI.Units.largeSpacing * 2
            }

            Label {
                text: qsTr("Input Devices")
                leftPadding: FishUI.Units.largeSpacing
                bottomPadding: FishUI.Units.smallSpacing
                color: FishUI.Theme.disabledTextColor
                visible: sinkInputView.count >= 1
            }

            // Recording Devices
            ListView {
                id: sinkInputView
                Layout.fillWidth: true
                Layout.preferredHeight: contentHeight

                interactive: false
                spacing: FishUI.Units.largeSpacing
                model: paSourceFilterModel

                delegate: Item {
                    width: ListView.view.width
                    height: _layout.implicitHeight + FishUI.Units.largeSpacing * 2

                    readonly property var currentPort: Ports[ActivePortIndex]

                    Rectangle {
                        anchors.fill: parent
                        color: FishUI.Theme.secondBackgroundColor
                        radius: FishUI.Theme.bigRadius
                    }

                    ColumnLayout {
                        id: _layout
                        anchors.fill: parent
                        anchors.margins: FishUI.Units.largeSpacing
                        spacing: FishUI.Units.largeSpacing

                        Label {
                            text: !currentPort ? Description : currentPort.description
                        }

                        RowLayout {
                            spacing: FishUI.Units.largeSpacing

                            Image {
                                Layout.leftMargin: 2
                                height: 16
                                width: height
                                sourceSize: Qt.size(width, height)
                                source: "qrc:/images/" + (FishUI.Theme.darkMode ? "dark" : "light") + "/" + microphoneIcon(_slider.value / _slider.to * 100) + ".svg"
                                smooth: false
                                antialiasing: true
                            }

                            Slider {
                                id: _slider
                                Layout.fillWidth: true
                                value: Volume
                                from: PulseAudio.MinimalVolume
                                to: PulseAudio.NormalVolume
                                enabled: VolumeWritable
                                visible: HasVolume

                                onMoved: {
                                    Volume = value
                                    Muted = (value === 0)
                                }

                                ToolTip {
                                    parent: _slider.handle
                                    visible: _slider.pressed
                                    text: (_slider.value / _slider.to * 100).toFixed(0)
                                }
                            }
                        }
                    }
                }
            }

            Item {
                height: FishUI.Units.largeSpacing * 2
            }
        }
    }
}
