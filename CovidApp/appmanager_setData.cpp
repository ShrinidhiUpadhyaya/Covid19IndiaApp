#include "appmanager.h"

void AppManager::setHospitalListData(QJsonArray data) {
    qDebug() << "Set Hospital List Data" << m_hospitalListData << data;

    if (m_hospitalListData == data) return;

    m_hospitalListData = data;

    emit hospitalListDataChanged(m_hospitalListData);
}


void AppManager::setTotalData(QJsonArray data) {
    qDebug() << "Set Total Data" << m_totalData << data;

    if (m_totalData == data) return;

    m_totalData = data;

    emit totalDataChanged(m_totalData);
}

void AppManager::setDailyData(QJsonObject data) {
    qDebug() << "Set Daily Data" << m_dailyData << data;

    if (m_dailyData == data) return;

    m_dailyData = data;

    emit dailyDataChanged(m_dailyData);
}

void AppManager::setOverallConfirmedData(QJsonObject data) {
    qDebug() << "Set Overall Confirmed Data" << m_overallConfirmedData << data;

    if (m_overallConfirmedData == data) return;

    m_overallConfirmedData = data;

    emit overallConfirmedDataChanged(data);
}

void AppManager::setConfigError(QString data) {
    qDebug() << "Set Config Error" << m_configError << data;

    if (m_configError == data) return;

    m_configError = data;

    emit configErrorChanged(data);
}

void AppManager::setTotalVaccineDoses(int value) {
    qDebug() << "Set Total Vaccine Doses" << m_totalVaccineDoses << value;

    if (m_totalVaccineDoses == value) return;

    m_totalVaccineDoses = value;

    emit totalVaccineDosesChanged(value);
}

void AppManager::setOverallTestData(QJsonObject data) {
    qDebug() << "Set Overall Test Data" << m_overallTestData << data;

    if (m_overallTestData == data) return;

    m_overallTestData = data;

    emit overallTestDataChanged(m_overallTestData);
}
void AppManager::setStatesActiveData(QJsonArray data) {
    qDebug() << "Set States Active Data" << m_statesActiveData << data;

    if (m_statesActiveData == data) return;

    m_statesActiveData = data;

    emit statesActiveDataChanged(m_statesActiveData);
}

void AppManager::setStatesData(QJsonArray data) {
    qDebug() << "Set States Data" << m_statesData << data;

    if (m_statesData == data) return;

    m_statesData = data;

    emit statesDataChanged(m_statesData);
}

void AppManager::setStateDistricts(QJsonArray data) {
    qDebug() << "Set State Districts Data" << m_setStateDistricts << data;

    if (m_setStateDistricts == data) return;

    m_setStateDistricts = data;

    emit stateDistrictsChanged(m_setStateDistricts);
}

void AppManager::setCurrentStatesData(QJsonArray data) {
    qDebug() << "Set Current States Data" << m_currentStatesData << data;

    if (m_currentStatesData == data) return;

    m_currentStatesData = data;

    emit currentStatesDataChanged(m_currentStatesData);
}

void AppManager::setCurrentDistrictData(QJsonObject data) {
    qDebug() << "Set Current District Data" << m_currentDistrictData << data;

    if (m_currentDistrictData == data) return;

    m_currentDistrictData = data;

    emit currentDistrictDataChanged(m_currentDistrictData);
}

void AppManager::setCurrentStateVaccination(int value) {
    qDebug() << "Set Current State Vaccinated" << m_currentStateVaccination << value;

    if (m_currentStateVaccination == value) return;

    m_currentStateVaccination = value;

    emit currentStateVaccinationChanged(m_currentStateVaccination);
}
