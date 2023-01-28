/*
 * @Author: YoyoOS
 * @Date: 2023-02-28 21:45:34
 * @LastEditors: 柚子
 * @LastEditTime: 2023-02-28 11:08:18
 * @FilePath: /settings/src/application.h
 * @Description:
 *
 * Copyright (c) 2022 by YoyoOS, All Rights Reserved.
 */
#ifndef APPLICATION_H
#define APPLICATION_H

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QDBusConnection>
#include <QDBusInterface>
#include <QTranslator>
#include <QIcon>
#include <QCommandLineParser>
#include "qtpluginsmanager.h"
#include "../../include/yoyo-settings/interfaceplugin.h"

class Application : public QGuiApplication
{
    Q_OBJECT

public:
    explicit Application(int &argc, char **argv);
    void switchToPage(const QString &name);

private:
    void insertPlugin();
    QList<QObject*> listSort(QList<QObject*> list);
    QList<QObject*> dataList;
    QQmlApplicationEngine m_engine;
};

#endif // APPLICATION_H
