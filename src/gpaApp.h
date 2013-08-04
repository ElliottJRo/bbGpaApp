/*
 * courseApp.h
 *
 *  Created on: 2013-08-03
 *      Author: Elliott
 */

#ifndef GPAAPP_H_
#define GPAAPP_H_
#include <bb/cascades/Application>
#include <bb/system/InvokeManager>


namespace bb
{
    namespace cascades
    {
        class LocaleHandler;
    }
}

class QTranslator;

/**
 * CourseListApp Description:
 *
 * One hundred things to do before you kick the course. A relatively basic
 * list based application, which illustrates the usage of the multi select
 * handler. Moreover the application loads and saves data from a JSON file.
 * In addition to this the application illustrate how one can connect to the
 * BBM Social platform and update the users status message.
 *
 * You will learn:
 * - How to use the multiSelectHandler in order to select several list entries at once.
 * - How to one adds ActionSets and contextActions to a list items.
 * - How to load and save data from a JSON file.
 * - How to connect to the BBM Social Platform.
 * - How to register an application to listen for invocations.
 *
 */
class CourseListApp: public QObject
{
Q_OBJECT

/**
 * Property used for .buk items received via the invocation framework, see CourseListPage.qml
 * for further details.
 */
Q_PROPERTY(QString courseItemTitle READ courseItemTitle NOTIFY incomingCourseItem)

signals:
    /**
     * When the application receives a .buk file this signal is emitted, its captured
     * in QML and a UI is shown for adding the incoming item to the list.
     *
     */
    void incomingCourseItem();

public slots:
    /**
     * Function used to attach to the InvokeManagers invoked signal,
     * this is where the incoming .buk data is parsed and a new item is
     * added to the model.
     *
     * @param invoke - The incoming InvokeRequest
     */
    void handleInvoke(const bb::system::InvokeRequest& invoke);

public:
    // Constructor that sets up the application.
    CourseListApp();

private:
    /**
     * System Language function, which will be attached to the signal emitted when
     * the system language change (for example if it is changed in the settings menu);
     */
    Q_SLOT void onSystemLanguageChanged();

    // Qt translator object used for loading translations.
    QTranslator* mTranslator;

    // The Locale handler used to query and listens for changes to system locales.
    bb::cascades::LocaleHandler* mLocaleHandler;

    bb::system::InvokeManager *mInvokeManager;

    QString courseItemTitle() const;

    QString mCourseItemTitle;

};


#endif /* GPAAPP_H_ */
