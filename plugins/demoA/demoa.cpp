#include "demoa.h"
#include "test.h"

DEMOA::DEMOA(QObject *parent)
    : QObject{parent}
{

}

QList<QObject*> DEMOA::dataList()
{
    QList<QObject*> dataList;
    DataObject *data1 = new DataObject(this);
    data1->setName("demoa");
    data1->setTitle("DemoA");
    data1->setIconColor(QColor("#000000"));
    data1->setPage("qrc:/demo1/main.qml");
    data1->setCategory("Test");
    dataList<<data1;
    return dataList;
}

void DEMOA::initialize()
{
    // QML
    const char *uri = "Yoyo.Settings";
    qmlRegisterType<Test>(uri, 1, 0, "Test");
}
