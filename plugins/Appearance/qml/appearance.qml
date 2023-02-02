import QtQuick 2.4
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import Yoyo.Settings 1.0
import Youi 1.0 as Youi
import "../"

ItemPage {
    headerTitle: qsTr("Appearance")

    Appearance {
        id: appearance
    }

    FontsModel {
        id: fontsModel
    }

    Fonts {
        id: fonts
    }

    Connections {
        target: fontsModel

        function onLoadFinished() {
            for (var i in fontsModel.generalFonts) {
                if (fontsModel.systemGeneralFont === fontsModel.generalFonts[i]) {
                    generalFontComboBox.currentIndex = i
                    break;
                }
            }

            for (i in fontsModel.fixedFonts) {
                if (fontsModel.systemFixedFont === fontsModel.fixedFonts[i]) {
                    fixedFontComboBox.currentIndex = i
                    break;
                }
            }

            console.log("fonts load finished")
        }
    }

    Scrollable {
        anchors.fill: parent
        contentHeight: layout.implicitHeight

        ColumnLayout {
            id: layout
            anchors.fill: parent
            // anchors.bottomMargin: Youi.Units.largeSpacing
            spacing: Youi.Units.largeSpacing * 2

            RoundedItem {
                Label {
                    text: qsTr("Theme")
                    color: Youi.Theme.disabledTextColor
                }

                // Light Mode and Dark Mode
                RowLayout {
                    spacing: Youi.Units.largeSpacing * 2

                    IconCheckBox {
                        iconSize: 140
                        source: "qrc:/appearance/images/lightmode.png"
                        text: qsTr("Light")
                        checked: !Youi.Theme.darkMode
                        onClicked: appearance.switchDarkMode(false)
                    }

                    IconCheckBox {
                        iconSize: 140
                        source: "qrc:/appearance/images/darkmode.png"
                        text: qsTr("Dark")
                        checked: Youi.Theme.darkMode
                        onClicked: appearance.switchDarkMode(true)
                    }

                    IconCheckBox {
                        iconSize: 140
                        source: "qrc:/appearance/images/automode.png"
                        text: qsTr("Auto")
                        //checked: Youi.Theme.darkMode
                        //onClicked: appearance.switchDarkMode(true)
                    }
                }

                HorizontalDivider {}

                RowLayout {
                    spacing: Youi.Units.largeSpacing

                    Label {
                        id: dimsTipsLabel
                        text: qsTr("Dim the wallpaper in dark theme")
                        bottomPadding: Youi.Units.smallSpacing
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                    }

                    Item {
                        Layout.fillWidth: true
                    }

                    Switch {
                        checked: appearance.dimsWallpaper
                        height: dimsTipsLabel.height
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                        onCheckedChanged: appearance.setDimsWallpaper(checked)
                        rightPadding: 0
                    }
                }

                RowLayout {
                    Label {
                        text: qsTr("System effects")
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                    }

                    Item {
                        Layout.fillWidth: true
                    }

                    Switch {
                        checked: appearance.systemEffects
                        Layout.fillHeight: true
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                        onCheckedChanged: appearance.systemEffects = checked
                        rightPadding: 0
                    }
                }
            }

            RoundedItem {
                RowLayout {
                    spacing: Youi.Units.largeSpacing * 2

                    Label {
                        text: qsTr("Minimize animation")
                    }

                    TabBar {
                        Layout.fillWidth: true
                        currentIndex: appearance.minimiumAnimation
                        onCurrentIndexChanged: appearance.minimiumAnimation = currentIndex

                        TabButton {
                            text: qsTr("Default")
                        }

                        TabButton {
                            text: qsTr("Magic Lamp")
                        }
                    }
                }
            }

            RoundedItem {
                Label {
                    text: qsTr("Accent color")
                    color: Youi.Theme.disabledTextColor
                }

                GridView {
                    id: accentColorView
                    height: itemSize
                    Layout.fillWidth: true
                    cellWidth: height
                    cellHeight: height
                    interactive: false
                    model: ListModel {}

                    property int itemSize: 30 + Youi.Units.largeSpacing * 2

                    Component.onCompleted: {
                        model.clear()
                        model.append({"accentColor": String(Youi.Theme.color0)})
                        model.append({"accentColor": String(Youi.Theme.color1)})
                        model.append({"accentColor": String(Youi.Theme.color2)})
                        model.append({"accentColor": String(Youi.Theme.color3)})
                        model.append({"accentColor": String(Youi.Theme.color4)})
                        model.append({"accentColor": String(Youi.Theme.color5)})
                        model.append({"accentColor": String(Youi.Theme.color6)})
                    }

                    delegate: Item {
                        id: _accentColorItem

                        property bool checked: Qt.colorEqual(Youi.Theme.highlightColor, accentColor)
                        property color currentColor: accentColor

                        width: GridView.view.itemSize
                        height: width

                        MouseArea {
                            id: _mouseArea
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: appearance.setAccentColor(index)
                        }

                        Rectangle {
                            anchors.fill: parent
                            anchors.margins: Youi.Units.smallSpacing
                            color: "transparent"
                            radius: width / 2

                            border.color: _mouseArea.pressed ? Qt.rgba(currentColor.r,
                                                                       currentColor.g,
                                                                       currentColor.b, 0.6)
                                                             : Qt.rgba(currentColor.r,
                                                                       currentColor.g,
                                                                       currentColor.b, 0.4)
                            border.width: checked || _mouseArea.containsMouse ? 3 : 0

                            Rectangle {
                                anchors.fill: parent
                                anchors.margins: Youi.Units.smallSpacing
                                color: currentColor
                                radius: width / 2

                                Label{
                                    font.family: "FluentSystemIcons-Regular"
                                    anchors.centerIn: parent
                                    color: "#FFFFFF"
                                    font.pixelSize: parent.height * 0.6
                                    antialiasing: false
                                    smooth: false
                                    visible: checked
                                    text: "\uf293"
                                }
                            }
                        }
                    }
                }
            }
            RoundedItem {
                Label {
                    text: qsTr("Fonts")
                    color: Youi.Theme.disabledTextColor
                }
                GridLayout {
                    rows: 3
                    columns: 2

                    columnSpacing: Youi.Units.largeSpacing * 1.5
                    rowSpacing: Youi.Units.largeSpacing * 1.5

                    Label {
                        text: qsTr("General Font")
                        bottomPadding: Youi.Units.smallSpacing
                    }

                    ComboBox {
                        id: generalFontComboBox
                        model: fontsModel.generalFonts
                        enabled: true
                        Layout.fillWidth: true
                        topInset: 0
                        bottomInset: 0
                        leftPadding: Youi.Units.largeSpacing
                        rightPadding: Youi.Units.largeSpacing
                        onActivated: appearance.setGenericFontFamily(currentText)
                    }

                    Label {
                        text: qsTr("Fixed Font")
                        bottomPadding: Youi.Units.smallSpacing
                    }

                    ComboBox {
                        id: fixedFontComboBox
                        model: fontsModel.fixedFonts
                        enabled: true
                        Layout.fillWidth: true
                        topInset: 0
                        bottomInset: 0
                        leftPadding: Youi.Units.largeSpacing
                        rightPadding: Youi.Units.largeSpacing
                        onActivated: appearance.setFixedFontFamily(currentText)
                    }

                    Label {
                        text: qsTr("Font Size")
                        bottomPadding: Youi.Units.smallSpacing
                    }

                    TabBar {
                        Layout.fillWidth: true

                        TabButton {
                            text: qsTr("Small")
                        }

                        TabButton {
                            text: qsTr("Medium")
                        }

                        TabButton {
                            text: qsTr("Large")
                        }

                        TabButton {
                            text: qsTr("Huge")
                        }

                        currentIndex: {
                            var index = 0

                            if (appearance.fontPointSize <= 9)
                                index = 0
                            else if (appearance.fontPointSize <= 10)
                                index = 1
                            else if (appearance.fontPointSize <= 12)
                                index = 2
                            else if (appearance.fontPointSize <= 15)
                                index = 3

                            return index
                        }

                        onCurrentIndexChanged: {
                            var fontSize = 0

                            switch (currentIndex) {
                            case 0:
                                fontSize = 9
                                break;
                            case 1:
                                fontSize = 10
                                break;
                            case 2:
                                fontSize = 12
                                break;
                            case 3:
                                fontSize = 15
                                break;
                            }

                            appearance.setFontPointSize(fontSize)
                        }
                    }

                    Label {
                        text: qsTr("Hinting")
                        bottomPadding: Youi.Units.smallSpacing
                    }

                    ComboBox {
                        model: fonts.hintingModel
                        textRole: "display"
                        Layout.fillWidth: true
                        currentIndex: fonts.hintingCurrentIndex
                        onCurrentIndexChanged: fonts.hintingCurrentIndex = currentIndex
                    }

                    Label {
                        text: qsTr("Anti-Aliasing")
                        bottomPadding: Youi.Units.smallSpacing
                    }

                    Switch {
                        Layout.fillHeight: true
                        Layout.alignment: Qt.AlignRight
                        checked: fonts.antiAliasing
                        onCheckedChanged: fonts.antiAliasing = checked
                    }

                }
            }
            Item {
                Layout.fillHeight: true
            }
        }
    }
}
