#include "AutoConnector.h"
#include "TCPLink.h"
#include "LinkManager.h"

AutoConnector::AutoConnector(QObject* parent) : QObject(parent) {}

void AutoConnector::connectToSITL()
{
    LinkManager* linkManager = LinkManager::instance();
    if (!linkManager) {
        qWarning() << "AutoConnector: LinkManager not available";
        return;
    }

    // Create config via the public API
    LinkConfiguration* config = linkManager->createConfiguration(
        static_cast<int>(LinkConfiguration::TypeTcp),
        "SITL"
    );

    if (!config) {
        qWarning() << "AutoConnector: Failed to create TCP configuration";
        return;
    }

    TCPConfiguration* tcpConfig = qobject_cast<TCPConfiguration*>(config);
    if (!tcpConfig) {
        qWarning() << "AutoConnector: Failed to cast to TCPConfiguration";
        delete config;
        return;
    }

    tcpConfig->setHost("127.0.0.1");
    tcpConfig->setPort(5762);

    // endCreateConfiguration adds it to the manager
    linkManager->endCreateConfiguration(tcpConfig);

    // Now connect
    linkManager->createConnectedLink(tcpConfig);
}