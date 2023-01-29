#include "demob.h"
#include "test.h"
#include <QDebug>
DEMOB::DEMOB(QObject *parent)
    : QObject{parent}
{

}

QList<QObject*> DEMOB::dataList()
{
    QList<QObject*> dataList;
    DataObject *data1 = new DataObject(this);
    data1->setName("demob");
    data1->setTitle("DemoB");
    data1->setIconColor(QColor("#000000"));
    data1->setPage("qrc:/demo2/main.qml");
    data1->setCategory(TEST);
    dataList.append(data1);
    DataObject *data2 = new DataObject(this);
    data2->setName("demoBBBBBBb");
    data2->setTitle("DemoBBBBBBBBBBBBBB");
    data2->setIconColor(QColor("#000000"));
    data2->setPage("qrc:/demo2/main.qml");
    data2->setCategory(TEST);
    dataList.append(data2);
    return dataList;
}

void DEMOB::initialize()
{
    // QML
    const char *uri = "Yoyo.Settings";
    qmlRegisterType<Test>(uri, 1, 0, "Test");
}
