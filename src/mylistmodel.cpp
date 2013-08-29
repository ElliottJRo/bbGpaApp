// List with context menu project template
#include "mylistmodel.hpp"

#include <bb/data/JsonDataAccess>
#include<math.h>

using namespace bb::cascades;

MyListModel::MyListModel(QObject* parent)
: bb::cascades::QVariantListDataModel()
{
	filePath="app/native/assets/json/mydata.json";
    qDebug() << "Creating MyListModel object:" << this;
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

void MyListModel::saveNewItem(QString newData,float mark,float credits,int index)
{



    //Construct newEntry
    QVariantMap itemMap;
        itemMap["text"] = QVariant(newData);
        itemMap["description"] = QVariant(QString::number(mark,'g',2)+"    "+markToGrade(mark));
        itemMap["status"] = QVariant(floorf(credits));
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


QVariant MyListModel::editSelectedItem(const QVariant olditem,QString newData,float mark,float credits){

    QVariantMap itemMap = olditem.toMap();
    int itemDataIndex = itemList.indexOf(itemMap);
    int itemIndex = indexOf(itemMap);

    // Update the content.
    			itemMap["text"] = QVariant(newData);
    			itemMap["description"] = QVariant(QString::number(mark,'g',2)+"    "+markToGrade(mark));
    	        itemMap["status"] = QVariant(floorf(credits));
    	        itemMap["image"] = QVariant("asset:///images/picture1.png");

    // And replace the item in both the model and the data list.
    itemList.replace(itemDataIndex, itemMap);
    replace(itemIndex, itemMap);

    saveToFile();
    return itemMap;
}

QVariant MyListModel::calculateGpa433(){
	QVariant result;
	QVariantList gradeList,creditsList;
	for(int i=0;i<itemList.size();i++){
		gradeList.append((itemList[i].toMap())["description"]);
		creditsList.append((itemList[i].toMap())["status"]);
	}
	result=computeCGPA(0,0,gradeList,creditsList,itemList.size());
	return result;
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

