// Default empty project template
import bb.cascades 1.0
import com.bbGpaApp.listModel 1.0

// creates one page with a label
TabbedPane {
    id: tabbedPane
    showTabsOnActionBar: true
    activeTab: courseListTab
    sidebarState: SidebarState.VisibleCompact
    
    property variant infoPageIns;
//    property variant infoPageIns4SummaryPage;
//    property variant settingsPageIns4CourseListPage;
    property variant settingsPageIns;
    
    Tab {
        id: courseListTab
        title: "Classes"
        imageSource: "asset:///images/coursesPageIcon.png"
        CourseListPage {
            id: courseListPageIns
            onPopTransitionEnded: {
                listModel.resetParent(infoPageIns)
                listModel.resetParent(settingsPageIns)
//                infoPageIns.removeAllActions ();
//                settingsPageIns.removeAllActions();
            }
        }
    } // end of first Tab
    
    Tab {
        id: summaryTab
        title: "Summary"
        imageSource: "asset:///images/summaryPageIcon.png"
        SummaryPage {
            id: summaryPageIns
            onPopTransitionEnded: {
                listModel.resetParent(infoPageIns)
                listModel.resetParent(settingsPageIns)
//                infoPageIns.removeAllActions();
//                settingsPageIns.removeAllActions ();
            }
        }
    
    } // end of second Tab
    Menu.definition: MenuDefinition {
        settingsAction: SettingsActionItem {
            //imageSource: "asset:///images/settings.png"
            onTriggered: {
                if(activeTab==courseListTab){
                    courseListPageIns.push(settingsPageIns);
                }else{
                    summaryPageIns.push(settingsPageIns);
                }
            }
        
        }
        actions: [
            ActionItem {
                title: "Info"
                imageSource: "asset:///images/info.png"
                onTriggered: {
                    if (activeTab==courseListTab){
                        courseListPageIns.push(infoPageIns);
                    }else{
                        summaryPageIns.push(infoPageIns);
                    }
                }
            }
        ]
    }
    
    attachedObjects: [
        ComponentDefinition {
            // A Component definition of the Page used to display more details on the Course item.
            id: infoPage
            source: "InfoPage.qml"
        },
        ComponentDefinition {
            // A Component definition of the Page used to display more details on the Course item.
            id: settingsPage
            source: "SettingsPage.qml"
        },
        MyListModel {
            id: listModel
            
            // The path to the JSON file with initial data, this file will be moved to
            // the data folder on the first launch of the application (in order to
            // be able to get write access).
            //jsonAssetPath: "app/native/assets/models/bucket.json"
            
            // The filtering is initially set to "todo" to show items which has not
            // been checked off the list so far.
            //filter: "todo"
        }
    ]
    
    onCreationCompleted: {
        // this slot is called when declarative scene is created
        // write post creation initialization here
        console.log("Page - onCreationCompleted()")
        
        // enable layout to adapt to the device rotation
        // don't forget to enable screen rotation in bar-bescriptor.xml (Application->Orientation->Auto-orient)
        OrientationSupport.supportedDisplayOrientation = SupportedDisplayOrientation.All;
        
        //initialize the instance of info page and settings page
        infoPageIns = infoPage.createObject();
//        infoPageIns4SummaryPage = infoPage.createObject();
//        settingsPageIns4CourseListPage = settingsPage.createObject();
        settingsPageIns = settingsPage.createObject();
    
    }
}// end of TabbedPane