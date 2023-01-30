#ifndef DISPLAYPLUGIN_H
#define DISPLAYPLUGIN_H

#include <QObject>
#include <QtPlugin>
#include <QQmlApplicationEngine>
#include "brightness.h"
#include "../../include/yoyo-settings/interfaceplugin.h"
#include "../../include/yoyo-settings/dataObject.h"
class DisplayPlugin : public QObject, public InterfacePlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID InterfacePlugin_iid FILE "displayplugin.json")
    Q_INTERFACES(InterfacePlugin)
public:
    explicit DisplayPlugin(QObject *parent = nullptr);
    virtual void recMsgfromManager(PluginMetaData) Q_DECL_OVERRIDE{};
    virtual void initialize() Q_DECL_OVERRIDE;
    virtual QList<QObject*> dataList() Q_DECL_OVERRIDE;
signals:
    void sendMsg2Manager(PluginMetaData) Q_DECL_OVERRIDE;

};

#endif // DEMOA_B
