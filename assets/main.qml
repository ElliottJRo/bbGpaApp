// Default empty project template
import bb.cascades 1.0
import com.bbGpaApp.listModel 1.0
import bb.cascades.advertisement 1.0

// creates one page with a label
TabbedPane {
    id: tabbedPane
    showTabsOnActionBar: true
    activeTab: courseListTab
    sidebarState: SidebarState.VisibleCompact
    
    property variant infoPageIns;
    property variant settingsPageIns;
    
    Tab {
        id: courseListTab
        title: qsTr("Classes") + Retranslate.onLanguageChanged
        imageSource: "asset:///images/ic_courseTab.png"
        CourseListPage {
            id: courseListPageIns
            listModel: listModel
        }
    } // end of first Tab
    
    Tab {
        id: summaryTab
        title: qsTr("Summary") + Retranslate.onLanguageChanged
        imageSource: "asset:///images/ic_summaryTab.png"
        SummaryPage {
            id: summaryPageIns
            listModel: listModel
        }
    
    } // end of second Tab
    Tab {
        id:graphTab
        title: qsTr("Graph") + Retranslate.onLanguageChanged
        imageSource: "asset:///images/ic_graph.png"
        GraphPage {
            onCreationCompleted: {
                webview.reload()
            }
        }
    }
    Menu.definition: MenuDefinition {
        settingsAction: SettingsActionItem {
            onTriggered: {
                console.log("tab is " + tabbedPane.activeTab);
                settingsPg.open();
            }
        }
        actions: [
            ActionItem {
                title: qsTr("Info") + Retranslate.onLanguageChanged
                imageSource: "asset:///images/ic_info.png"
                onTriggered: {
                    console.log("tab is " + tabbedPane.activeTab);
                    infoPg.open();
                }
            }
        ]
    }
    
    attachedObjects: [
        InfoPage {
            id: infoPg
        },
        SettingsPage {
            id: settingsPg
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