/*
 * @Author: YoyoOS
 * @Date: 2023-02-28 21:45:34
 * @LastEditors: 柚子
 * @LastEditTime: 2023-02-28 11:08:18
 * @FilePath: /settings/src/application.cpp
 * @Description:
 *
 * Copyright (c) 2022 by YoyoOS, All Rights Reserved.
 */
#include "application.h"
#include "settingsuiadaptor.h"
#include <QFontDatabase>
#include <QQuickStyle>
Application::Application(int &argc, char **argv)
    : QGuiApplication(argc, argv)
{
    setWindowIcon(QIcon::fromTheme("preferences-system"));
    setOrganizationName("yoyoos");

    QCommandLineParser parser;
    parser.setApplicationDescription(QStringLiteral("Yoyo Settings"));
    parser.addHelpOption();

    QCommandLineOption moduleOption("m", "Switch to module", "module");
    parser.addOption(moduleOption);
    parser.process(*this);
    const QString module = parser.value(moduleOption);

    if (!QDBusConnection::sessionBus().registerService("com.yoyo.SettingsUI")) {
        QDBusInterface iface("com.yoyo.SettingsUI", "/SettingsUI", "com.yoyo.SettingsUI", QDBusConnection::sessionBus());
        if (iface.isValid())
            iface.call("switchToPage", module);
        return;
    }

    new SettingsUIAdaptor(this);
    QDBusConnection::sessionBus().registerObject(QStringLiteral("/SettingsUI"), this);

    QQuickStyle::setStyle(QLatin1String("yoyo-style"));

    // Translations
    QLocale locale;
    QString qmFilePath = QString("%1/%2.qm").arg("/usr/share/yoyo-settings/translations").arg("yoyo-settings_" + QLocale(locale).name());
    if (QFile::exists(qmFilePath)) {
        QTranslator *translator = new QTranslator(QGuiApplication::instance());
        if (translator->load(qmFilePath)) {
            QGuiApplication::installTranslator(translator);
        } else {
            translator->deleteLater();
        }
    }

    //insertPlugin
    insertPlugin();

    //QML
    m_engine.rootContext()->setContextProperty("dataObjectModel",QVariant::fromValue(dataList));
    m_engine.addImportPath("qrc:/");
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&m_engine, &QQmlApplicationEngine::objectCreated,
                     this, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    m_engine.load(url);

    if (!module.isEmpty()) {
        switchToPage(module);
    }

    QGuiApplication::exec();
}

void Application::insertPlugin()
{
    QtPluginsManager::getInstance().loadAllPlugins();
    QtPluginsManager::getInstance().initSignalAndSlot();

    QList<QObject*> dataList0;
    QList<QObject*> dataList1;
    QList<QObject*> dataList2;
    QList<QObject*> dataList3;

    QList<QPluginLoader *> allPlugins = QtPluginsManager::getInstance().allPlugins();
    QListIterator<QPluginLoader *> it(allPlugins);
    for(it.toFront(); it.hasNext();)
    {
        QPluginLoader *loader = it.next();
        if(loader)
        {
            auto obj = loader->instance();
            obj->setParent(this);
            InterfacePlugin *ifp = qobject_cast<InterfacePlugin*>(obj);
            if(ifp->enabled())
            {
                QList<QObject*> pluginDataList = ifp->dataList();
                QListIterator<QObject *> it1(pluginDataList);
                for(it1.toFront(); it1.hasNext();)
                {
                    DataObject* m_obj = dynamic_cast<DataObject*>(it1.next());
                    switch (m_obj->category()) {
                        case 0:
                            dataList0.append(m_obj);
                            break;
                        case 1:
                            dataList1.append(m_obj);
                            break;
                        case 2:
                            dataList2.append(m_obj);
                            break;
                        case 3:
                            dataList3.append(m_obj);
                            break;
                    }
                }
            }
        }
        else
        {
         qDebug() << "未能找到插件";
        }
    }
    dataList<<dataList0<<dataList1<<dataList2<<dataList3;
    //dataList = listSort(dataList);
}

void Application::switchToPage(const QString &name)
{
    QObject *mainObject = m_engine.rootObjects().first();

    if (mainObject) {
        QMetaObject::invokeMethod(mainObject, "switchPageFromName", Q_ARG(QVariant, name));
    }
}

//列表排序函数
QList<QObject*> Application::listSort(QList<QObject*> list)
{
    QList<QObject*> new_list;
    //遍历列表
    QListIterator<QObject*> it(list);
    for(it.toFront(); it.hasNext();)
    {
        //强制类型转换，转为派生类
        DataObject* m_obj = dynamic_cast<DataObject*>(it.next());

        //插件名
        qDebug()<<m_obj->name();
        //插件分类名
        qDebug()<<m_obj->category();

        //留给uni做排序
    }
    return new_list;
}
