#ifndef SYSTEMPLUGIN_H
#define SYSTEMPLUGIN_H

#include <QObject>
#include <QtPlugin>
#include <QQmlApplicationEngine>
#include "accessibility.h"
#include "battery.h"
#include "batteryhistorymodel.h"
#include "defaultapplications.h"
#include "language.h"
#include "notifications.h"
#include "password.h"
#include "powermanager.h"
#include "touchpad.h"
#include "cursor/cursorthememodel.h"
#include "cursor/cursortheme.h"
#include "cursor/mouse.h"
#include "datetime/time.h"
#include "datetime/timezonemap.h"
#include "password.h"
#include "../../include/yoyo-settings/interfaceplugin.h"
#include "../../include/yoyo-settings/dataObject.h"
class SystemPlugin : public QObject, public InterfacePlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID InterfacePlugin_iid FILE "systemplugin.json")
    Q_INTERFACES(InterfacePlugin)
public:
    explicit SystemPlugin(QObject *parent = nullptr);
    virtual void recMsgfromManager(PluginMetaData) Q_DECL_OVERRIDE{};
    virtual void initialize() Q_DECL_OVERRIDE;
    virtual QList<QObject*> dataList() Q_DECL_OVERRIDE;
signals:
    void sendMsg2Manager(PluginMetaData) Q_DECL_OVERRIDE;

};

#endif // SYSTEMPLUGIN_H
