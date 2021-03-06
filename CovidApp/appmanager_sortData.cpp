#include "appmanager.h"

void AppManager::searchDistrictData(QString state,QString district) {
    qDebug() << "Search Current District Data";

    QJsonParseError JsonParseError;
    QJsonObject configData = QJsonDocument::fromJson(readFilesData(STATE_DISTRICT_DATA_FILENAME), &JsonParseError).object();

    if(!configData.isEmpty()) {
        QJsonObject stateObject = configData[state].toObject()["districtData"].toObject();
        QJsonObject districtObject = stateObject[district].toObject();
        QJsonObject finalData;
        finalData.insert("active",districtObject["active"].toInt());
        finalData.insert("confirmed",districtObject["confirmed"].toInt());
        finalData.insert("recovered",districtObject["recovered"].toInt());
        finalData.insert("deceased",districtObject["deceased"].toInt());

        QJsonObject deltaData = districtObject["delta"].toObject();

        finalData.insert("deltaConfirmed",deltaData["confirmed"].toInt());
        finalData.insert("deltaRecovered",deltaData["recovered"].toInt());
        finalData.insert("deltaDeceased",deltaData["deceased"].toInt());

        setCurrentDistrictData(finalData);
    }
}

void AppManager::sortAllStatesVaccineData(QString data) {
    qDebug() << "Sort All States Vaccine Data";

    if(!data.isEmpty()) {
        QStringList completeData;
        QStringList lastData;
        QJsonObject stateData;
        QJsonArray dataArray;

        completeData.clear();
        lastData.clear();
        completeData = data.split("\n");

        for(int i =1;i<completeData.size();i++) {
            lastData = completeData.at(i).split(",");
            dataArray = {};
            for(int j=0;j<lastData.size();j++) {
                dataArray.push_back(lastData.at(j).toInt());
            }
            stateData.insert(lastData.at(0),dataArray);
        }

        int size = completeData.size() - 1;
        lastData = completeData.at(size).split(",");

        saveFilesData(stateData,STATEWISE_VACCINE_DATA_FILENAME);
        setTotalVaccineDoses(lastData.at(lastData.size()-1).toInt());
    } else {
        readAllStatesVaccineData();
    }
}

void AppManager::sortHospitalListData(QString state) {
    qDebug() << "Sort Hospital List Data";

    QJsonParseError JsonParseError;
    QJsonArray configData = QJsonDocument::fromJson(readFilesData(STATE_HOSPITAL_LIST_FILENAME), &JsonParseError).object()["data"].toObject()["medicalColleges"].toArray();
    QJsonObject tempData;
    QJsonArray finalData;

    if(!configData.isEmpty()) {
        for(int i=0;i<configData.size()-1;i++) {
            QJsonObject data = configData[i].toObject();

            if(state == data["state"].toString()) {
                tempData.insert("name",data["name"]);
                tempData.insert("city",data["city"]);
                tempData.insert("ownership",data["ownership"]);
                tempData.insert("admissionCapacity",data["admissionCapacity"]);
                tempData.insert("hospitalBeds",data["hospitalBeds"]);
                finalData.append(tempData);
            }
        }

        setHospitalListData(finalData);
    }
}

void AppManager::sortTotalData(QJsonObject data) {
    qDebug() << "Set Total Data" << data;

    QJsonObject dataObj;
    QJsonArray finalData;

    dataObj.insert("confirmedCases",data["confirmed"]);
    dataObj.insert("recoveredCases",data["recovered"]);
    dataObj.insert("deceasedCases",data["deaths"]);
    dataObj.insert("activeCases",data["active"]);
    dataObj.insert("todayConfirmedCases",data["deltaconfirmed"]);
    dataObj.insert("todayRecoveredCases",data["deltarecovered"]);
    dataObj.insert("todayDeceasedCases",data["deltadeaths"]);
    dataObj.insert("lastUpdatedTime",data["lastupdatedtime"]);

    finalData.append(dataObj);

    setTotalData(finalData);
}

