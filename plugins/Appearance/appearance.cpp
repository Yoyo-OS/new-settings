/*
 * Copyright (C) 2021 YoyoOS Team.
 *
 * Author:     revenmartin <revenmartin@gmail.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include "appearance.h"

#include <QDBusConnection>
#include <QDBusInterface>
#include <QDBusReply>
#include <QDBusServiceWatcher>
#include <QDBusPendingCall>

#include <QStandardPaths>
#include <QDebug>

Appearance::Appearance(QObject *parent)
    : QObject(parent)
    , m_interface("com.yoyo.Settings",
                  "/Theme",
                  "com.yoyo.Theme",
                  QDBusConnection::sessionBus())
    , m_kwinSettings(new QSettings(QStandardPaths::writableLocation(QStandardPaths::ConfigLocation) + "/kwinrc",
                                   QSettings::IniFormat))
    , m_fontPointSize(11)
    , m_systemEffects(false)
{
    m_kwinSettings->beginGroup("Compositing");
    m_systemEffects = !m_kwinSettings->value("OpenGLIsUnsafe", false).toBool();
    m_kwinSettings->endGroup();
    m_kwinSettings->beginGroup("Plugins");
    m_minimiumAnimation = m_kwinSettings->value("magiclampEnabled").toBool() ? 1 : 0;
    m_kwinSettings->endGroup();

    // Init
    if (m_interface.isValid()) {
        m_fontPointSize = m_interface.property("systemFontPointSize").toInt();

        connect(&m_interface, SIGNAL(darkModeDimsWallpaerChanged()), this, SIGNAL(dimsWallpaperChanged()));
    }
}

void Appearance::switchDarkMode(bool darkMode)
{
    if (m_interface.isValid()) {
        m_interface.call("setDarkMode", darkMode);
    }
}

bool Appearance::dimsWallpaper() const
{
    return m_interface.property("darkModeDimsWallpaer").toBool();
}

void Appearance::setDimsWallpaper(bool value)
{
    m_interface.call("setDarkModeDimsWallpaer", value);
}

void Appearance::setGenericFontFamily(const QString &name)
{
    if (name.isEmpty())
        return;

    QDBusInterface iface("com.yoyo.Settings",
                         "/Theme",
                         "com.yoyo.Theme",
                         QDBusConnection::sessionBus(), this);
    if (iface.isValid()) {
        iface.call("setSystemFont", name);
    }
}

void Appearance::setFixedFontFamily(const QString &name)
{
    if (name.isEmpty())
        return;

    QDBusInterface iface("com.yoyo.Settings",
                         "/Theme",
                         "com.yoyo.Theme",
                         QDBusConnection::sessionBus(), this);
    if (iface.isValid()) {
        iface.call("setSystemFixedFont", name);
    }
}

int Appearance::fontPointSize() const
{
    return m_fontPointSize;
}

void Appearance::setFontPointSize(int fontPointSize)
{
    m_fontPointSize = fontPointSize;

    QDBusInterface iface("com.yoyo.Settings",
                         "/Theme",
                         "com.yoyo.Theme",
                         QDBusConnection::sessionBus(), this);
    if (iface.isValid()) {
        iface.call("setSystemFontPointSize", m_fontPointSize * 1.0);
    }
}

void Appearance::setAccentColor(int accentColor)
{
    QDBusInterface iface("com.yoyo.Settings",
                         "/Theme",
                         "com.yoyo.Theme",
                         QDBusConnection::sessionBus(), this);
    if (iface.isValid()) {
        iface.call("setAccentColor", accentColor);
    }
}

double Appearance::devicePixelRatio() const
{
    return m_interface.property("devicePixelRatio").toDouble();
}

void Appearance::setDevicePixelRatio(double value)
{
    QDBusInterface iface("com.yoyo.Settings",
                         "/Theme",
                         "com.yoyo.Theme",
                         QDBusConnection::sessionBus(), this);
    if (iface.isValid()) {
        iface.call("setDevicePixelRatio", value);
    }
}

bool Appearance::systemEffects() const
{
    return m_systemEffects;
}

void Appearance::setSystemEffects(bool systemEffects)
{
    if (m_systemEffects != systemEffects) {
        m_systemEffects = systemEffects;
        m_kwinSettings->beginGroup("Compositing");
        m_kwinSettings->setValue("OpenGLIsUnsafe", !systemEffects);
        m_kwinSettings->endGroup();
        m_kwinSettings->sync();
        QDBusInterface("org.kde.KWin", "/KWin").call("reconfigure");
        emit systemEffectsChanged();
    }
}

int Appearance::minimiumAnimation() const
{
    return m_minimiumAnimation;
}

void Appearance::setMinimiumAnimation(int minimiumAnimation)
{
    if (m_minimiumAnimation != minimiumAnimation) {
        m_minimiumAnimation = minimiumAnimation;
        m_kwinSettings->beginGroup("Plugins");
        m_kwinSettings->setValue("magiclampEnabled", m_minimiumAnimation == 1);
        m_kwinSettings->setValue("yoyo_squashEnabled", m_minimiumAnimation == 0);
        m_kwinSettings->endGroup();
        m_kwinSettings->sync();
        QDBusInterface("org.kde.KWin", "/KWin").call("reconfigure");
        emit minimiumAnimationChanged();
    }
}
