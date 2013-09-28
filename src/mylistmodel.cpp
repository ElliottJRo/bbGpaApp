// List with context menu project template
#include "mylistmodel.hpp"
#include <bb/cascades/WebView>
#include <bb/data/JsonDataAccess>
#include <bb/cascades/QmlDocument>
#include<math.h>

using namespace bb::cascades;

MyListModel::MyListModel(QObject* parent)
: bb::cascades::QVariantListDataModel()
{
	filePath="data/html/mydata.json";
    qDebug() << "Creating MyListModel object:" << this;
    calculateGpa433();
    isCourseListEmpty();
    setParent(parent);
}

MyListModel::~MyListModel()
{
    qDebug() << "Destroying MyListModel object:" << this;
}

void MyListModel::load(const QString& file_name)
{
    bb::data::JsonDataAccess jda;
    filePath=file_name;
    itemList = jda.load(file_name).value<QVariantList>();
    if (jda.hasError()) {
        bb::data::DataAccessError error = jda.error();
        qDebug() << file_name << "JSON loading error: " << error.errorType() << ": " << error.errorMessage();
    }
    else {
        qDebug() << file_name << "JSON data loaded OK!";
        append(itemList);
    }
}

void MyListModel::load()
{

    bb::data::JsonDataAccess jda;
    itemList = jda.load(filePath).value<QVariantList>();
    if (jda.hasError()) {
        bb::data::DataAccessError error = jda.error();
        qDebug() << filePath << "JSON loading error: " << error.errorType() << ": " << error.errorMessage();
    }
    else {
        qDebug() << filePath << "JSON data loaded OK!";

        append(itemList);
    }
}

void MyListModel::saveNewItem(QString newData,float mark,float credits,int index, QString sem)
{



    //Construct newEntry
    QVariantMap itemMap;
        itemMap["text"] = QVariant(newData);
        itemMap["mark"] = QVariant(mark);
        itemMap["grade"]= QVariant(markToGrade(mark));
        itemMap["credits"] = QVariant(floorf(credits));
        itemMap["semester"] = QVariant(sem);
        itemMap["image"] = QVariant("asset:///images/picture1.png");
    QVariant newEntry=(QVariant)itemMap;

    //insert the new entry into list
    itemList.insert(index,newEntry);
    insert(index,newEntry);
    saveToFile();

}

QVariant MyListModel::value(int ix, const QString &fld_name)
{
    QVariant ret;
    // model data are organized in a list of dictionaries
    if(ix >= 0 && ix < size()) {
        // get dictionary on index
        QVariantMap curr_val = QVariantListDataModel::value(ix).toMap();
        ret = curr_val.value(fld_name);
    }
    return ret;
}

void MyListModel::setValue(int ix, const QString& fld_name, const QVariant& val)
{
    // model data are organized in a list of dictionaries
    if(ix >= 0 && ix < size()) {
        // get dictionary on index
        QVariantMap curr_val = QVariantListDataModel::value(ix).value<QVariantMap>();
        // set dictionary value for key fld_name
        curr_val[fld_name] = val;
        // replace updated dictionary in array
        replace(ix, curr_val);
    }
}

void MyListModel::deleteSelectedItems(const QVariantList selectionList)
{
    // If the selectionList parameter is a list of index paths update all the items
    if (selectionList.at(0).canConvert<QVariantList>()) {
        for (int i = selectionList.count() - 1; i >= 0; i--) {

            // Get the item at the index path of position i in the selection list.
            QVariantList indexPath = selectionList.at(i).toList();
            deleteItemAtIndex(indexPath);
        }
    } else {
        deleteItemAtIndex(selectionList);
    }

    if(!saveToFile()){
    	qDebug() << "Saving loading error";
    }
}

void MyListModel::deleteItemAtIndex(QVariantList indexPath)
{
    QVariant modelItem = data(indexPath);

    // Two indices are needed: the index of the item in the data list and
    // the index of the item in the current model.
    int itemDataIndex = itemList.indexOf(modelItem);
    int itemIndex = indexPath.last().toInt();

    // Remove the item from the data list and from the current data model items.
    itemList.removeAt(itemDataIndex);
    removeAt(itemIndex);
}

bool MyListModel::saveToFile()
{
    bb::data::JsonDataAccess jda;
    jda.save(itemList, filePath);

    if (jda.hasError()) {
        bb::data::DataAccessError error = jda.error();
        qDebug() << "JSON loading error: " << error.errorType() << ": " << error.errorMessage();
        return false;
    }


    return true;
}


QVariant MyListModel::editSelectedItem(const QVariant olditem,QString newData,float mark,float credits,QString sem){

    QVariantMap itemMap = olditem.toMap();
    int itemDataIndex = itemList.indexOf(itemMap);
    int itemIndex = indexOf(itemMap);

    // Update the content.
    itemMap["text"] = QVariant(newData);
	itemMap["mark"] = QVariant(mark);
	itemMap["grade"]= QVariant(markToGrade(mark));
	itemMap["credits"] = QVariant(floorf(credits));
	itemMap["semester"] = QVariant(sem);
	itemMap["image"] = QVariant("asset:///images/picture1.png");

    // And replace the item in both the model and the data list.
    itemList.replace(itemDataIndex, itemMap);
    replace(itemIndex, itemMap);

    saveToFile();
    return itemMap;
}

QVariant MyListModel::calculateGpa433()
{
	qDebug()<<itemList.size();
	if(itemList.size()!=0){
		QVariantList gradeList,creditsList;
		for(int i=0;i<itemList.size();i++){
				gradeList.append((itemList[i].toMap())["grade"]);
				creditsList.append((itemList[i].toMap())["credits"]);
			}
			cgpa=computeCGPA(0,0,gradeList,creditsList,itemList.size());
			cgpa=floor(cgpa*100+0.5)/100;
			qDebug()<<"gpa from list: "<<cgpa;
			return cgpa;
	}else{
		cgpa=-1;
		return "No Course found!";
	}
}


QString MyListModel::markToGrade(float mark){
	if(mark<50){
		return "F";
	}else if(mark<55){
		return	"D";
	}else if(mark<60){
		return	"C-";
	}else if(mark<65){
		return	"C";
	}else if(mark<70){
		return	"C+";
	}else if(mark<75){
		return	"B-";
	}else if(mark<80){
		return	"B";
	}else if(mark<85){
		return	"B+";
	}else if(mark<90){
		return	"A-";
	}else if(mark<95){
		return	"A";
	}else if(mark<=100){
		return	"A+";
	}else{
		return "N/A";
	}
}

int MyListModel::totalUnits(){
	int totalUnits=0,temp;
    foreach(QVariant v,itemList){
    	temp=v.toMap()["credits"].value<int>();
    	totalUnits+=temp;
    }
    return totalUnits;
}

double MyListModel::cGPA(){
	return cgpa;
}

void MyListModel::resetParent(QObject* page){
	page->setParent(0);
//	page->removeAllActions();
}

bool MyListModel::isCourseListEmpty() {
  if(itemList.size()!=0) {
    qDebug() << "isCourseListEmpty: list is not empty";
    return false;
  } else {
    qDebug() << "isCourseListEmpty: list is empty";
    return true;
  }
}

void MyListModel::resetUrl(QObject* ins,QString url){

	WebView* webview=qobject_cast<WebView*>(ins);
	if(webview){
		qDebug((webview->url()).toString().toUtf8());
		webview->setUrl(QUrl(url));
		qDebug(webview->url().toString().toUtf8());
	}
}
