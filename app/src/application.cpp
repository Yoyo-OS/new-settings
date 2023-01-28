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

    QDBusConnection::sessionBus().registerObject(QStringLiteral("/SettingsUI"), this);

    // Translations
    QLocale locale;
    QString qmFilePath = QString("%1/%2.qm").arg("/usr/share/yoyo-settings/translations/").arg("yoyo-settings_" + QLocale(locale).name());
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
}

void Application::insertPlugin()
{
    QtPluginsManager::getInstance().loadAllPlugins();
    QtPluginsManager::getInstance().initSignalAndSlot();

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
                dataList.append(ifp->dataList());
                qDebug()<<ifp->dataList();
            }
        }
        else
        {
         qDebug() << "未能找到插件";
        }
    }
}

void Application::switchToPage(const QString &name)
{
    QObject *mainObject = m_engine.rootObjects().first();

    if (mainObject) {
        QMetaObject::invokeMethod(mainObject, "switchPageFromName", Q_ARG(QVariant, name));
    }
}
