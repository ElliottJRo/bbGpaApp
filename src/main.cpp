// List with context menu project template


//#define USE_NEW_LIST_WAY

#ifdef USE_NEW_LIST_WAY
#include "gpaApp.h"
#else
#include "applicationui.hpp"
#endif

#include <bb/cascades/Application>
#include <bb/system/InvokeManager>
#include <QString>
#include "coursedata/coursemodel.h"


using namespace bb::cascades;

Q_DECL_EXPORT int main(int argc, char **argv)
{
	// this is where the server is started etc
	// Registers the banner for QML
	QString startingPath=QDir::currentPath();
	QDir dir;
	QFile fileMgr;
	qDebug(dir.absolutePath().toUtf8());

	dir.mkdir("data/json");
	if(!dir.exists("data/json/mydata.json")){
		if(!fileMgr.copy("app/native/assets/json/mydata.json","data/json/mydata.json"))
			qDebug("Fail to copy file.");
		else
			qDebug("Copied!");
	}

	if(!dir.exists("data/json/GPA.json")){
		if(!fileMgr.copy("app/native/assets/json/GPA.json","data/json/GPA.json"))
			qDebug("Fail to copy file.");
		else
			qDebug("Copied!");
	}








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