void AppManager::readOverallData() {
    qDebug() << "Sort Overall Confirmed Data";

    QJsonParseError err;
    QJsonObject configData = QJsonDocument::fromJson(readFilesData(OVERALL_DATA_FILENAME), &err).object();

    if(!configData.isEmpty()) {
        QJsonArray dateArray;
        QJsonArray dataArray;
        QJsonArray dischargedArray;
        QJsonArray deceasedArray;
        QJsonObject finalData;

        if(!configData.isEmpty()) {
            QJsonArray hitsArray = configData["data"].toArray();
            QJsonArray stateActiveDataArray;
            QJsonArray stateDataArray;

            for(int i= 0; i < hitsArray.size() - 1;i++) {
                QJsonObject dataObj = hitsArray[i].toObject();
                QJsonObject summaryObj = dataObj["summary"].toObject();
                QString rawDate = dataObj["day"].toString();
                int totalCount = summaryObj["total"].toInt();
                int dischargedCount= summaryObj["discharged"].toInt();
                int deathsCount = summaryObj["deaths"].toInt();
                QJsonArray regionalObj = dataObj["regional"].toArray();

                dateArray.append(rawDate);
                dataArray.append(totalCount);
                dischargedArray.append(dischargedCount);
                deceasedArray.append(deathsCount);
            }

            finalData.insert("date",dateArray);
            finalData.insert("total",dataArray);
            finalData.insert("recovered",dischargedArray);
            finalData.insert("deceased",deceasedArray);

            setOverallConfirmedData(finalData);
        }
    }
}

void AppManager::sortDailyData(QJsonObject data) {
    qDebug() << "Sort Daily Data";

    QJsonArray hitsArray = data["cases_time_series"].toArray();
    QJsonArray confirmedArray;
    QJsonArray recoveredArray;
    QJsonArray deceasedArray;
    QJsonArray dateArray;
    QJsonObject dailyData;

    for(int i=0;i<hitsArray.size()-1;i++) {
        QJsonObject tempData = hitsArray.at(i).toObject();

        confirmedArray.insert(confirmedArray.size(),tempData["dailyconfirmed"].toString().toInt());
        recoveredArray.insert(recoveredArray.size(),tempData["dailyrecovered"].toString().toInt());
        deceasedArray.insert(deceasedArray.size(),tempData["dailydeceased"].toString().toInt());
        dateArray.insert(dateArray.size(),tempData["dateymd"].toString());
    }

    dailyData.insert("confirmed",confirmedArray);
    dailyData.insert("recovered",recoveredArray);
    dailyData.insert("deceased",deceasedArray);
    dailyData.insert("date",dateArray);

    setDailyData(dailyData);
}

void AppManager::sortOverallTestData() {
    qDebug() << "Sort Overall Test Data";

    QJsonParseError JsonParseError;
    QJsonObject configData = QJsonDocument::fromJson(readFilesData(OVERALL_TEST_DATA_FILENAME), &JsonParseError).object()["data"].toObject();
    if(!configData.isEmpty()) {
        QJsonObject finalData;
        finalData.insert("date",configData["day"]);
        finalData.insert("totalTests",configData["totalSamplesTested"]);
        finalData.insert("source",configData["source"]);
        setOverallTestData(finalData);
    }
}

void AppManager::sortSatesActiveData() {
    qDebug() << "Sort States Active Data";

    QJsonParseError err;
    QJsonObject configData = QJsonDocument::fromJson(readFilesData(STATE_ACTIVE_DATA_FILENAME), &err).object();

    if(!configData.isEmpty()) {
        QJsonArray hitsArray = configData["statewise"].toArray();
        QJsonArray stateActiveDataArray;
        QJsonArray finalData;

        for(int i=1;i < hitsArray.size() - 1;i++) {
            QJsonObject dataObj = hitsArray[i].toObject();
            QJsonObject tempStatesActiveDataObj;
            QJsonObject tempStatesDataObj;

            tempStatesActiveDataObj.insert("stateName",dataObj["state"]);
            tempStatesActiveDataObj.insert("activeCases",dataObj["active"]);
            stateActiveDataArray.append(tempStatesActiveDataObj);

            tempStatesDataObj.insert("stateName",dataObj["state"]);
            tempStatesDataObj.insert("activeCases",dataObj["active"]);
            tempStatesDataObj.insert("confirmedCases",dataObj["confirmed"]);
            tempStatesDataObj.insert("deceasedCases",dataObj["deaths"]);
            tempStatesDataObj.insert("recoveredCases",dataObj["recovered"]);
            tempStatesDataObj.insert("stateCode",dataObj["statecode"]);

            tempStatesDataObj.insert("todayConfirmedCases",dataObj["deltaconfirmed"]);
            tempStatesDataObj.insert("todayDeceasedCases",dataObj["deltadeaths"]);
            tempStatesDataObj.insert("todayRecoveredCases",dataObj["deltarecovered"]);

            tempStatesDataObj.insert("lastUpdatedTime",dataObj["lastupdatedtime"]);

            finalData.append(tempStatesDataObj);
        }

        sortDailyData(configData);
        setStatesActiveData(stateActiveDataArray);
        setStatesData(finalData);
        loadAppData(hitsArray[0].toObject().size() > 0);
        sortTotalData(hitsArray[0].toObject());
    }
}

