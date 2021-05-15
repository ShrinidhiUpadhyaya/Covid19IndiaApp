#ifndef APPMANAGER_H
#define APPMANAGER_H

#include <QObject>
#include <QJsonObject>
#include <QJsonDocument>
#include <QNetworkReply>
#include <QFile>
#include <QJsonArray>
#include <QIODevice>

#include "config.h"

class AppManager : public QObject
{
    Q_OBJECT
public:
    explicit AppManager(QObject *parent = nullptr);

    Q_PROPERTY(QJsonArray statesActiveData READ statesActiveData WRITE setStatesActiveData NOTIFY statesActiveDataChanged);
    QJsonArray m_statesActiveData;
    void setStatesActiveData(QJsonArray);
    QJsonArray statesActiveData() const { return m_statesActiveData; }

    Q_PROPERTY(QJsonArray statesData READ statesData WRITE setStatesData NOTIFY statesDataChanged);
    QJsonArray m_statesData;
    void setStatesData(QJsonArray);
    QJsonArray statesData() const { return m_statesData; }

    Q_PROPERTY(QJsonArray currentStatesData READ currentStatesData WRITE setCurrentStatesData NOTIFY currentStatesDataChanged);
    QJsonArray m_currentStatesData;
    void setCurrentStatesData(QJsonArray);
    QJsonArray currentStatesData() const { return m_currentStatesData; }

    Q_PROPERTY(QJsonArray totalData READ totalData WRITE setTotalData NOTIFY totalDataChanged);
    QJsonArray m_totalData;
    void setTotalData(QJsonArray);
    QJsonArray totalData() const { return m_totalData; }

    Q_PROPERTY(int totalVaccineDoses READ totalVaccineDoses WRITE setTotalVaccineDoses NOTIFY totalVaccineDosesChanged);
    int m_totalVaccineDoses;
    void setTotalVaccineDoses(int);
    int totalVaccineDoses() const { return m_totalVaccineDoses; }

    Q_PROPERTY(QJsonArray stateDistricts READ stateDistricts WRITE setStateDistricts NOTIFY stateDistrictsChanged);
    QJsonArray m_setStateDistricts;
    void setStateDistricts(QJsonArray);
    QJsonArray stateDistricts() const { return m_setStateDistricts; }

    Q_PROPERTY(QJsonObject currentDistrictData READ currentDistrictData WRITE setCurrentDistrictData NOTIFY currentDistrictDataChanged);
    QJsonObject m_currentDistrictData;
    void setCurrentDistrictData(QJsonObject);
    QJsonObject currentDistrictData() const { return m_currentDistrictData; }

    Q_PROPERTY(QJsonObject overallConfirmedData READ overallConfirmedData WRITE setOverallConfirmedData NOTIFY overallConfirmedDataChanged);
    void setOverallConfirmedData(QJsonObject);
    QJsonObject overallConfirmedData() const { return m_overallConfirmedData; }
    QJsonObject m_overallConfirmedData;

    Q_PROPERTY(QJsonObject overallTestData READ overallTestData WRITE setOverallTestData NOTIFY overallTestDataChanged);
    void setOverallTestData(QJsonObject);
    QJsonObject overallTestData() const { return m_overallTestData; }
    QJsonObject m_overallTestData;

    Q_PROPERTY(QJsonArray hospitalListData READ hospitalListData WRITE setHospitalListData NOTIFY hospitalListDataChanged);
    void setHospitalListData(QJsonArray);
    QJsonArray hospitalListData() const { return m_hospitalListData; }
    QJsonArray m_hospitalListData;

    Q_PROPERTY(int currentStateVaccination READ currentStateVaccination WRITE setCurrentStateVaccination NOTIFY currentStateVaccinationChanged);
    void setCurrentStateVaccination(int);
    int currentStateVaccination() const { return m_currentStateVaccination; }
    int m_currentStateVaccination = 0;

    void requestStateData();
    void requestStatesDaily();
    void requestAllStatesVaccineData();
    void requestOverallConfirmedChart();
    void requestStateDistrictData();
    void requestOverallTestData();
    void requestHospitalsListData();

    Q_INVOKABLE void sortSatesDailyData(QString);
    Q_INVOKABLE void sortStateDistrictData(QString);
    Q_INVOKABLE void getCurrentStateTotalVaccinated(QString);
    Q_INVOKABLE void sortOverallConfirmedData(QByteArray);
    Q_INVOKABLE void searchDistrictData(QString,QString);
    Q_INVOKABLE void sortHospitalListData(QString);
    Q_INVOKABLE void refreshData();

    void setConfigError(QString);
    void sortSatesActiveData();
    void sortAllStatesVaccineData(QString);
    void sortTotalData(QJsonObject);
    void sortOverallTestData();

    void saveFilesData(QByteArray,QString);
    void saveFilesData(QJsonObject,QString);

    void readAllStatesVaccineData();
    void readOverallData();

    QNetworkAccessManager* m_netAccessMgr;
    QString m_configError;

signals:
    void configErrorChanged(QString);
    void totalDataChanged(QJsonArray);
    void statesActiveDataChanged(QJsonArray);
    void statesDataChanged(QJsonArray);
    void currentStatesDataChanged(QJsonArray);
    void totalVaccineDosesChanged(int);
    void stateDistrictsChanged(QJsonArray);
    void overallConfirmedDataChanged(QJsonObject);
    void currentDistrictDataChanged(QJsonObject);
    void overallTestDataChanged(QJsonObject);
    void hospitalListDataChanged(QJsonArray);
    void currentStateVaccinationChanged(int);
};

#endif // APPMANAGER_H
