/*
 * Copyright (C) 2021 YoyoOS Team.
 *
 * Author:     Kate Leet <support@yoyoos.com>
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

import Youi 1.0 as Youi
import Yoyo.Settings 1.0
import "../../"

ItemPage {
    headerTitle: qsTr("Default Applications")

    DefaultApplications {
        id: defaultApps
    }

    Scrollable {
        anchors.fill: parent
        contentHeight: layout.implicitHeight

        ColumnLayout {
            id: layout
            anchors.fill: parent
            spacing: Youi.Units.largeSpacing

            RoundedItem {
                RowLayout {

                    Label {
                        text: qsTr("Web Browser")
                        Layout.fillWidth: true
                        enabled: browserComboBox.count !== 0
                    }

                    AppComboBox {
                        id: browserComboBox
                        textRole: "name"
                        model: defaultApps.browserList
                        currentIndex: defaultApps.browserIndex
                        enabled: count !== 0
                        onActivated: {
                            defaultApps.setDefaultBrowser(browserComboBox.currentIndex)
                        }
                    }
                }
            }
            RoundedItem {
                RowLayout {
                    Label {
                        text: qsTr("File Manager")
                        Layout.fillWidth: true
                        enabled: fileManagerComboBox.count !== 0
                    }

                    AppComboBox {
                        id: fileManagerComboBox
                        textRole: "name"
                        model: defaultApps.fileManagerList
                        currentIndex: defaultApps.fileManagerIndex
                        enabled: count !== 0
                        onActivated: {
                            defaultApps.setDefaultFileManager(fileManagerComboBox.currentIndex)
                        }
                    }
                }
            }

            RoundedItem {
                RowLayout {
                    Label {
                        text: qsTr("Email Client")
                        Layout.fillWidth: true
                        enabled: emailComboBox.count !== 0
                    }

                    AppComboBox {
                        id: emailComboBox
                        textRole: "name"
                        model: defaultApps.emailList
                        currentIndex: defaultApps.emailIndex
                        enabled: count !== 0
                        onActivated: {
                            defaultApps.setDefaultEMail(emailComboBox.currentIndex)
                        }
                    }
                }
            }

            RoundedItem {
                RowLayout {
                    Label {
                        text: qsTr("Terminal")
                        Layout.fillWidth: true
                        enabled: terminalComboBox.count !== 0
                    }

                    AppComboBox {
                        id: terminalComboBox
                        textRole: "name"
                        model: defaultApps.terminalList
                        currentIndex: defaultApps.terminalIndex
                        enabled: count !== 0
                        onActivated: {
                            defaultApps.setDefaultTerminal(terminalComboBox.currentIndex)
                        }
                    }
                }
            }
        }
    }
}
