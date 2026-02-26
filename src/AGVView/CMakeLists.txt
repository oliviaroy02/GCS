find_package(Qt6 REQUIRED COMPONENTS Core Qml)

target_sources(${CMAKE_PROJECT_NAME}
    PRIVATE
        AGVView.qml
)

# Add QML module for AGVView
qt_add_qml_module(${CMAKE_PROJECT_NAME}
    URI QGroundControl.AGVView
    VERSION 1.0
    QML_FILES
        AGVView.qml
        AGVTelemetryGauge.qml
        AGVTelemetryItem.qml
        AGVCameraButton.qml
        AGVTabButton.qml
        SprayPanel.qml
        SpreadPanel.qml
        HarvestPanel.qml
        SowPanel.qml
        AGVPanelSection.qml
        AGVSectionHeader.qml
        AGVDivider.qml
        AGVSliderRow.qml
        AGVToggleRow.qml
        AGVActionButton.qml
        AGVActionBar.qml
        AGVChipGroup.qml
        AGVOptionCards.qml
        AGVStatRow.qml

    RESOURCE_PREFIX
        /qml
    OUTPUT_DIRECTORY
        ${CMAKE_BINARY_DIR}/qml/QGroundControl/AGVView
)