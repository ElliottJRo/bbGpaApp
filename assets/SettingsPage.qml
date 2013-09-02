import bb.cascades 1.0

Page {
   		titleBar: TitleBar {
         	title: "Settings"
        }
    content: Container {
            
        
        Header {
            title: "Features"
        }
        ListView {
            layout: FlowListLayout {
            }
            topPadding: -70
            dataModel: XmlDataModel {
                source: "asset:///items.xml"
            }
        listItemComponents: [
            
            ListItemComponent {
                type: "header"
                
                ToggleButton {
                    id: graphButton
                    translationY: 105.0
                    onCheckedChanged: {
                    }
                    
                    translationX: 540.0
                    checked: true
                }
            },
            ListItemComponent {
                type: "listitem"
                StandardListItem {
                    imageSource: "asset:///images/graphIcon.gif"
                    title: ListItemData.title
                    
                }
            }
        ]
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
        }
}

