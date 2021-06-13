#include "appmanager.h"

AppManager::AppManager(QObject *parent) : QObject(parent),
    m_netAccessMgr(new QNetworkAccessManager(this)),
    engine(new QQmlApplicationEngine(this)),
    chartUpdate(new ChartUpdate(engine))
{
    showApp();
    requestStatesDaily();
    requestAllStatesVaccineData();
    requestStateData();
    requestStateDistrictData();
    requestOverallTestData();
    requestHospitalsListData();
    requestOverallConfirmedChart();
}

//Request Confirmed,Active,Recovered,Deceased Data
void AppManager::requestOverallConfirmedChart() {
    qDebug() << "Request Overall Confirmed Chart";

    QString searchString = QString(OVERALL_DATA_ENDPOINT);
    QNetworkRequest request(searchString);
    QSslConfiguration conf = request.sslConfiguration();
    conf.setPeerVerifyMode(QSslSocket::VerifyNone);
    request.setSslConfiguration(conf);
    auto networkReply = m_netAccessMgr->get(request);

    connect(networkReply, &QNetworkReply::finished, [=] {
        if (!networkReply->error()) {
            qDebug() << "(requestOverallConfirmedChart) Successfull Response";
            auto data = networkReply->readAll();
            saveFilesData(QJsonDocument::fromJson(data).object(),OVERALL_DATA_FILENAME);
            readOverallData();
            setConfigError("");
        }
    });

    connect(networkReply,
            static_cast<void (QNetworkReply::*)(QNetworkReply::NetworkError)>(&QNetworkReply::error),
            [=](QNetworkReply::NetworkError code) {
        qDebug() << "(requestOverallConfirmedChart) Error connecting to the api:" << networkReply->errorString() << endl
                 << "Error code:" << code;
        qDebug() << networkReply->readAll();
        setConfigError(networkReply->errorString());
        readOverallData();
    });
}

//Request All States Vaccination Data
void AppManager::requestAllStatesVaccineData() {
    qDebug() << "Request all states vaccine data";

    QString searchString = QString(STATEWISE_VACCINE_DATA_ENDPOINT);
    QNetworkRequest request(searchString);
    QSslConfiguration conf = request.sslConfiguration();
    conf.setPeerVerifyMode(QSslSocket::VerifyNone);
    request.setSslConfiguration(conf);
    auto networkReply = m_netAccessMgr->get(request);

    connect(networkReply, &QNetworkReply::finished, [=] {
        if (!networkReply->error()) {
            qDebug() << "(requestAllStatesVaccineData) Successfull Response";
            auto data = networkReply->readAll();
            sortAllStatesVaccineData(data);
            setConfigError("");
        }
    });

    connect(networkReply,
            static_cast<void (QNetworkReply::*)(QNetworkReply::NetworkError)>(&QNetworkReply::error),
            [=](QNetworkReply::NetworkError code) {
        qDebug() << "(requestAllStatesVaccineData) Error connecting to the api:" << networkReply->errorString() << endl
                 << "Error code:" << code;
        qDebug() << networkReply->readAll();
        setConfigError(networkReply->errorString());
        readAllStatesVaccineData();
    });
}

//Rquest To Get Overall Tests Done in the Country
void AppManager::requestOverallTestData() {
    qDebug() << "Request Overall Test Data";

    QString search = QString(OVERALL_TEST_DATA_ENDPOINT);
    QNetworkRequest request(search);
    QSslConfiguration conf = request.sslConfiguration();
    conf.setPeerVerifyMode(QSslSocket::VerifyNone);
    request.setSslConfiguration(conf);
    auto networkReply = m_netAccessMgr->get(request);

    connect(networkReply, &QNetworkReply::finished, [=] {
        if (!networkReply->error()) {
            qDebug() << "(requestOverallTestData) Successfull Response";
            auto data = networkReply->readAll();
            saveFilesData(QJsonDocument::fromJson(data).object(),OVERALL_TEST_DATA_FILENAME);
            sortOverallTestData();
            setConfigError("");
        }
    });

    connect(networkReply,
            static_cast<void (QNetworkReply::*)(QNetworkReply::NetworkError)>(&QNetworkReply::error),
            [=](QNetworkReply::NetworkError code) {
        qDebug() << "(requestOverallTestData) Error connecting to the api:" << networkReply->errorString() << endl
                 << "Error code:" << code;
        qDebug() << networkReply->readAll();
        setConfigError(networkReply->errorString());
        sortOverallTestData();
    });
}

