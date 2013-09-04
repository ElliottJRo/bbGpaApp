// List with a context menu project template
import bb.cascades 1.0
import com.bbGpaApp.listModel 1.0

NavigationPane {
    id: courseListNav
    
    property alias navigator:courseListNav
Page {
    id: courseListPage
    titleBar: TitleBar {
        title: "Courses"
    }

    Container {
        CourseList {
            id: courseListIns
            
        }
    }
    
    //*********************      SIGNAL HANDLERS        *************************
    
    //Fix the problem that the last item of list can not be seen
    actionBarVisibility: ChromeVisibility.Visible
    actions: [
        ActionItem {
            // An ActionItem for adding more items to the list
            title: qsTr("Add Class") + Retranslate.onLanguageChanged
            imageSource: "asset:///images/ic_add.png"
            onTriggered: {
                addNew.open();
                addNew.title = "Add Class";
                //flush old data
                addNew.semester = "1";
                addNew.courseText = "";
                addNew.profText = "";
                addNew.mark = 0;
                addNew.credits = 0;
            }
        }
    ]
    attachedObjects: [
        EditSheet {
            // A sheet is used to add new items to the list, which is the same sheet used to edit items
            id: addNew
            onSaveCourseItem: {
                listModel.saveNewItem(courseText,mark.toFixed(0),credits,0,semester);
                courseListIns.scrollToPosition(ScrollPosition.End, ScrollAnimation.Default);
                courseListIns.scrollToPosition(ScrollPosition.Beginning, ScrollAnimation.Default);
            }
        },
        ComponentDefinition {
            // A Component definition of the Page used to display more details on the Course item.
            id: coursePage
            source: "CoursePage.qml"
        }
    ]

} // end of courseListPage

} //end of navipane