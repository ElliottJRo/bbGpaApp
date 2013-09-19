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

#ifndef COURSESETTINGS_H_
#define COURSESETTINGS_H_

#include <QtCore/QObject>
#include <QSettings>

/**
 * CourseSettings Description:
 *
 * The Course list application settings object, used to store state parameters
 * between application sessions.
 */
class CourseSettings: public QObject
{
Q_OBJECT

/**
 * The property that decides if an action in the course list should be posted to the
 * Course Data Improvement Graph: Initially True
 */
Q_PROPERTY(bool isGraphEnabled READ isGraphEnabled WRITE setIsGraphEnabled NOTIFY isGraphEnabledChanged)

public:
    CourseSettings(QObject *parent = 0);
    ~CourseSettings();

    /**
     * Sets the property that decides if displaying the graph or not
     *
     * @param isGraphEnabled If true application will allow use of graph
     */
void setIsGraphEnabled(bool isGraphEnabled);

/**
 * Returns the property deciding if app should display graph or not
 *
 * @return True if displaying should be done.
 */
bool isGraphEnabled();


signals:

    /**
     *
     * @param isGraphEnabled
     */
    void isGraphEnabledChanged(bool isGraphEnabled);

private:
    // The Qt application settings object used for storing app data.
    QSettings mSettings;

    // Property variables
    bool mIsGraphEnabled;
};

#endif /* COURSESETTINGS_H_ */
