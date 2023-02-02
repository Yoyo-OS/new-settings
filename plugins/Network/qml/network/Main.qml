/*
 * Copyright (C) 2021 YoyoOS Team.
 *
 * Author:     rekols <aj@yoyoos.com>
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
import Yoyo.NetworkManagement 1.0 as NM

import "../../"

ItemPage {
    id: control
    headerTitle: qsTr("Ethernet")

    property var itemHeight: 45
    property var settingsMap: ({})

    NM.Handler {
        id: handler
    }

    NM.WifiSettings {
        id: wifiSettings
    }

    NM.NetworkModel {
        id: networkModel
    }

    NM.EnabledConnections {
        id: enabledConnections
    }

    NM.IdentityModel {
        id: connectionModel
    }

    NM.Configuration {
        id: configuration
    }

    NewNetworkDialog {
        id: newNetworkDialog

        onConnect: {
            wifiSettings.addOtherConnection(ssid, username, pwd, type)
        }
    }

    Component.onCompleted: {
        handler.requestScan()
    }

    Timer {
        id: scanTimer
        interval: 10200
        repeat: true
        running: control.visible
        onTriggered: handler.requestScan()
    }

    Scrollable {
        anchors.fill: parent
        contentHeight: mainLayout.implicitHeight

        ColumnLayout {
            id: mainLayout
            anchors.fill: parent
            anchors.bottomMargin: Youi.Units.largeSpacing
            spacing: Youi.Units.largeSpacing * 2

            // Wired connection
            RoundedItem {
                visible: enabledConnections.wwanHwEnabled
                spacing: Youi.Units.largeSpacing

                RowLayout {
                    spacing: Youi.Units.largeSpacing

                    Label {
                        text: qsTr("Ethernet")
                        color: Youi.Theme.disabledTextColor
                        Layout.fillWidth: true
                    }

                    Switch {
                        Layout.fillHeight: true
                        rightPadding: 0
                        checked: enabledConnections.wwanEnabled
                        onCheckedChanged: {
                            if (checked) {
                                if (!enabledConnections.wwanEnabled) {
                                    handler.enableWwan(checked)
                                }
                            } else {
                                if (enabledConnections.wwanEnabled) {
                                    handler.enableWwan(checked)
                                }
                            }
                        }
                    }
                }

                ListView {
                    id: wiredView

                    visible: enabledConnections.wwanEnabled && wiredView.count > 0

                    Layout.fillWidth: true
                    Layout.preferredHeight: wiredView.count * control.itemHeight
                    interactive: false
                    clip: true

                    model: NM.AppletProxyModel {
                        type: NM.AppletProxyModel.WiredType
                        sourceModel: connectionModel
                    }

                    ScrollBar.vertical: ScrollBar {}

                    delegate: WiredItem {
                        height: control.itemHeight
                        width: wiredView.width
                    }
                }
            }

            RoundedItem {
                WifiView {
                    Layout.fillWidth: true
                    visible: enabledConnections.wirelessHwEnabled
                }
            }

            Button {
                Layout.fillWidth: true
                text: qsTr("Add other...")
                onClicked: newNetworkDialog.show()
            }

            Item {
                height: Youi.Units.largeSpacing
            }
        }
    }
}
