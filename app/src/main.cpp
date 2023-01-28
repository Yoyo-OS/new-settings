#include "application.h"
#include <QDebug>
#include <QIcon>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_UseHighDpiPixmaps, true);
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling, true);
    Application app(argc, argv);

    app.setWindowIcon(QIcon::fromTheme("yoyo-settings"));

    return app.exec();
}
