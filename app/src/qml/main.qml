import QtQuick 2.4
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3
import QtGraphicalEffects 1.0
import Youi 1.0 as Youi
import "./"

Youi.Window {
    id: rootWindow
    title: qsTr("Settings")
    visible: true
    width: 900
    height: 610

    minimumWidth: 900
    minimumHeight: 600

    property alias stackView: _stackView
    property bool isSecondary: false
    background.opacity: Youi.Theme.darkMode ? 0.7 : 0.5
    header.height: 40
    contentTopMargin: 0

    LayoutMirroring.enabled: Qt.application.layoutDirection === Qt.RightToLeft
    LayoutMirroring.childrenInherit: true

    headerItem: Item {
        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: Youi.Units.smallSpacing * 3
            anchors.rightMargin: Youi.Units.smallSpacing * 3
            anchors.topMargin: Youi.Units.smallSpacing * 1.5
            anchors.bottomMargin: Youi.Units.smallSpacing * 1.5

            Button{
                Layout.preferredWidth: height
                Layout.preferredHeight: 30
                flat: true
                text: "\uf15d"
                font.family: "FluentSystemIcons-Regular"
                visible: rootWindow.isSecondary
                onClicked: {
                    rootWindow.back()
                }
            }
            Label{
                text:title
                font.pointSize: 14
                //horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                Layout.fillWidth: true

            }
        }
    }

    Youi.WindowBlur {
        view: rootWindow
        geometry: Qt.rect(rootWindow.x, rootWindow.y, rootWindow.width, rootWindow.height)
        windowRadius: rootWindow.windowRadius
        enabled: true
    }

    RowLayout {
        anchors.fill: parent
        spacing: 0

        SideBar {
            id: sideBar
            Layout.fillHeight: true

            onCurrentIndexChanged: {
                switchPageFromIndex(currentIndex)
            }
        }

        StackView {
            id: _stackView
            Layout.fillWidth: true
            Layout.fillHeight: true
            initialItem: Qt.resolvedUrl(dataObjectModel[0].page)
            clip: true

            pushEnter: Transition {}
            pushExit: Transition {}
        }
    }

    function addPage(title,name,page,iconSource,iconColor,category) {
       sideBar.model.append(
        {
            "title": title,
            "name": name,
            "page": page,
            "iconSource": iconSource,
            "iconColor": iconColor,
            "category": category
        }
    );
    }

    function switchPageFromIndex(index) {
        _stackView.pop()
        _stackView.push(Qt.resolvedUrl(dataObjectModel[index].page))
    }

    function switchPageFromUrl(url){
        isSecondary = true
        _stackView.push(Qt.resolvedUrl(url))
    }

    function back(){
        isSecondary = false
        console.log("hhhh")
        _stackView.pop()
    }

    function switchPageFromName(pageName) {
        for (var i = 0; i < dataObjectModel.length; ++i) {
            if (pageName === dataObjectModel[i].name) {
                switchPageFromIndex(3)
                sideBar.view.currentIndex = i
            }
        }

        // If the window is minimized, it needs to be displayed again.
        rootWindow.show()
        rootWindow.raise()
    }
}
