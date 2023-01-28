#ifndef TEST_H
#define TEST_H

#include <QObject>
#include <QString>

class Test : public QObject
{
    Q_OBJECT
public:
    explicit Test(QObject *parent = nullptr);
    Q_INVOKABLE QString getText() const { return "I'm Test!"; };
signals:

};

#endif // TEST_H
