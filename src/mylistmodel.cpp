// List with context menu project template
#include "mylistmodel.hpp"

#include <bb/data/JsonDataAccess>

using namespace bb::cascades;

MyListModel::MyListModel(QObject* parent)
: bb::cascades::QVariantListDataModel()
{
	filePath="app/native/assets/mydata.json";
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
    QVariantList lst = jda.load(file_name).value<QVariantList>();
    if (jda.hasError()) {
        bb::data::DataAccessError error = jda.error();
        qDebug() << file_name << "JSON loading error: " << error.errorType() << ": " << error.errorMessage();
    }
    else {
        qDebug() << file_name << "JSON data loaded OK!";
        append(lst);
    }
}

void MyListModel::load()
{

    bb::data::JsonDataAccess jda;
    QVariantList lst = jda.load(filePath).value<QVariantList>();
    if (jda.hasError()) {
        bb::data::DataAccessError error = jda.error();
        qDebug() << filePath << "JSON loading error: " << error.errorType() << ": " << error.errorMessage();
    }
    else {
        qDebug() << filePath << "JSON data loaded OK!";
        append(lst);
    }
}

void MyListModel::save(QString newData)
{
    bb::data::JsonDataAccess jda;
    //read everything from .json file into a list
    QVariantList lst = jda.load(filePath).value<QVariantList>();

    //Construct newEntry
    QVariantMap itemMap;
        itemMap["text"] = QVariant(newData);
        itemMap["description"] = QVariant("");
        itemMap["status"] = QVariant("");
        itemMap["image"] = QVariant("asset:///images/picture1.png");
    QVariant newEntry=(QVariant)itemMap;

    //insert the new entry into list
    lst.insert(0,newEntry);

    //write back to .json file
    jda.save(lst,filePath);
    if (jda.hasError()) {
        bb::data::DataAccessError error = jda.error();
        qDebug() << filePath << "JSON saving error: " << error.errorType() << ": " << error.errorMessage();
    }
    else {
    	//if saving is finished, update list
        qDebug() << filePath << "JSON data saved OK!";
        append(newEntry);
    }
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

