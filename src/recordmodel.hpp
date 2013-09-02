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
#include <bb/cascades/QListDataModel>

class RecordModel: public bb::cascades::QVariantListDataModel {
	Q_OBJECT
public: Q_INVOKABLE bool load();
		Q_INVOKABLE int totalUnits();
		Q_INVOKABLE double cGPA();
		Q_INVOKABLE bool saveNewRecord(QVariant time,QVariant GPA,QVariant credits);
		Q_INVOKABLE void Debugger(QVariant a,QVariant b);
		Q_INVOKABLE bool deleteSelectedItems(const QVariantList selectionList);

public:
	RecordModel(QObject* parent = 0);
	QString filePath;
	QVariantList itemList;
	bool reload();
	virtual ~RecordModel();
protected:
	bool saveToFile(QVariant newItem=0);
	void deleteItemAtIndex(QVariantList indexPath);

};

#endif /* RecordModel_HPP_ */
