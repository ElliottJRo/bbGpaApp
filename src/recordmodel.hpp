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
public:
	RecordModel(QObject* parent = 0);
	QString filePath;
	QVariantList itemList;
	virtual ~RecordModel();
};

#endif /* RecordModel_HPP_ */
