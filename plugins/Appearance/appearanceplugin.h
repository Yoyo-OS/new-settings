#ifndef APPEARANCEPLUGIN_H
#define APPEARANCEPLUGIN_H

#include <QObject>
#include <QtPlugin>
#include <QQmlApplicationEngine>
#include "../../include/yoyo-settings/interfaceplugin.h"
#include "../../include/yoyo-settings/dataObject.h"
class AppearancePlugin : public QObject, public InterfacePlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID InterfacePlugin_iid FILE "appearanceplugin.json")
    Q_INTERFACES(InterfacePlugin)
public:
    explicit AppearancePlugin(QObject *parent = nullptr);
    virtual void recMsgfromManager(PluginMetaData) Q_DECL_OVERRIDE{};
    virtual void initialize() Q_DECL_OVERRIDE;
    virtual QList<QObject*> dataList() Q_DECL_OVERRIDE;
signals:
    void sendMsg2Manager(PluginMetaData) Q_DECL_OVERRIDE;

};

#endif // APPEARANCEPLUGIN_H
