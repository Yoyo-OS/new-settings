#ifndef DATAOBJECT_H
#define DATAOBJECT_H

#include <QString>
#include <QObject>
#include <QColor>

class DataObject : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString title READ title WRITE setTitle NOTIFY titleChanged)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QString page READ page WRITE setPage NOTIFY pageChanged)
    Q_PROPERTY(QString iconId READ iconId WRITE setIconId NOTIFY iconIdChanged)
    Q_PROPERTY(short category READ category WRITE setCategory NOTIFY categoryChanged)

public:
    explicit DataObject(QObject *parent = nullptr) { };
    QString title()const { return m_title; };
    void setTitle(const QString &title) { m_title = title; emit titleChanged();} ;
    QString name()const { return m_name; } ;
    void setName(const QString &name) { m_name = name; emit nameChanged();} ;
    QString page()const { return m_page; } ;
    void setPage(const QString &page) { m_page = page; emit pageChanged();} ;
    QString iconId()const { return m_iconId; } ;
    void setIconId(const QString &iconId) { m_iconId = iconId; emit iconIdChanged();} ;
    short category()const { return m_category; } ;
    void setCategory(const short &category) { m_category = category; emit categoryChanged();} ;
signals:
    void nameChanged();
    void titleChanged();
    void pageChanged();
    void iconIdChanged();
    void categoryChanged();
private:
    QString m_title;
    QString m_name;
    QString m_page;
    QString m_iconId;
    short m_category;
};

#endif // DATAOBJECT_H
