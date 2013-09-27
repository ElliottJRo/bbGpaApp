/*
 * RecordModel.cpp
 *
 *  Created on: Aug 29, 2013
 *      Author: Ray
 */

#include "recordmodel.hpp"
#include <bb/data/JsonDataAccess>
#include <bb/system/InvokeManager>
#include<bb/cascades/Label>
#include <bb/PpsObject>
using namespace bb::cascades;




RecordModel::RecordModel(QObject* parent): bb::cascades::QVariantListDataModel()
{
	filePath="data/GPA.json";
	load();

	setParent(parent);

}

bool RecordModel::load(){
	_loadState="Start loading...";
	bb::data::JsonDataAccess jda;
	QVariantMap record = jda.load(filePath).value<QVariantMap>();
	QVariantList templist;
	if (jda.hasError()) {
		bb::data::DataAccessError error = jda.error();
		qDebug() << filePath << "JSON loading error: " << error.errorType() << ": " << error.errorMessage();
		_loadState=error.errorMessage();
		return false;
	}
	else {
		qDebug() << filePath << "JSON data loaded OK!";
		QDir abs=QDir(filePath);
		_loadState=abs.absolutePath();
		itemList=record["data"].value<QVariantList>();

		QListIterator<QVariant> i(itemList);
		i.toBack();
		while (i.hasPrevious())
			templist.append(i.previous());
		append(templist);
		//	        foreach (QVariant v, itemList)
		//	        {
		//	          qDebug() << "String Value: " << v.toMap()["recordTime"] << "\n";
		//	          qDebug() << "String Value: " << v.toMap()["gpa"]<< "\n";
		//	        }
		return true;
	}
}

bool RecordModel::reload(){
	clear();
	return load();
}

RecordModel::~RecordModel() {
	// TODO Auto-generated destructor stub
}

int RecordModel::totalUnits(){
	QVariant v;
	if(!itemList.isEmpty()){
		v= (itemList.last()).toMap()["credits"];
	}

	//qDebug()<<"credits from json: "<<v.value<int>();
	return v.value<int>();
}

double RecordModel::cGPA(){
	double v=0;
	if(!itemList.isEmpty()){
		v= (itemList.last()).toMap()["gpa"].value<double>();
	}
	//keep 2 digits after decimal point
	v=floor(v*100+0.5)/100;
	//qDebug()<<"gpa from json: "<<v;
	return v;
}

bool RecordModel::saveNewRecord(QString time,double GPA,int credits){
	_saveState="Start saving...";
	QVariantMap newItem;
	newItem["recordTime"]=QVariant(time);
	newItem["credits"]=QVariant(credits);
	newItem["gpa"]=QVariant(GPA);
	return saveToFile(QVariant(newItem));
}

bool RecordModel::saveToFile(QVariant newItem){
	if(newItem!=0){
		_saveState="Created new entry...";
		itemList.append(newItem);
	}
	QVariantMap newRecord;
	newRecord["label"]= "CGPA";
	newRecord["data"]=itemList;
	bb::data::JsonDataAccess jda;
	jda.save(newRecord,filePath);
	if (jda.hasError()) {
		_saveState="Failed to write in to file...:(";
		bb::data::DataAccessError error = jda.error();
		qDebug() << filePath << "JSON loading error: " << error.errorType() << ": " << error.errorMessage();
		QDir abs=QDir(filePath);
		_saveState=abs.absolutePath();
		reload();
		return false;
	}
	else{
		_saveState=filePath;
		reload();
		if(itemList.size()>0){
			QVariantMap v=itemList[0].toMap();
			//qDebug()<<v["recordTime"]<<v["credits"]<<v["gpa"];
		}
		//_saveState="Finish saving.";
		return true;
	}
}

bool RecordModel::deleteSelectedItems(const QVariantList selectionList){
	if (selectionList.at(0).canConvert<QVariantList>()) {
		for (int i = selectionList.count() - 1; i >= 0; i--) {

			// Get the item at the index path of position i in the selection list.
			QVariantList indexPath = selectionList.at(i).toList();
			deleteItemAtIndex(indexPath);
		}
	} else {
		deleteItemAtIndex(selectionList);
	}

	return saveToFile();
}

void RecordModel::deleteItemAtIndex(QVariantList indexPath){
	QVariant modelItem = data(indexPath);

	// Two indices are needed: the index of the item in the data list and
	// the index of the item in the current model.
	int itemDataIndex = itemList.indexOf(modelItem);
	//int itemIndex = indexPath.last().toInt();

	// Remove the item from the data list and from the current data model items.
	itemList.removeAt(itemDataIndex);
	//removeAt(itemIndex);
}


//void RecordModel::openJsonFile(){
//    bb::system::InvokeManager invokeManager;
//    bb::system::InvokeRequest request;
////    // Who do we want to send the invoke request to?
////    request.setTarget("sys.pim.uib.email.hybridcomposer");
////    // What do we want the target application to do with it?
////    request.setAction("bb.action.SHARE");
////    // What are we sending?
////    request.setMimeType("text/plain");
////    // Where is the data?
////    request.setUri(QUrl("app/native/assets/json/GPA.json"));
////    bb::system::InvokeTargetReply *reply = invokeManager.invoke(request);
//
//
//    	request.setAction("bb.action.COMPOSE");
//    	request.setMimeType("message/rfc822");
//    	QVariantMap data;
//    	data["to"] = (QVariantList() << "zhrud21@gmail.com");
//    	data["subject"] = "This is a subject";
//
//    	data["body"] = "Hello there, things are great!";
//    	QString logpath = QDir::current().absoluteFilePath("app/native/assets/json/GPA.json");
//    	QString logpathEncoded = QString(QUrl(logpath).toEncoded());
//    	qDebug() << "## LOG PATH: " + logpathEncoded;
//    	data["attachment"] = (QVariantList() << logpathEncoded);
//    	QVariantMap moreData;
//    	moreData["data"] = data;
//    	bool ok;
//    	request.setData(bb::PpsObject::encode(moreData, &ok));
//
//    	invokeManager.invoke(request);
//
//}

void RecordModel::setFilePath(const QString& file_name){
	filePath=file_name;
}

void RecordModel::updateSaveState(QObject* ins){
	Label *ptr=qobject_cast<Label*>(ins);
	if(ptr){
		ptr->setText(_saveState);
	}
}

void RecordModel::updateLoadState(QObject* ins){
	Label *ptr=qobject_cast<Label*>(ins);
	if(ptr){
		ptr->setText(_loadState);
	}
}

void RecordModel::Debugger(QVariant a,QVariant b){
	qDebug()<<a<<b;
}

void RecordModel::setSaveState(const QString &t){
	_saveState=t;
}

QString RecordModel::saveState(){
	return _saveState;
}

void RecordModel::setLoadState(const QString &t){
	_loadState=t;
}

QString RecordModel::loadState(){
	return _loadState;
}
