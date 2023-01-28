#ifndef DEMOA_H
#define DEMOA_H

#include <QObject>
#include <QtPlugin>
#include <QQmlApplicationEngine>
#include "../../include/yoyo-settings/interfaceplugin.h"
#include "../../include/yoyo-settings/dataObject.h"
class DEMOA : public QObject, public InterfacePlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID InterfacePlugin_iid FILE "demoA.json")
    Q_INTERFACES(InterfacePlugin)
public:
    explicit DEMOA(QObject *parent = nullptr);
    virtual void recMsgfromManager(PluginMetaData) Q_DECL_OVERRIDE{};
    virtual void initialize() Q_DECL_OVERRIDE;
    virtual QList<QObject*> dataList() Q_DECL_OVERRIDE;
signals:
    void sendMsg2Manager(PluginMetaData) Q_DECL_OVERRIDE;

};

#endif // DEMOA_H
