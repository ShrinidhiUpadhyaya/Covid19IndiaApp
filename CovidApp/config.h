#pragma once

#include <QStandardPaths>
#include <QString>
#include <QStringList>

#define APP_COMPANY "OpenSource"
#define APP_NAME "Covid19IndiaApp"

#define BASE_DIR (QStandardPaths::writableLocation(QStandardPaths::AppDataLocation))

//Endpoints
#define OVERALL_DATA_ENDPOINT "https://api.rootnet.in/covid19-in/stats/history"
#define OVERALL_STATE_DATA_ENDPOINT "https://api.covid19india.org/data.json"
#define STATEWISE_VACCINE_DATA_ENDPOINT "https://api.covid19india.org/csv/latest/vaccine_doses_statewise.csv"
#define OVERALL_TEST_DATA_ENDPOINT "https://api.rootnet.in/covid19-in/stats/testing/latest"
#define STATE_HOSPITAL_LIST_ENDPOINT "https://api.rootnet.in/covid19-in/hospitals/medical-colleges"
#define STATE_DISTRICT_DATA_ENDPOINT "https://api.covid19india.org/state_district_wise.json"
#define STATE_DAILY_DATA_ENDPOINT "https://api.covid19india.org/states_daily.json"

//Filenames
#define OVERALL_DATA_FILENAME "overallDataConfig"
#define STATEWISE_VACCINE_DATA_FILENAME "stateVaccineDataConfig"
#define OVERALL_TEST_DATA_FILENAME "overallTestDataConfig"
#define STATE_HOSPITAL_LIST_FILENAME "hospitalListConfig"
#define STATE_DISTRICT_DATA_FILENAME "stateDistrictWiseDataConfig"
#define STATE_DAILY_DATA_FILENAME "statesDailyConfig"
#define STATE_ACTIVE_DATA_FILENAME "statesActiveDataConfig"
