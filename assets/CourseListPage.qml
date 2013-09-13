// List with a context menu project template
import bb.cascades 1.0
import com.bbGpaApp.listModel 1.0
import bb.cascades.advertisement 1.0


NavigationPane {
    id: courseListNav
    
    property alias navigator:courseListNav
    property variant listModel;
    Page {
        id: courseListPage
        titleBar: TitleBar {
            title: "Courses"
        }
        
        Container {
            id: courseListContainer
            layout: DockLayout {}
            CourseList {
                id: courseListIns
                onCreationCompleted: {
                    // this signal will be called when the qml page is created or loaded
                    if(listModel.isCourseListEmpty()) {
                        courseListIns.visible = false;
                        emptyCourseListContainer.visible = true;
                    } else {
                        courseListIns.visible = true;
                        emptyCourseListContainer.visible = false;
                    }
                }
            
            }
            Container {
                id: emptyCourseListContainer
                verticalAlignment: VerticalAlignment.Center
                horizontalAlignment: HorizontalAlignment.Center
                Label {
                    text: qsTr("Course list is empty\n\t Why not add a course?")
                    multiline: true
                    textStyle.textAlign: TextAlign.Center
                    textStyle.fontSize: FontSize.XLarge
                    textStyle.fontWeight: FontWeight.W100
                }
                ImageButton {
                    horizontalAlignment: HorizontalAlignment.Center
                    defaultImageSource: "asset:///images/ic_add.png"
                    onClicked: {
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
            }
            Banner {
                id:ad
                zoneId: 117145//217188	
                refreshRate: 60
                preferredWidth: 300
                preferredHeight: 50
                transitionsEnabled: true
                //                placeHolderURL: "asset:///placeholder_728x90.png"
                backgroundColor: Color.Transparent
                borderColor: Color.Blue
                borderWidth: 2
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Bottom
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
                    if(!listModel.isCourseListEmpty()) {
                        courseListIns.visible = true;
                        emptyCourseListContainer.visible = false;
                    }
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