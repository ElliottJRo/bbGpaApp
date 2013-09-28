// List with context menu project template


//#define USE_NEW_LIST_WAY

#ifdef USE_NEW_LIST_WAY
#include "gpaApp.h"
#else
#include "applicationui.hpp"
#endif

#include <bb/cascades/Application>

//#include "coursedata/coursemodel.h"


using namespace bb::cascades;

bool qCopyDirectory(const QDir& fromDir, const QDir& toDir, bool bCoverIfFileExists);
bool qCopyJsonFile();

Q_DECL_EXPORT int main(int argc, char **argv)
{
	// this is where the server is started etc
	// Registers the banner for QML
	QString startingPath=QDir::currentPath();

	//TODO:change the last para to true when working on html files
	qCopyDirectory(QDir("app/native/assets/html"), QDir("data/html"), false);

	qCopyJsonFile();





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

bool qCopyJsonFile(){
	QDir dir("data/html");
	QFile fileMgr;
	bool flag=true;
	//Debug("start:  ");
	//qDebug(QDir::currentPath().toUtf8());
	qDebug(dir.absolutePath().toUtf8());

	if(!dir.exists()){
		dir.mkdir("data/html");
	}
	if(!dir.exists("data/html/mydata.json")){
		if(!fileMgr.copy("app/native/assets/json/mydata.json","data/html/mydata.json")){
			qDebug("Fail to copy file.");
			flag=false;
		}
		else
			qDebug("Copied!");
	}

	if(!dir.exists("data/html/GPA.json")){
		if(!fileMgr.copy("app/native/assets/json/GPA.json","data/html/GPA.json")){
			qDebug("Fail to copy file.");
			flag=false;
		}
		else
			qDebug("Copied!");
	}
	return flag;
}

bool qCopyDirectory(const QDir& fromDir, const QDir& toDir, bool bCoverIfFileExists)
{
	QDir formDir_ = fromDir;
	QDir toDir_ = toDir;

	if(!toDir_.exists())
	{
		if(!toDir_.mkdir(toDir.absolutePath()))
			return false;
	}

	QFileInfoList fileInfoList = formDir_.entryInfoList();
	foreach(QFileInfo fileInfo, fileInfoList)
	{
		if(fileInfo.fileName() == "." || fileInfo.fileName() == "..")
			continue;

		//copy sub-dir
		if(fileInfo.isDir())
		{
			//recursively copy dir
			if(!qCopyDirectory(fileInfo.filePath(), toDir_.filePath(fileInfo.fileName()),bCoverIfFileExists))
				return false;
		}
		//copy files
		else
		{
			if(bCoverIfFileExists && toDir_.exists(fileInfo.fileName()))
			{
				toDir_.remove(fileInfo.fileName());
			}
			if(!QFile::copy(fileInfo.filePath(), toDir_.filePath(fileInfo.fileName())))
			{
				return false;
			}
		}
	}
	return true;
}
