// Default empty project template
import bb.cascades 1.0
import com.bbGpaApp.listModel 1.0


// creates one page with a label
TabbedPane {
    id: tabbedPane
    showTabsOnActionBar: true
    activeTab: courseListTab
    sidebarState: SidebarState.VisibleCompact

    Tab {
        id: courseListTab
        title: "Classes"
        //imageSource: ""
        CourseListPage {
        }
    } // end of first Tab

    Tab {
        id: summaryTab
        title: "Summary"
        //imageSource: ""
        SummaryPage {
        }

    } // end of second Tab
    Menu.definition: MenuDefinition {
        settingsAction: SettingsActionItem {
            //imageSource: "asset:///images/settings.png"
            onTriggered: {
                settings.open();
            }
        }
        actions: [
            ActionItem {
                title: "Info"
                imageSource: "asset:///images/info.png"
                onTriggered: {
                    info.open();
                }
            }
        ]
    }

    attachedObjects: [
        Sheet {
            id: info
            InfoPage {
            }
        },
        Sheet {
            id: settings
            SettingsPage {
            }
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
    }
}// end of TabbedPane
