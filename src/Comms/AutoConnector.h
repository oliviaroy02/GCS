#pragma once
#include <QObject>

class AutoConnector : public QObject
{
    Q_OBJECT
public:
    explicit AutoConnector(QObject* parent = nullptr);
    Q_INVOKABLE void connectToSITL();
};