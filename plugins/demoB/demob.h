#ifndef DEMOB_H
#define DEMOB_H

#include <QObject>
#include <QtPlugin>
#include <QQmlApplicationEngine>
#include "../../include/yoyo-settings/interfaceplugin.h"
#include "../../include/yoyo-settings/dataObject.h"
class DEMOB : public QObject, public InterfacePlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID InterfacePlugin_iid FILE "demoB.json")
    Q_INTERFACES(InterfacePlugin)
public:
    explicit DEMOB(QObject *parent = nullptr);
    virtual void recMsgfromManager(PluginMetaData) Q_DECL_OVERRIDE{};
    virtual void initialize() Q_DECL_OVERRIDE;
    virtual QList<QObject*> dataList() Q_DECL_OVERRIDE;
signals:
    void sendMsg2Manager(PluginMetaData) Q_DECL_OVERRIDE;

};

#endif // DEMOA_B
