import bb.cascades 1.0
Sheet {
    id: insideSettings
    Page {
        titleBar: TitleBar {
            title: "Settings"
        }
        actionBarVisibility: ChromeVisibility.Overlay
        
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
                            imageSource: "asset:///images/ic_graph.png"
                            title: ListItemData.title
                        
                        }
                    }
                ]
            }
        }
        actions: [
            ActionItem {
                title: "Close"
                ActionBar.placement: ActionBarPlacement.OnBar
                onTriggered: {
                    insideSettings.close();
                }
                imageSource: "asset:///images/ic_down.png"
            
            }
        ]
    }
}