//Request for List of Hospitals in State
void AppManager::requestHospitalsListData() {
    qDebug() << "Request Hospitals List Data";

    QString search = QString(STATE_HOSPITAL_LIST_ENDPOINT);
    QNetworkRequest request(search);
    QSslConfiguration conf = request.sslConfiguration();
    conf.setPeerVerifyMode(QSslSocket::VerifyNone);
    request.setSslConfiguration(conf);
    auto networkReply = m_netAccessMgr->get(request);

    connect(networkReply, &QNetworkReply::finished, [=] {
        if (!networkReply->error()) {
            qDebug() << "(requestHospitalsListData) Successfull Response";
            auto data = networkReply->readAll();
            saveFilesData(QJsonDocument::fromJson(data).object(),STATE_HOSPITAL_LIST_FILENAME);
            setConfigError("");
        }
    });

    connect(networkReply,
            static_cast<void (QNetworkReply::*)(QNetworkReply::NetworkError)>(&QNetworkReply::error),
            [=](QNetworkReply::NetworkError code) {
        qDebug() << "(requestHospitalsListData) Error connecting to the api:" << networkReply->errorString() << endl
                 << "Error code:" << code;
        qDebug() << networkReply->readAll();
        setConfigError(networkReply->errorString());
    });
}

//Request for getting districts name and its cases
void AppManager::requestStateDistrictData() {
    qDebug() << "Search State District Data";

    QString searchString = QString(STATE_DISTRICT_DATA_ENDPOINT);
    QNetworkRequest request(searchString);
    QSslConfiguration conf = request.sslConfiguration();
    conf.setPeerVerifyMode(QSslSocket::VerifyNone);
    request.setSslConfiguration(conf);
    auto networkReply = m_netAccessMgr->get(request);

    connect(networkReply, &QNetworkReply::finished, [=] {
        if (!networkReply->error()) {
            qDebug() << "(requestStateDistrictData) Successfull Response";
            auto data = networkReply->readAll();
            saveFilesData(QJsonDocument::fromJson(data).object(),STATE_DISTRICT_DATA_FILENAME);
            setConfigError("");
        }
    });

    connect(networkReply,
            static_cast<void (QNetworkReply::*)(QNetworkReply::NetworkError)>(&QNetworkReply::error),
            [=](QNetworkReply::NetworkError code) {
        qDebug() << "(requestStateDistrictData) Error connecting to the api:" << networkReply->errorString() << endl
                 << "Error code:" << code;
        qDebug() << networkReply->readAll();
        setConfigError(networkReply->errorString());
    });
}

//Request to get all data of state
void AppManager::requestStateData() {
    qDebug() << "Request State Data";

    QString searchString = QString(OVERALL_STATE_DATA_ENDPOINT);
    QNetworkRequest request(searchString);
    QSslConfiguration conf = request.sslConfiguration();
    conf.setPeerVerifyMode(QSslSocket::VerifyNone);
    request.setSslConfiguration(conf);
    auto networkReply = m_netAccessMgr->get(request);

    connect(networkReply, &QNetworkReply::finished, [=] {
        if (!networkReply->error()) {
            qDebug() << "(requestStateData) Successfull Response";
            auto data = networkReply->readAll();
            saveFilesData(QJsonDocument::fromJson(data).object(),STATE_ACTIVE_DATA_FILENAME);
            sortSatesActiveData();
            setConfigError("");
        }
    });

    connect(networkReply,
            static_cast<void (QNetworkReply::*)(QNetworkReply::NetworkError)>(&QNetworkReply::error),
            [=](QNetworkReply::NetworkError code) {
        qDebug() << "(requestStateData) Error connecting to the api" << networkReply->errorString() << endl
                 << "Error code:" << code;
        qDebug() << networkReply->readAll();
        setConfigError(networkReply->errorString());
        sortSatesActiveData();
    });
}

//Request to get last 5 days data of a states
void AppManager::requestStatesDaily() {
    qDebug() << "Request Stated Daily";

    QString searchString = QString(STATE_DAILY_DATA_ENDPOINT);
    QNetworkRequest request(searchString);
    QSslConfiguration conf = request.sslConfiguration();
    conf.setPeerVerifyMode(QSslSocket::VerifyNone);
    request.setSslConfiguration(conf);
    auto networkReply = m_netAccessMgr->get(request);

    connect(networkReply, &QNetworkReply::finished, [=] {
        if (!networkReply->error()) {
            qDebug() << "(requestStatesDaily) Successfull Response";
            auto data = networkReply->readAll();
            saveFilesData(QJsonDocument::fromJson(data).object(),STATE_DAILY_DATA_FILENAME);
            setConfigError("");
        }
    });

    connect(networkReply,
            static_cast<void (QNetworkReply::*)(QNetworkReply::NetworkError)>(&QNetworkReply::error),
            [=](QNetworkReply::NetworkError code) {
        qDebug() << "(requestStatesDaily) Error connecting to the api:" << networkReply->errorString() << endl
                 << "Error code:" << code;
        qDebug() << networkReply->readAll();
        setConfigError(networkReply->errorString());
    });
}
