
import bb.cascades 1.0

Page {
    titleBar: TitleBar {
        title: "Settings"
        
    }
    content: Container {
        Header {
            title: "Features"
        }
        
        // Create a ListView that uses an XML data model
        ListView {
            layout: FlowListLayout {
            }
            topPadding: -70
            //rightPadding: 230
            dataModel: XmlDataModel {
                source: "asset:///items.xml"
            }
            listItemComponents: [
                ListItemComponent {
                    type: "header"
                    
                    // Use a predefined StandardListItem to represent "listItem"
                    // items
                    ToggleButton {
                        id: graphButton
                        translationY: 105
                        onCheckedChanged: {
                        }
                        translationX: 540.0
                        checked: true	
                    }
                
                },
                ListItemComponent {
                    type: "listItem"
                
                    // Use a predefined StandardListItem to represent "listItem"
                    // items
                    StandardListItem {
                        title: ListItemData.title
                        imageSource: "asset:///images/graphIcon.gif"
                    }
                    
                    
                } // end of second ListItemComponent
            ]
            
            
            // end of listItemComponents list
        }
        Button {
            text: "\t       Close Settings"
            onClicked: settings.close()
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Bottom
            imageSource: "asset:///images/settings.png"
            preferredWidth: 600
            translationY: -10.0
        }
        // end of ListView
    } // end of Container
} // end of Page
