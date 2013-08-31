/*
 * RecordModel.cpp
 *
 *  Created on: Aug 29, 2013
 *      Author: Ray
 */

#include "recordmodel.hpp"
#include <bb/data/JsonDataAccess>
#include <bb/system/InvokeManager>
#include <bb/PpsObject>




RecordModel::RecordModel(QObject* parent): bb::cascades::QVariantListDataModel()
{
	filePath="app/native/assets/json/GPA.json";
	load();

	setParent(parent);

}

bool RecordModel::load(){
	bb::data::JsonDataAccess jda;
	QVariantMap record = jda.load(filePath).value<QVariantMap>();
	QVariantList templist;
	    if (jda.hasError()) {
	        bb::data::DataAccessError error = jda.error();
	        qDebug() << filePath << "JSON loading error: " << error.errorType() << ": " << error.errorMessage();
	        return false;
	    }
	    else {
	        qDebug() << filePath << "JSON data loaded OK!";
	        itemList=record["data"].value<QVariantList>();
	        append(itemList);
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
	QVariant v= itemList[0].toMap()["credits"];
	qDebug()<<"credits from json: "<<v.value<int>();
	return v.value<int>();
}

double RecordModel::cGPA(){
	double v= itemList[0].toMap()["gpa"].value<double>();
	//keep 2 digits after decimal point
	v=floor(v*100+0.5)/100;
	qDebug()<<"gpa from json: "<<v;
	return v;
}

bool RecordModel::saveNewRecord(QVariant time,QVariant GPA,QVariant credits){
	QVariantMap newItem;
	newItem["recordTime"]=time;
	newItem["credits"]=credits;
	newItem["gpa"]=GPA;
	return saveToFile(QVariant(newItem));
}

bool RecordModel::saveToFile(QVariant newItem){
	if(newItem!=0){
		itemList.insert(0,newItem);
	}
	QVariantMap newRecord;
	newRecord["label"]= "CGPA";
	newRecord["data"]=itemList;
	bb::data::JsonDataAccess jda;
	jda.save(newRecord,filePath);
	 if (jda.hasError()) {
		        bb::data::DataAccessError error = jda.error();
		        qDebug() << filePath << "JSON loading error: " << error.errorType() << ": " << error.errorMessage();
		        return false;
		    }
	 else{
		 reload();
		 QVariantMap v=itemList[0].toMap();
		 qDebug()<<v["recordTime"]<<v["credits"]<<v["gpa"];
		 return true;
	 }
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
void RecordModel::Debugger(QVariant a,QVariant b){
	qDebug()<<a<<b;
}
