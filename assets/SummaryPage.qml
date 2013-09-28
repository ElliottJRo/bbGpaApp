
// List with a context menu project template
import bb.cascades 1.0
import com.bbGpaApp.listModel 1.0
import com.bbGpaApp.recordModel 1.0
import bb.cascades.advertisement 1.0
//import com.bbGpaApp.coursedata 1.0

NavigationPane {
    id: summaryNavi
    
    property alias navigator:summaryNavi
    property variant listModel
    Page {
        id: summaryPage
        property variant gpa;
        property variant newGraphPage;
        
        titleBar: TitleBar {
            id: titleBar
            visibility: ChromeVisibility.Visible
            title: qsTr("Summary") + Retranslate.onLanguageChanged
        }
        Container {
            id: summaryContainer
            topPadding: 20
            layout: StackLayout {

            }
            Button {
                text: qsTr("Calculate") + Retranslate.onLanguageChanged + " CGPA"
                onClicked: {
                    //                    gpaResult.text = listModel.calculateGpa433().toFixed(2);
                    summaryPage.gpa= listModel.calculateGpa433();
                    //                    var  a=listModel.totalUnits()!=gpaRecord.totalUnits()
                    //                    var  b=listModel.cGPA()!=gpaRecord.cGPA()
                    //                    gpaRecord.Debugger(a,b);
                    if((listModel.cGPA()>0)&&(listModel.totalUnits()!=gpaRecord.totalUnits() || listModel.cGPA()!=gpaRecord.cGPA())){
                        gpaRecord.saveNewRecord(Qt.formatDate(new Date(),"yyyy/MM/dd"),listModel.cGPA(),listModel.totalUnits());
                    }
                    else{
                        gpaRecord.saveState="No new Record." 
                    }
                    gpaRecord.updateSaveState(saveStatus)
                    //gpaRecord.updateLoadState(loadStatus)
                }
                horizontalAlignment: HorizontalAlignment.Center
            }
            Label {
                text: "  " + qsTr("Your CGPA is") + Retranslate.onLanguageChanged + ": " +summaryPage.gpa
                verticalAlignment: VerticalAlignment.Top
                horizontalAlignment: HorizontalAlignment.Left
            }
            /*Label {
                id: gpaResult
                text: summaryPage.gpa;
                verticalAlignment: VerticalAlignment.Top
                horizontalAlignment: HorizontalAlignment.Center
                textStyle.fontSizeValue: 10.0
            
            }*/
            ScrollView {
                scrollViewProperties {
                    scrollMode: ScrollMode.Both
                    pinchToZoomEnabled: true
                }
                Container {
                    Label {
                        id: saveStatus;
                    }
                    Label {
                        id: loadStatus;
                    }
                }
            }
            
            Label {
                text: qsTr("History") + Retranslate.onLanguageChanged
                textStyle.fontSize: FontSize.XXLarge
                horizontalAlignment: HorizontalAlignment.Center
            }
//            Label {
//                text: Qt.formatDate(new Date(),"yyyy/MM/dd")
//            }
            Label {
                text:qsTr("  Entry \tGPA\t\tCredits\t\t\tDate")
            }
            Divider {
                
            }
            RecordList {
                
           }
           Banner {
               id:ad
               zoneId: 217188	
               refreshRate: 60
               preferredWidth: 300	
               preferredHeight: 50
               transitionsEnabled: true
               //                placeHolderURL: "asset:///placeholder_728x90.png"
               backgroundColor: Color.Transparent
               borderColor: Color.Blue
               borderWidth: 2
               horizontalAlignment: HorizontalAlignment.Center
           }
        }//end of the container
        
        actions: [
            ActionItem {
                id: graphActionItem
                title: qsTr("Graph") + Retranslate.onLanguageChanged
                onTriggered:{
 //                   console.log("SummaryPage: graphActionItem called, graphEnabled: ", Qt.settings.isGraphEnabled)
                    console.log("SummaryPage: graphActionItem called, buttonEnabled: ", graphActionItem.enabled)
                    summaryPage.newGraphPage.webview.reload()
                    summaryNavi.push(summaryPage.newGraphPage)
                }
            }
        ]
        onCreationCompleted: {
            summaryPage.newGraphPage = graphPage.createObject();
//            Qt.graphActionItem = graphActionItem;
//            if(!settings.isGraphEnabled) {
//                console.log("SummaryPage - onCreationComplete: graph is not enabled: ", settings.isGraphEnabled)
//                graphActionItem.setEnabled(false);
//            }
        }
        attachedObjects: [
        	RecordModel {
        		id: gpaRecord
        	},
            ComponentDefinition {
                // A Component definition of the Page used to display more details on the Course item.
                id: graphPage
                source: "GraphPage.qml"
            }
        ]
    }

} //end of navipane
