import bb.cascades 1.0
//import com.bbGpaApp.coursedata 1.0

Sheet {
    property alias isGraphOn:graphChecker.checked
    Page {
        titleBar: TitleBar {
            title: qsTr("Settings") + Retranslate.onLanguageChanged
        }
        actionBarVisibility: ChromeVisibility.Overlay
        
        Container {
            
            Header {
                id: header
                title: qsTr("Features") + Retranslate.onLanguageChanged
            }
            Divider {
                preferredHeight: 10
            }
            Container {
                layout: DockLayout {
                    
                }
                preferredWidth: 768
                Label {
                    text: qsTr("  Graph") + Retranslate.onLanguageChanged
                    textStyle.fontSize: FontSize.XLarge
                    verticalAlignment: VerticalAlignment.Top
                    horizontalAlignment: HorizontalAlignment.Left

                }
                ToggleButton {
                    id: graphChecker
                    //translationX: 400.0
                    //                            checked: Qt.settings.isGraphEnabled
                    
                    onCheckedChanged: {
                        //                                Qt.settings.isGraphEnabled = graphChecker.checked;
                        //                                console.log("SettingsPage:  isGraphEnabled =", Qt.settings.isGraphEnabled)
                    }
                    verticalAlignment: VerticalAlignment.Top
                    horizontalAlignment: HorizontalAlignment.Right

                }
            }
            Divider {
                preferredHeight: 10
            }
            Container {
                Label {
                    text: Qdir
                }
            } 
        }
        actions: [
            ActionItem {
                title: qsTr("Close") + Retranslate.onLanguageChanged
                ActionBar.placement: ActionBarPlacement.OnBar
                onTriggered: {
                    close();
                }
                imageSource: "asset:///images/ic_down.png"
            
            }
        ]
        onCreationCompleted: {
            isGraphOn=false;
        }
    }
}
