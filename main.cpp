#include <QtGui/QApplication>
#include <QtDebug>
#include <QDeclarativeEngine>
#include "qmlapplicationviewer.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(createApplication(argc, argv));

    QmlApplicationViewer viewer;
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.setMainQmlFile(QLatin1String("qml/qmlworklogger/main.qml"));
    viewer.showExpanded();

    qDebug() << viewer.engine()->offlineStoragePath();

    return app->exec();
}
