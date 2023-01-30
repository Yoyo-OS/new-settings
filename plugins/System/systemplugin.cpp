#include "systemplugin.h"
#include <QDebug>

static QObject *passwordSingleton(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine);
    Q_UNUSED(scriptEngine);

    Password *object = new Password();
    return object;
}

SystemPlugin::SystemPlugin(QObject *parent)
    : QObject{parent}
{

}

QList<QObject*> SystemPlugin::dataList()
{
    QList<QObject*> dataList;
    DataObject *data1 = new DataObject(this);
    data1->setName("accounts");
    data1->setTitle(tr("User"));
    data1->setIconId("\uf5be");
    data1->setPage("qrc:/System/User/Main.qml");
    data1->setCategory(SYSTEM);
    dataList.append(data1);
    DataObject *data2 = new DataObject(this);
    data2->setName("notifications");
    data2->setTitle(tr("Notifications"));
    data2->setIconId("\ue2c5");
    data2->setPage("qrc:/System/Notification/Main.qml");
    data2->setCategory(SYSTEM);
    dataList.append(data2);
    DataObject *data3 = new DataObject(this);
    data3->setName("sound");
    data3->setTitle(tr("Sound"));
    data3->setIconId("\ueb43");
    data3->setPage("qrc:/System/Sound/Main.qml");
    data3->setCategory(SYSTEM);
    dataList.append(data3);
    DataObject *data4 = new DataObject(this);
    data4->setName("mouse");
    data4->setTitle(tr("Mouse"));
    data4->setIconId("\ue444");
    data4->setPage("qrc:/System/Cursor/Main.qml");
    data4->setCategory(SYSTEM);
    dataList.append(data4);

    Touchpad touchpad;
    if(touchpad.available())
    {
        DataObject *data5 = new DataObject(this);
        data5->setName("touchpad");
        data5->setTitle(tr("Touchpad"));
        data5->setIconId("\uea0a");
        data5->setPage("qrc:/System/Touchpad/Main.qml");
        data5->setCategory(SYSTEM);
        dataList.append(data5);
    }

    DataObject *data6 = new DataObject(this);
    data6->setName("datetime");
    data6->setTitle(tr("Date & Time"));
    data6->setIconId("\uf21e");
    data6->setPage("qrc:/System/DateTime/Main.qml");
    data6->setCategory(SYSTEM);
    dataList.append(data6);

    DataObject *data7 = new DataObject(this);
    data7->setName("accessibility");
    data7->setTitle(tr("Accessibility"));
    data7->setIconId("\uf104");
    data7->setPage("qrc:/System/Accessibility/Main.qml");
    data7->setCategory(SYSTEM);
    dataList.append(data7);

    DataObject *data8 = new DataObject(this);
    data8->setName("defaultapps");
    data8->setTitle(tr("Default Applications"));
    data8->setIconId("\uf134");
    data8->setPage("qrc:/System/DefaultApp/Main.qml");
    data8->setCategory(SYSTEM);
    dataList.append(data8);

    DataObject *data9 = new DataObject(this);
    data9->setName("language");
    data9->setTitle(tr("Language"));
    data9->setIconId("\uf3db");
    data9->setPage("qrc:/System/LanguagePage.qml");
    data9->setCategory(SYSTEM);
    dataList.append(data9);

    Battery battery;
    if(battery.available())
    {
        DataObject *data10 = new DataObject(this);
        data10->setName("battery");
        data10->setTitle(tr("Battery"));
        data10->setIconId("\uf1ce");
        data10->setPage("qrc:/System/Battery/Main.qml");
        data10->setCategory(SYSTEM);
        dataList.append(data10);
    }

    DataObject *data11 = new DataObject(this);
    data11->setName("power");
    data11->setTitle(tr("Power"));
    data11->setIconId("\uf678");
    data11->setPage("qrc:/System/Power/Main.qml");
    data11->setCategory(SYSTEM);
    dataList.append(data11);
    return dataList;
}

void SystemPlugin::initialize()
{
    // QML
    const char *uri = "Yoyo.Settings";
    qmlRegisterType<Battery>(uri, 1, 0, "Battery");
    qmlRegisterType<BatteryHistoryModel>(uri, 1, 0, "BatteryHistoryModel");
    qmlRegisterType<CursorThemeModel>(uri, 1, 0, "CursorThemeModel");
    qmlRegisterType<Language>(uri, 1, 0, "Language");
    qmlRegisterType<PowerManager>(uri, 1, 0, "PowerManager");
    qmlRegisterType<Mouse>(uri, 1, 0, "Mouse");
    qmlRegisterType<Time>(uri, 1, 0, "Time");
    qmlRegisterType<TimeZoneMap>(uri, 1, 0, "TimeZoneMap");
    qmlRegisterType<Touchpad>(uri, 1, 0, "Touchpad");
    qmlRegisterType<Notifications>(uri, 1, 0, "Notifications");
    qmlRegisterType<DefaultApplications>(uri, 1, 0, "DefaultApplications");
    qmlRegisterType<Accessibility>(uri, 1, 0, "Accessibility");
    qmlRegisterSingletonType<Password>(uri, 1, 0, "Password", passwordSingleton);
}
