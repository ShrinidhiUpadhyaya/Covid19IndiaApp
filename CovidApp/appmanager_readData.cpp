#include "appmanager.h"


void AppManager::readAllStatesVaccineData() {
    qDebug() << "Read All States Vaccine Data";

    QFile file(QString("%1%2").arg(BASE_DIR,STATEWISE_VACCINE_DATA_FILENAME));
    file.open(QIODevice::ReadOnly | QIODevice::Text);
    QJsonParseError JsonParseError;
    QJsonArray configData = QJsonDocument::fromJson(file.readAll(), &JsonParseError).object()["Total"].toArray();
    file.close();
    setTotalVaccineDoses(configData.at(configData.size()-1).toInt());
}


void AppManager::readOverallData() {
    qDebug() << "Read Overall Data";

    QFile file(QString("%1%2").arg(BASE_DIR,OVERALL_DATA_FILENAME));
    file.open(QIODevice::ReadOnly | QIODevice::Text);
    QJsonParseError JsonParseError;
    QJsonObject configData = QJsonDocument::fromJson(file.readAll(), &JsonParseError).object();
    file.close();
    setOverallConfirmedData(configData);
}
