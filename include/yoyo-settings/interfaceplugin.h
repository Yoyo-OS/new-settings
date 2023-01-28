#pragma once

#include <QString>
#include <QtPlugin>
#include <QObject>
#include <QColor>
#include <QList>
#include "pluginMetaData.h"
//定义接口
class InterfacePlugin
{

public:
    virtual ~InterfacePlugin() {}
    virtual void recMsgfromManager(PluginMetaData) = 0;
    virtual void sendMsg2Manager(PluginMetaData)   = 0;

    // initialize初始化相应的模块，不能做资源占用较高的操作；
    virtual void initialize() = 0;

    /**
     * @brief enabled
     * @return 插件是否处于可用状态
     */
    virtual bool enabled() const {
        return true;
    }

    ///
    /// \brief dataList
    /// 模块数据列表
    /// \return
    ///
    virtual QList<QObject*> dataList() =0;
};


#define InterfacePlugin_iid "com.yoyo.settings.module"

Q_DECLARE_INTERFACE(InterfacePlugin, InterfacePlugin_iid)
