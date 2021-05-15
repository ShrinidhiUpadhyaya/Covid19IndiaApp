#include "chartupdate.h"

QT_CHARTS_USE_NAMESPACE

Q_DECLARE_METATYPE(QAbstractSeries *)
Q_DECLARE_METATYPE(QAbstractAxis *)

ChartUpdate::ChartUpdate(QQmlApplicationEngine *appViewer, QObject *parent) :
    QObject(parent),
    m_appViewer(appViewer)
{
    qRegisterMetaType<QAbstractSeries*>();
    qRegisterMetaType<QAbstractAxis*>();
}

void ChartUpdate::createLineChart(QAbstractSeries *series,QJsonArray array1,QJsonArray array2)
{
    qDebug() << "Create Line Chart";

    if (series) {
        QXYSeries *xySeries = static_cast<QXYSeries *>(series);
        for(int i=0;i < array1.size();i++) {
            QDateTime momentInTime;
            momentInTime=QDateTime::fromString(array1[i].toString(),"yyyy-MM-dd");
            xySeries->append(momentInTime.toMSecsSinceEpoch(),array2[i].toDouble());
        }
    }
}
