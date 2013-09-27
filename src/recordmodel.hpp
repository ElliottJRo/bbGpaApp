/*
 * RecordModel.h
 *
 *  Created on: Aug 29, 2013
 *      Author: Ray
 */

#ifndef RecordModel_HPP_
#define RecordModel_HPP_

#include <qobject.h>
#include <QtCore>
#include <string>
#include <bb/cascades/QListDataModel>
using namespace std;

class RecordModel: public bb::cascades::QVariantListDataModel {
	Q_OBJECT
public: Q_INVOKABLE bool load();
		Q_INVOKABLE int totalUnits();
		Q_INVOKABLE double cGPA();
		Q_INVOKABLE void setFilePath(const QString& file_name);
		Q_INVOKABLE bool saveNewRecord(QString time,double GPA,int credits);
		Q_INVOKABLE void Debugger(QVariant a,QVariant b);
		Q_INVOKABLE bool deleteSelectedItems(const QVariantList selectionList);
		Q_INVOKABLE void updateSaveState(QObject* ins);
		Q_INVOKABLE void updateLoadState(QObject* ins);
		Q_PROPERTY(QString saveState READ saveState WRITE setSaveState);
		Q_PROPERTY(QString loadState READ loadState WRITE setLoadState);
public:
	RecordModel(QObject* parent = 0);
	QString filePath;
	QVariantList itemList;
	QString saveState();
	void setSaveState(const QString &t);
	QString loadState();
	void setLoadState(const QString &t);
	bool reload();
	virtual ~RecordModel();
protected:
	QString _saveState;
	QString _loadState;
	bool saveToFile(QVariant newItem=0);
	void deleteItemAtIndex(QVariantList indexPath);

};

#endif /* RecordModel_HPP_ */
