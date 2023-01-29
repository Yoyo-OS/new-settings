#include "appearanceplugin.h"
#include "appearance.h"
#include "fonts.h"
#include "fontsmodel.h"
#include "background.h"
#include <QDebug>
AppearancePlugin::AppearancePlugin(QObject *parent)
    : QObject{parent}
{

}

QList<QObject*> AppearancePlugin::dataList()
{
    QList<QObject*> dataList;
    DataObject *data1 = new DataObject(this);
    data1->setName("appearance");
    data1->setTitle(tr("Appearance"));
    data1->setPage("qrc:/appearance/appearance.qml");
    data1->setCategory(DISPLAYANDAPPEARANCE);
    dataList.append(data1);
    DataObject *data2 = new DataObject(this);
    data2->setName("wallpaper");
    data2->setTitle(tr("Wallpaper"));
    data2->setPage("qrc:/appearance/wallpaper.qml");
    data2->setCategory(DISPLAYANDAPPEARANCE);
    dataList.append(data2);
    return dataList;
}

void AppearancePlugin::initialize()
{
    // QML
    const char *uri = "Yoyo.Settings";
    qmlRegisterType<Appearance>(uri, 1, 0, "Appearance");
    qmlRegisterType<FontsModel>(uri, 1, 0, "FontsModel");
    qmlRegisterType<Background>(uri, 1, 0, "Background");
    qmlRegisterType<Fonts>(uri, 1, 0, "Fonts");
}
