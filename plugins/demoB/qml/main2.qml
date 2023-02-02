import QtQuick 2.4
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import Youi 1.0 as Youi
import Yoyo.Settings 1.0
import "../"
ItemPage {
    headerTitle: qsTr("main2")
    Scrollable {
        anchors.fill: parent
        contentHeight: layout.implicitHeight

        ColumnLayout {
            id: layout
            anchors.fill: parent
            spacing: Youi.Units.largeSpacing * 2
            Button{
                text: "OHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH"
            }
        }
    }
}
