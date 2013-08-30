
// List with a context menu project template
import bb.cascades 1.0
import com.bbGpaApp.listModel 1.0
import com.bbGpaApp.recordModel 1.0

NavigationPane {
    id: summaryNavi
    
    Page {
        id: sumaryPage
        titleBar: TitleBar {
            id: titleBar
            visibility: ChromeVisibility.Visible
            title: "Summary"
        }
        Container {
            layout: StackLayout {

            }
            Label {
                text: "Your CGPA is:"
                verticalAlignment: VerticalAlignment.Top
                horizontalAlignment: HorizontalAlignment.Left
            }
            Label {
                id: gpaResult
                text: qsTr("~~~~~~")
                verticalAlignment: VerticalAlignment.Top
                horizontalAlignment: HorizontalAlignment.Center
                textStyle.fontSizeValue: 10.0
            
            }
            Button {
                text: qsTr("Press Here")
                onClicked: {
                    gpaResult.text = listModel.calculateGpa433();
                }
                horizontalAlignment: HorizontalAlignment.Center
            }
            ListView {

                dataModel: RecordModel {
                    id: gpaRecord
                }
                preferredHeight: 600
                listItemComponents: [
                    // define delegates for different item types here
                    ListItemComponent {
                        // StandardListItem is a convivience component for lists with default cascades look and feel
                        StandardListItem {
                            title: ListItemData.recordTime
                            description: ListItemData.gpa
//                            status: ListItemData.status
//                            imageSource: ListItemData.image
//                            onTouch: {
//                            
//                            }
                        }
                    }
                ]
                verticalAlignment: VerticalAlignment.Bottom
                horizontalAlignment: HorizontalAlignment.Center
                topMargin: 300.0
            }
        }
        
        actions: [
            ActionItem {
                title: "Graph"
                onTriggered:{
//                    gpaCurve.open();
					var  page=graphPage.createObject()
                    summaryNavi.push(page)
                }
            }
        
        ]
        attachedObjects: [
            GraphPage {
                id: gpaCurve
            },
            ComponentDefinition {
                // A Component definition of the Page used to display more details on the Course item.
                id: graphPage
                source: "GraphPage.qml"
            }
        ]
    
    
    }

} //end of navipane




