import bb.cascades 1.0

Page {
    
    
    titleBar: TitleBar {
        title: "Settings"
    }
    
    Container {        
        Header {
            id: header
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
                        id: graphChecker
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
    }
}

