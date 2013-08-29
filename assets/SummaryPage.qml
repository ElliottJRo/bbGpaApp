
// List with a context menu project template
import bb.cascades 1.0
import com.bbGpaApp.listModel 1.0

NavigationPane {
    id: summaryNavi
    
    Page {
        id: sum
        Container {
            layout: DockLayout {
            
            }
            Header {
                title: "Summary"
            }
            Label {
                id: gpaResult
                text: qsTr("~~~~~~")
                verticalAlignment: VerticalAlignment.Top
                horizontalAlignment: HorizontalAlignment.Center
                textStyle.fontSizeValue: 2.0
            
            }
            Button {
                text: qsTr("Press Here")
                onClicked: {
                    gpaResult.text = listModel.calculateGpa433();
                }
                verticalAlignment: VerticalAlignment.Center
                horizontalAlignment: HorizontalAlignment.Center
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




