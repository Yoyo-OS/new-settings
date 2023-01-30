#include "networkplugin.h"
#include "networkproxy.h"
#include <QDebug>
NetworkPlugin::NetworkPlugin(QObject *parent)
    : QObject{parent}
{

}

QList<QObject*> NetworkPlugin::dataList()
{
    QList<QObject*> dataList;
    DataObject *data2 = new DataObject(this);
    data2->setName("network");
    data2->setTitle(tr("Network"));
    data2->setPage("qrc:/network/network/Main.qml");
    data2->setIconId("\uf45e");
    data2->setCategory(NETWORKANDCONNECTION);
    dataList.append(data2);
    DataObject *data3 = new DataObject(this);
    data3->setName("bluetooth");
    data3->setTitle(tr("Bluetooth"));
    data3->setIconId("\uf1df");
    data3->setPage("qrc:/network/bluetooth/Main.qml");
    data3->setCategory(NETWORKANDCONNECTION);
    dataList.append(data3);
    DataObject *data4 = new DataObject(this);
    data4->setName("proxy");
    data4->setTitle(tr("Proxy"));
    data4->setIconId("\uf6c6");
    data4->setPage("qrc:/network/proxy/Main.qml");
    data4->setCategory(NETWORKANDCONNECTION);
    dataList.append(data4);
    return dataList;
}

void NetworkPlugin::initialize()
{
    // QML
    const char *uri = "Yoyo.Settings";
    qmlRegisterType<NetworkProxy>(uri, 1, 0, "NetworkProxy");
}
