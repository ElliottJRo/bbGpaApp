/* Copyright (c) 2012 Research In Motion Limited.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
#include "coursemodel.h"

#include <bb/data/JsonDataAccess>
#include <bb/cascades/InvokeQuery>

using namespace bb::cascades;

CourseModel::CourseModel(QObject *parent): mCourseIsFull(false), mInvocation(0)
{
    setParent(parent);
}

CourseModel::~CourseModel()
{
}

bool CourseModel::saveData()
{
    JsonDataAccess jda;
    jda.save(mCourseData, mJsonDataPath);

    if (jda.hasError()) {
        bb::data::DataAccessError error = jda.error();
        qDebug() << "JSON loading error: " << error.errorType() << ": " << error.errorMessage();
        return false;
    }

    return true;
}

bool CourseModel::jsonToDataFolder()
{
    // Since we need read-write access to the database, the JSON file has
    // to be moved to a folder where we have that access (application's data folder).
    // First, we check if the file already exists (previously copied)
    QStringList pathSplit = mJsonAssetsPath.split("/");
    QString fileName = pathSplit.last();
    QString dataFolder = QDir::homePath();

    // The path to the file in the data folder
    mJsonDataPath = dataFolder + "/" + fileName;
    QFile newFile(mJsonDataPath);

    if (!newFile.exists()) {
        // If the file is not already in the data folder, we copy it from the
        // assets folder (read only) to the data folder (read and write).
        // Note that on a debug build you will be able to write to a database
        // in the assets folder but that is not possible on a signed application.
        QString appFolder(QDir::homePath());
        appFolder.chop(4);
        QString originalFileName = appFolder + mJsonAssetsPath;
        QFile originalFile(originalFileName);

        if (originalFile.exists()) {
            return originalFile.copy(mJsonDataPath);
        } else {
            qDebug() << "Failed to copy file data base file does not exists.";
            return false;
        }
    }

    return true;
}

void CourseModel::setJsonAssetPath(const QString jsonAssetPath)
{
    if (mJsonAssetsPath.compare(jsonAssetPath) != 0) {
        JsonDataAccess jda;

        // Set and emit the JSON asset path.
        mJsonAssetsPath = jsonAssetPath;
        emit jsonAssetPathChanged(jsonAssetPath);

        if (jsonToDataFolder()) {

            // If the file was either already in the data folder or it was just copied there,
            // it is loaded into the mCourseData QVaraiantlist.
            mCourseData = jda.load(mJsonDataPath).value<QVariantList>();

            if (jda.hasError()) {
                bb::data::DataAccessError error = jda.error();
                qDebug() << "JSON loading error: " << error.errorType() << ": "
                        << error.errorMessage();
                return;
            }

            // After loading the data, check if the course list exceeds 100 items.
            checkCourseIsFull();
        }
    }
}

void CourseModel::setFilter(const QString filter)
{
    if (mFilter.compare(filter) != 0) {
        QVariantList filteredCourseData;

        // Remove all the old data.
        clear();

        // Populate a list with the items that has the corresponding status.
        foreach(QVariant v, mCourseData){
        if(v.toMap().value("status") == filter) {
            filteredCourseData << v;
            append(v.toMap());
        }
    }

    // Update the filter property and emit the signal.
        mFilter = filter;
        emit filterChanged(filter);
    }
}

QString CourseModel::filter()
{
    return mFilter;
}

QString CourseModel::jsonAssetPath()
{
    return mJsonAssetsPath;
}

void CourseModel::updateItemStatusAtIndex(QVariantList indexPath, const QString newStatus)
{
    QVariant modelItem = data(indexPath);

    // Two indices are needed: the index of the item in the data list and
    // the index of the item in the current model.
    int itemDataIndex = mCourseData.indexOf(modelItem);
    int itemIndex = indexPath.last().toInt();

    // Update the item in the list of data.
    QVariantMap itemMap = mCourseData.at(itemDataIndex).toMap();
    itemMap["status"] = newStatus;
    mCourseData.replace(itemDataIndex, itemMap);

    // Since the item status was changed, it is removed from the model and
    // consequently it is removed from the current list shown by the app.
    removeAt(itemIndex);
}

void CourseModel::setStatus(const QVariantList selectionList, const QString newStatus)
{
    // If the selectionList parameter is a list of index paths update all the items
    if (selectionList.at(0).canConvert<QVariantList>()) {
        for (int i = selectionList.count() - 1; i >= 0; i--) {
            // Get the item at the index path of position i in the selection list
            QVariantList indexPath = selectionList.at(i).toList();
            updateItemStatusAtIndex(indexPath, newStatus);
        }
    } else {
        updateItemStatusAtIndex(selectionList, newStatus);
    }
    saveData();
}

void CourseModel::deleteItemAtIndex(QVariantList indexPath)
{
    QVariant modelItem = data(indexPath);

    // Two indices are needed: the index of the item in the data list and
    // the index of the item in the current model.
    int itemDataIndex = mCourseData.indexOf(modelItem);
    int itemIndex = indexPath.last().toInt();

    // Remove the item from the data list and from the current data model items.
    mCourseData.removeAt(itemDataIndex);
    removeAt(itemIndex);
}

void CourseModel::deleteCourseItems(const QVariantList selectionList)
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

    saveData();
    checkCourseIsFull();
}

void CourseModel::addCourseItem(const QString itemTitle)
{
    QVariantMap itemMap;
    itemMap["title"] = QVariant(itemTitle);
    itemMap["status"] = QVariant("todo");

    if (indexOf(itemMap) == -1) {
        if (mFilter.compare("todo") == 0) {
            // New items are added to the todo list. If the filter is set to todo,
            // the current list is shown and the new item is added at the top of the list model.
            insert(0, itemMap);
        }

        // Add the new item to the data list.
        mCourseData.insert(0, itemMap);
        saveData();
    }

    // A new item has been added check to see if the max limit has been reached.
    checkCourseIsFull();
}

void CourseModel::editCourseItem(const QVariant item, const QString newItemTitle)
{
    // Get the indices of the item in the model and in the data list.
    QVariantMap itemMap = item.toMap();
    int itemDataIndex = mCourseData.indexOf(itemMap);
    int itemIndex = indexOf(itemMap);

    // Update the title.
    itemMap["title"] = newItemTitle;

    // And replace the item in both the model and the data list.
    mCourseData.replace(itemDataIndex, itemMap);
    replace(itemIndex, itemMap);

    saveData();
}

bool CourseModel::courseIsFull()
{
    return mCourseIsFull;
}

void CourseModel::checkCourseIsFull()
{
    // Check if the course is full or not. If the status changes, update the property.
    if (mCourseData.count() < mMaxItems) {

        // Only emit the signal if the property actually changed.
        if (mCourseIsFull) {
            mCourseIsFull = false;
            emit courseIsFullChanged(mCourseIsFull);
        }

    } else if (!mCourseIsFull) {
        if (!mCourseIsFull) {
            mCourseIsFull = true;
            emit courseIsFullChanged(mCourseIsFull);
        }
    }
}

void CourseModel::shareCourseItem(const QString itemTitle)
{

    //Create a file to share over BBM.
    QFile courseFile("data/courseItemToShare.buk");
    if (courseFile.exists()) {
        courseFile.remove();
    }

    courseFile.open(QIODevice::WriteOnly | QIODevice::Text);
    QTextStream out(&courseFile);
    out << itemTitle;
    courseFile.close();

    //Share the file over BBM using the Invocation Framework.
    QString path = QDir::current().absoluteFilePath("data/courseItemToShare.buk");

    mInvocation = Invocation::create(
            InvokeQuery::create().parent(this).uri(QUrl::fromLocalFile(path)).invokeTargetId(
                    "sys.bbm.sharehandler"));

    QObject::connect(mInvocation, SIGNAL(armed()), SLOT(onArmed()));

    QObject::connect(mInvocation, SIGNAL(finished()), mInvocation, SLOT(deleteLater()));

}

void CourseModel::onArmed()
{
    // Once the system has armed the invocation trigger it to launch BBM sharing.
    mInvocation->trigger("bb.action.SHARE");
}

void CourseModel::deleteLater()
{
    delete (mInvocation);
}

