#include "appmanager.h"
#include <QQmlContext>
#include <QCoreApplication>

void AppManager::readAllStatesVaccineData() {
    qDebug() << "Read All States Vaccine Data";

    QJsonParseError JsonParseError;
    QJsonArray configData = QJsonDocument::fromJson(readFilesData(STATEWISE_VACCINE_DATA_FILENAME), &JsonParseError).object()["Total"].toArray();
    setTotalVaccineDoses(configData.at(configData.size()-1).toInt());
}

QByteArray AppManager::readFilesData(QString fileName) {
    qDebug() << "Read Files Data";

    QFile file(QString("%1%2").arg(BASE_DIR,fileName));
    file.open(QIODevice::ReadOnly | QIODevice::Text);
    QByteArray configData = file.readAll();
    file.close();
    return configData;
}

void AppManager::showApp() {
    qmlRegisterSingletonType(QUrl("qrc:/components/AppThemes.qml"),"AppThemes",1,0,"AppThemes");
    engine->rootContext()->setContextProperty("appManager", this);
    engine->load(QUrl(QStringLiteral("qrc:/main.qml")));
}

void AppManager::loadAppData(bool value) {
    if(value) {
        qmlRegisterSingletonType(QUrl("qrc:/screenManager/AppData.qml"),"AppData",1,0,"AppData");
        engine->rootContext()->setContextProperty("dataSource",chartUpdate);
    }
}
