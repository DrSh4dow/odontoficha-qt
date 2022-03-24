cmake_minimum_required(VERSION 3.16)

project(odontoficha VERSION 0.1 LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2 COMPONENTS Quick Core Sql Qml Gui PrintSupport Widgets REQUIRED)

qt_add_executable(appodontoficha
    resources.qrc
    main.cpp
    connection.h
    patientsqlmodel.h patientsqlmodel.cpp
    patient.h patient.cpp
    fichasqlmodel.h fichasqlmodel.cpp
    utility.h utility.cpp
    customfilterproxymodel.h customfilterproxymodel.cpp
)

qt_add_qml_module(appodontoficha
    URI odontoficha
    VERSION 1.0
    QML_FILES
        qml/main.qml
        qml/NavBar.qml
        qml/DashboardLayout.qml
        qml/PacientesLayout.qml
        qml/AgendaLayout.qml
        qml/RecetasLayout.qml
        qml/PresupuestoLayout.qml
        qml/ConfiguracionLayout.qml
        qml/PacienteRow.qml
        qml/PacientesHeader.qml
        qml/FichaClinica.qml
        qml/FichaLayout.qml
        qml/AntecedentesLayout.qml
        qml/DocumentosLayout.qml
        qml/NuevaFichaLayout.qml
        qml/PlanAccionLayout.qml
)

set_target_properties(appodontoficha PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_compile_definitions(appodontoficha
    PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(appodontoficha
    PRIVATE Qt6::Quick Qt6::Qml Qt6::Core Qt6::Sql Qt6::Gui Qt6::PrintSupport Qt6::Widgets)
