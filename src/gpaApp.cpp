

#include "gpaApp.h"
#include "coursedata/coursemodel.h"
//#include "coursedata/coursesettings.h"
//#include "coursebbm/coursebbmmanager.h"

#include <bb/cascades/AbstractPane>
#include <bb/cascades/LocaleHandler>
#include <bb/cascades/QmlDocument>

#include <bb/system/InvokeManager>
#include <bb/system/InvokeRequest>

using namespace bb::cascades;

CourseListApp::CourseListApp() {

  // Initiate the Invocation Manager, so that we can react on incoming course items
  // (see bar-descriptor.xml for how to register as an invokable app)
  mInvokeManager = new bb::system::InvokeManager(this);

  // Connect to the invoke managers invoked signal.
  QObject::connect(mInvokeManager, SIGNAL(invoked(const bb::system::InvokeRequest&)),
          SLOT(handleInvoke(const bb::system::InvokeRequest&)));

  // Prepare localization.Connect to the LocaleHandlers systemLanguaged change signal, this will
  // tell the application when it is time to load a new set of language strings.
  mTranslator = new QTranslator(this);
  mLocaleHandler = new LocaleHandler(this);
  connect(mLocaleHandler, SIGNAL(systemLanguageChanged()), SLOT(onSystemLanguageChanged()));
  onSystemLanguageChanged();

  // Initialize the courseItem title property
  mCourseItemTitle = "";

  // Set the application organization and name, which is used by QSettings
  // when saving values to the persistent store.
  QCoreApplication::setOrganizationName("Example");
  QCoreApplication::setApplicationName("Course List Settings");

  // The model for populating the course list is registered, so that it and all its
  // properties can be accessed directly from QML. This is done before creating the
  // QmlDocument below so that it is available when the corresponding QML component
  // is needed (see main.qml).
  qmlRegisterType<CourseModel>("com.courselist.coursedata", 1, 0, "CourseModel");

  // The application settings object used to store the BBM connection state
  //qmlRegisterType<CourseSettings>("com.courselist.coursedata", 1, 0, "CourseSettings");

  // The BBM manager that can connect the application to BBM and update the BBM status message
//  qmlRegisterType<CourseBBMManager>("com.courselist.coursebbm", 1, 0, "CourseBBMManager");

  // Create a QMLDocument and load it, using build patterns.
  QmlDocument *qml = QmlDocument::create("asset:///main.qml").parent(this);

  // Make this object available to the UI as context property
  qml->setContextProperty("_app", this);

  if (!qml->hasErrors()) {

      AbstractPane *appPage = qml->createRootObject<AbstractPane>();

      if (appPage) {
          // Set the main scene to the application Page.
          Application::instance()->setScene(appPage);
      }
  } else {
    printf("ERROR LOADING QML FILE");
  }
}


void CourseListApp::handleInvoke(const bb::system::InvokeRequest& invoke)
{
    //Grab the .buk file we were invoked with.
    QUrl uri = invoke.uri();

    QFile file(uri.toLocalFile());

    mCourseItemTitle = "";

    if (file.open(QIODevice::ReadOnly)) {
        QTextStream in(&file);
        while (!in.atEnd()) {
            mCourseItemTitle += in.readLine();
        }
        file.close();
    }

    emit incomingCourseItem();

}

QString CourseListApp::courseItemTitle() const
{
    return mCourseItemTitle;
}

void CourseListApp::onSystemLanguageChanged()
{
    // Remove the old translator to make room for the new translation.
    QCoreApplication::instance()->removeTranslator(mTranslator);

    // Initiate, load and install the application translation files.
    QString localeString = QLocale().name();
    QString fileName = QString("courselist_%1").arg(localeString);
    if (mTranslator->load(fileName, "app/native/qm")) {
        QCoreApplication::instance()->installTranslator(mTranslator);
    }
}

