// Default empty project template
import bb.cascades 1.0
import com.bbGpaApp.listModel 1.0
//import com.bbGpaApp.coursedata 1.0
import bb.cascades.advertisement 1.0


// creates one page with a label
TabbedPane {
    id: tabbedPane
    showTabsOnActionBar: true
    activeTab: courseListTab
    sidebarState: SidebarState.VisibleCompact
    
    property variant settings
    
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
            id:gp
        }
        onTriggered: {
            if(!settingsPg.isGraphOn){
                
                gp.webview.url="local:///assets/html/GraphOff.html"
                //listModel.resetUrl(gp.webview,"local:///assets/html/GraphOff.html")
            }else{
                
                gp.webview.url="local:///assets/html/GPAGraph.html"
                //listModel.resetUrl(gp.webview,"local:///assets/html/GPAGraph.html")
            }
            console.log("url="+gp.webview.url)
            //gp.webview.reload();
        }
    }
    Menu.definition: MenuDefinition {
        settingsAction: SettingsActionItem {
            onTriggered: {
                settingsPg.open();
            }
        }
        actions: [
            ActionItem {
                title: qsTr("Info") + Retranslate.onLanguageChanged
                imageSource: "asset:///images/ic_info.png"
                onTriggered: {
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
//            onCheckedChanged: {
//                coursedata.isGraphEnabled = graphChecker.checked;
//                console.log("SettingsPage:  isGraphEnabled =", coursedata.isGraphEnabled)
//            }
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
//        CourseSettings {
//            id: settings
//            onIsGraphEnabledChanged: {
//                console.log("onIsGraphEnabledChanged signal called, Graph enabled is:",settings.isGraphEnabled);
//                if(settings.isGraphEnabled) {
//                    graphTab.enabled = true;
//                    Qt.graphActionItem.enabled = true;
//                } else {
//                    graphTab.enabled = false;
//                    Qt.graphActionItem.enabled = false;
//                }
//            }
//        }
    ]
    
    onCreationCompleted: {
        // this slot is called when declarative scene is created
        // write post creation initialization here
        console.log("MainPage - onCreationCompleted()")
        
        if(!settings.isGraphEnabled) {
           // console.log("MainPage - onCreationComplete: graph is not enabled: ", settings.isGraphEnabled)
            graphTab.setEnabled(false);
        }
        // enable layout to adapt to the device rotation
        // don't forget to enable screen rotation in bar-bescriptor.xml (Application->Orientation->Auto-orient)
        OrientationSupport.supportedDisplayOrientation = SupportedDisplayOrientation.DisplayPortrait;
        
        // sets settings variable to be global (Qt is a global variable and this sets dynamicaly, var settings to be part of Qt)
        //Qt.settings = settings;
    }
}// end of TabbedPane