#include <QGuiApplication>
#include <QtAndroid>
#include <QApplication>
#include <QCoreApplication>

#include "appmanager.h"

const QVector<QString> permissions({"android.permission.READ_EXTERNAL_STORAGE","android.permission.WRITE_EXTERNAL_STORAGE"});

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

#ifdef Q_OS_ANDROID
    QApplication app(argc, argv);
    for(const QString &permission : permissions){
        auto result = QtAndroid::checkPermission(permission);
        if(result == QtAndroid::PermissionResult::Denied){
            auto resultHash = QtAndroid::requestPermissionsSync(QStringList({permission}));
        }
    }
#endif

    AppManager appManager;
    QCoreApplication::setApplicationName(APP_NAME);
    QCoreApplication::setOrganizationName(APP_COMPANY);

    return app.exec();
}
