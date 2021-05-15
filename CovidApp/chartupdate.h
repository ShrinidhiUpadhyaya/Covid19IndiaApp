#ifndef CHARTUPDATE_H
#define CHARTUPDATE_H

#include <QtCore/QObject>
#include <QtCharts/QAbstractSeries>
#include <QQmlApplicationEngine>
#include <QJsonArray>
#include <QLineSeries>
#include <QDateTime>
#include <QtCharts/QXYSeries>
#include <QtCore/QDebug>

QT_BEGIN_NAMESPACE
class QQuickView;
QT_END_NAMESPACE

QT_CHARTS_USE_NAMESPACE

class ChartUpdate : public QObject
{
    Q_OBJECT
public:
    explicit ChartUpdate(QQmlApplicationEngine *appViewer, QObject *parent = 0);

Q_SIGNALS:

public slots:
    void createLineChart(QAbstractSeries *series,QJsonArray,QJsonArray);

private:
    QQmlApplicationEngine *m_appViewer;
signals:
};

#endif // CHARTUPDATE_H


