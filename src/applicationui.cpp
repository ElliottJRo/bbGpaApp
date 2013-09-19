// List with context menu project template
#include "applicationui.hpp"
#include "mylistmodel.hpp"
#include "recordmodel.hpp"
#include "coursedata/coursesettings.h"

#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>
#include <bb/cascades/advertisement/Banner>

using namespace bb::cascades;

ApplicationUI::ApplicationUI(bb::cascades::Application *app)
: QObject(app)
{
    // register the MyListModel C++ type to be visible in QML
    qmlRegisterType<RecordModel>("com.bbGpaApp.recordModel", 1, 0, "RecordModel");
    qmlRegisterType<MyListModel>("com.bbGpaApp.listModel", 1, 0, "MyListModel");
    qmlRegisterType<bb::cascades::advertisement::Banner>(
        "bb.cascades.advertisement", 1, 0, "Banner");

    qmlRegisterType<CourseSettings>("com.bbGpaApp.coursedata",1,0,"CourseSettings");

    // create scene document from main.qml asset
    // set parent to created document to ensure it exists for the whole application lifetime
    QmlDocument *qml = QmlDocument::create("asset:///main.qml").parent(this);

    // create root object for the UI
    AbstractPane *root = qml->createRootObject<AbstractPane>();
    // set created root object as a scene
    app->setScene(root);
}

