import QtQuick 2.4
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import FishUI 1.0 as FishUI
import Yoyo.Settings 1.0
import "../"


ItemPage {
    headerTitle: qsTr("Appearance")
    Test{ id:tst }
    Label{
        text: qsTr("I' DemoA")
    }
    Button{
        text: "yyds"
        onClicked: {
            console.log(tst.getText())
            text = tst.getText()
        }
    }
}