void AppManager::sortSatesDailyData(QString stateName) {
    qDebug() << "Sort States Daily Data";

    stateName = stateName.toLower();
    QJsonArray deceasedArray;
    QJsonArray recoveredArray;
    QJsonArray confirmedArray;
    QJsonArray dateArray;
    QJsonArray finalData;

    QJsonParseError JsonParseError;
    QJsonObject configData = QJsonDocument::fromJson(readFilesData(STATE_DAILY_DATA_FILENAME), &JsonParseError).object();

    if(!configData.isEmpty()) {
        QJsonArray hitsArray = configData["states_daily"].toArray();
        QJsonArray stateActiveDataArray;
        QJsonArray stateDataArray;
        for(int i= hitsArray.size() - 1; i > hitsArray.size() - 1 - 15;i--) {
            QJsonObject dataObj = hitsArray[i].toObject();
            QString date = dataObj["date"].toString().mid(0,6);

            if(dataObj["status"] == "Deceased") {
                deceasedArray.push_front(dataObj[stateName]);

                if(!dateArray.contains(date)) {
                    dateArray.push_front(date);
                }
            }

            else if(dataObj["status"] == "Recovered") {
                recoveredArray.push_front(dataObj[stateName]);
                if(!dateArray.contains(date)) {
                    dateArray.push_front(date);
                }
            }

            else if(dataObj["status"] == "Confirmed") {
                confirmedArray.push_front(dataObj[stateName]);
                if(!dateArray.contains(date)) {
                    dateArray.push_front(date);
                }
            }

            else {
                qDebug() << "Invalid Search";
            }
        }

        finalData.append(confirmedArray);
        finalData.append(recoveredArray);
        finalData.append(deceasedArray);
        finalData.append(dateArray);

        setCurrentStatesData(finalData);
    }
}

void AppManager::sortStateDistrictData(QString state) {
    qDebug() << "Sort State District Data";

    QJsonParseError JsonParseError;
    QJsonObject configData = QJsonDocument::fromJson(readFilesData(STATE_DISTRICT_DATA_FILENAME)/*file.readAll()*/, &JsonParseError).object();

    if(!configData.isEmpty()) {
        QJsonObject hitsArray = configData[state].toObject()["districtData"].toObject();
        QJsonArray stateActiveDataArray;
        QJsonArray finalData;

        QJsonObject::iterator i;

        for (i = hitsArray.begin(); i != hitsArray.end(); ++i) {
            if (i.value().isObject()) {
                finalData.append(i.key());
            } else {
                qDebug() << i.key() << i.value().toString();
            }
        }

        setStateDistricts(finalData);
    }
}

void AppManager::getCurrentStateTotalVaccinated(QString state) {
    qDebug() << "Get Current State Total Vaccinated" << state;

    QJsonParseError JsonParseError;
    QJsonObject configData = QJsonDocument::fromJson(readFilesData(STATEWISE_VACCINE_DATA_FILENAME), &JsonParseError).object();

    if(!configData.isEmpty()) {
        QJsonArray finalData = configData[state].toArray();

        setCurrentStateVaccination(finalData.at(finalData.size()-1).toInt());
    }
}

void AppManager::saveFilesData(QJsonObject data, QString fileName) {
    qDebug() << "Save Files Data";

    QFile saveFile(QString("%1%2").arg(BASE_DIR,fileName));
    QJsonDocument doc(data);
    saveFile.open(QIODevice::WriteOnly);
    saveFile.write(doc.toJson());
    saveFile.close();
}

void AppManager::refreshData() {
    qDebug() << "Refresh Data";

    requestStatesDaily();
    requestAllStatesVaccineData();
    requestStateData();
    requestStateDistrictData();
    requestOverallTestData();
    requestHospitalsListData();
    requestOverallConfirmedChart();
}

QJsonObject AppManager::getSpecificDateData(QString date) {
    qDebug() << "Get Specific Date" << date;

    QJsonParseError err;
    QJsonObject configData = QJsonDocument::fromJson(readFilesData(OVERALL_DATA_FILENAME), &err).object();

    if(!configData.isEmpty()) {
        QJsonArray hitsArray = configData["data"].toArray();

        for(int i=0;i<hitsArray.size();i++) {
            if(hitsArray.at(i).toObject()["day"].toString() == date) {
                qDebug() << "data found";
                return hitsArray.at(i).toObject();
            }
        }
    }
    return {};
}
