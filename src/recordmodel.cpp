/*
 * RecordModel.cpp
 *
 *  Created on: Aug 29, 2013
 *      Author: Ray
 */

#include "recordmodel.hpp"
#include <bb/data/JsonDataAccess>


using namespace bb::cascades;

RecordModel::RecordModel(QObject* parent): bb::cascades::QVariantListDataModel()
{
	filePath="app/native/assets/json/GPA.json";
	load();

	setParent(parent);

}

bool RecordModel::load(){
	bb::data::JsonDataAccess jda;
	QVariant record = jda.load(filePath);
	QVariantList templist;
	    if (jda.hasError()) {
	        bb::data::DataAccessError error = jda.error();
	        qDebug() << filePath << "JSON loading error: " << error.errorType() << ": " << error.errorMessage();
	        return false;
	    }
	    else {
	        qDebug() << filePath << "JSON data loaded OK!";
	        itemList=record.toMap()["data"].value<QVariantList>();
	        append(itemList);
	        foreach (QVariant v, itemList)
	        {
	          qDebug() << "String Value: " << v.toMap()["recordTime"] << "\n";
	          qDebug() << "String Value: " << v.toMap()["gpa"]<< "\n";
	        }
	        return true;
	    }
}

RecordModel::~RecordModel() {
	// TODO Auto-generated destructor stub
}

