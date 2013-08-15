// List with a context menu project template
import bb.cascades 1.0

import com.rim.example.custom 1.0
Page {
    id: page1
    titleBar: TitleBar {
        title: "Courses"
    }

    Container {
        CourseList {
            id: courseList
            
            /*
            attachedObjects: [
                // The bucket model is a non visible object so it is set up as an attached object.
                // The model itself is a QListDataModel defined in bucketmodel.h and registered
                // as a type in the creation of the application.
                CourseModel {
                    id: courseModel

                    // The path to the JSON file with initial data, this file will be moved to
                    // the data folder on the first launch of the application (in order to
                    // be able to get write access).
                    //jsonAssetPath: "app/native/assets/models/bucket.json"

                    // The filtering is initially set to "todo" to show items which has not
                    // been checked off the list so far.
                    //filter: "todo"
                }
            ]*/
        }
    }
    
    function assetForFlags(flags) {
        var ret = "asset:///images/picture1.png";
        if (flags.hidden) ret = null;
        else if (flags.broken) ret = "asset:///images/picture2.png";
        return ret;
    }
    function statusForFlags(flags) {
        var ret = "";
        if (flags.hidden) ret = qsTr("hidden");
        if (flags.broken) {
            if (ret) ret += ", ";
            ret += qsTr("broken");
        }
        return ret;
    }
    
    
    //*********************      SIGNAL HANDLERS        *************************
    
    actionBarVisibility: ChromeVisibility.Overlay
    actions: [
        ActionItem {
            // An ActionItem for adding more items to the list
            title: qsTr("Add Class") + Retranslate.onLanguageChanged
//            imageSource: "asset:///images/add.png"
            onTriggered: {
                addNew.open();
                addNew.title = "Add Class";
            }
        },
        ActionItem {
            title: "Delete Class"
        },
        ActionItem {
            title: "Sort"
        }
    ]
    attachedObjects: [
        EditSheet {
            // A sheet is used to add new items to the list, which is the same sheet used to edit items
            id: addNew
//            onSaveCourseItem: {
//                courseModel.addCourseItem(text);
//                courseList.scrollToPosition(ScrollPosition.Beginning, ScrollAnimation.Default);
//            }
        },
        ComponentDefinition {
            // A Component definition of the Page used to display more details on the Course item.
            id: coursePage
            source: "CoursePage.qml"
        }
    ]

}