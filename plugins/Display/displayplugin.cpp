#include "displayplugin.h"
#include <QDebug>
DisplayPlugin::DisplayPlugin(QObject *parent)
    : QObject{parent}
{

}

QList<QObject*> DisplayPlugin::dataList()
{
    QList<QObject*> dataList;
    DataObject *data1 = new DataObject(this);
    data1->setName("display");
    data1->setTitle(tr("Display"));
    data1->setPage("qrc:/display/Main.qml");
    data1->setCategory(DISPLAYANDAPPEARANCE);
    dataList.append(data1);
    return dataList;
}

void DisplayPlugin::initialize()
{
    // QML
    const char *uri = "Yoyo.Settings";
    qmlRegisterType<Brightness>(uri, 1, 0, "Brightness");
}
