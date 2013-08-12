// Default empty project template
import bb.cascades 1.0
import com.rim.example.custom 1.0

import com.courselist.coursedata 1.0


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

    } // end of third Tab
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
                //imageSource: "asset:///images/info.png"
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
        }

    //ComponentDefinition {
    //  id: nextpage
    //source: "SettingsPage.qml"
    //}
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
