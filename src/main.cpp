// List with context menu project template


//#define USE_NEW_LIST_WAY

#ifdef USE_NEW_LIST_WAY
#include "gpaApp.h"
#else
#include "applicationui.hpp"
#endif

#include <bb/cascades/Application>
#include "coursedata/coursemodel.h"


using namespace bb::cascades;

Q_DECL_EXPORT int main(int argc, char **argv)
{
	// this is where the server is started etc
	// Registers the banner for QML
	QDir dir;
	QFile file;
	//create Qfile objects

	//copy the content of json files
	file.copy("asset:///json/mydata.json",dir.homePath()+"/mydata.json");
	qDebug(file.errorString().toUtf8());
	file.copy("asset:///json/GPA.json",dir.homePath()+"/GPA.json");
	qDebug(file.errorString().toUtf8());


	Application app(argc, argv);

	//create directory under data/


	// localization support
	QTranslator translator;
	QString locale_string = QLocale().name();
	QString filename = QString( "bbGpaApp_%1" ).arg( locale_string );
	if (translator.load(filename, "app/native/qm")) {
		app.installTranslator( &translator );
	}

	// create the application pane object to init UI etc.
#ifdef USE_NEW_LIST_WAY
	new CourseListApp(&app);
#else
	new ApplicationUI(&app);
#endif

	// we complete the transaction started in the app constructor and start the client event loop here
	return Application::exec();
	// when loop is exited the Application deletes the scene which deletes all its children (per qt rules for children)
}

