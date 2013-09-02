
// List with a context menu project template
import bb.cascades 1.0
import com.bbGpaApp.listModel 1.0
import com.bbGpaApp.recordModel 1.0

NavigationPane {
    id: summaryNavi
    
    Page {
        id: summaryPage
        property variant gpa;
        property variant newGraphPage;
        
        titleBar: TitleBar {
            id: titleBar
            visibility: ChromeVisibility.Visible
            title: "Summary"
        }
        Container {
            topPadding: 20
            layout: StackLayout {

            }
            Button {
                text: qsTr("Calculate CGPA")
                onClicked: {
                    //                    gpaResult.text = listModel.calculateGpa433().toFixed(2);
                    summaryPage.gpa= listModel.calculateGpa433();
                    //                    var  a=listModel.totalUnits()!=gpaRecord.totalUnits()
                    //                    var  b=listModel.cGPA()!=gpaRecord.cGPA()
                    //                    gpaRecord.Debugger(a,b);
                    if((listModel.cGPA()>0)&&(listModel.totalUnits()!=gpaRecord.totalUnits() || listModel.cGPA()!=gpaRecord.cGPA())){
                        saveStatus.text=" New Record Saved! "
                        gpaRecord.saveNewRecord(Qt.formatDate(new Date(),"yyyy/MM/dd"),listModel.cGPA(),listModel.totalUnits());
                    }
                }
                horizontalAlignment: HorizontalAlignment.Center
            }
            Label {
                text: "  Your CGPA is: " +summaryPage.gpa
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
            Label {
                id:saveStatus
            }
            
            Label {
                text: "History"
                textStyle.fontSize: FontSize.XXLarge
                textStyle.color: Color.Blue
                horizontalAlignment: HorizontalAlignment.Center
            }
//            Label {
//                text: Qt.formatDate(new Date(),"yyyy/MM/dd")
//            }
            Label {
                text:qsTr("\t  Date\t\t\t\tGPA\t        Credits    ")
            }
            Divider {
                
            }
            RecordList {
                
           }
        }
        
        actions: [
            ActionItem {
                title: "Graph"
                onTriggered:{

                    summaryPage.newGraphPage.webview.reload()
                    summaryNavi.push(summaryPage.newGraphPage)
                }
            }
        
        ]
        onCreationCompleted: {
            summaryPage.newGraphPage=graphPage.createObject()
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
//            Invocation {
//                            id: jsonInvocation
//                            query.mimeType: "text/plain"
//                            query.invokeTargetId: "sys.pim.uib.email.hybridcomposer"
//                            query.invokeActionId: "bb.action.SENDEMAIL"
//                            onArmed: {
//                                jsonInvocation.trigger(jsonInvocation.query.invokeActionId);
//                            }
//            }
        ]

    
    
    }

} //end of navipane




