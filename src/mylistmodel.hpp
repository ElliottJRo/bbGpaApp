// List with context menu project template
/*
 * ListModel.h
 */

#ifndef MyListModel_HPP_
#define MyListModel_HPP_

#include <QObject>
#include <QString>
#include <QVariant>
#include <QMetaType>
#include <bb/cascades/QListDataModel>

/*!
 * @brief Mutable list model implementation
 */
class MyListModel : public bb::cascades::QVariantListDataModel
{
    Q_OBJECT
public:
    /*!
     * @brief Convenience method for loading data from JSON file.
     *
     * @param file_name  file to load
     */

    Q_INVOKABLE void saveNewItem(QString newData,float mark,float credits);

    Q_INVOKABLE void load(const QString& file_name);

    Q_INVOKABLE void load();
    /*!
     * @brief Convenience method to read the model data.
     *
     * @param ix  index of the list item
     * @param fld_name  name of data field
     */
    Q_INVOKABLE QVariant value(int ix, const QString &fld_name);
    /*!
     * @brief Convenience method to set the model data.
     *
     * @param ix  index of the list item
     * @param fld_name  name of data field
     * @param val  new value
     */
    Q_INVOKABLE void setValue(int ix, const QString &fld_name, const QVariant &val);

    Q_INVOKABLE	QString markToGrade(float mark);

    /*!
     * @brief delete function for course item
     *
     * @param selectionList  list of selected items
     */
    Q_INVOKABLE void deleteSelectedItems(const QVariantList selectionList);

    void deleteItemAtIndex(QVariantList indexPath);
    bool saveToFile();

public:
    MyListModel(QObject* parent = 0);
    QString filePath;
    QVariantList itemList;
    virtual ~MyListModel();

};


#endif /* MyListModel_HPP_ */
