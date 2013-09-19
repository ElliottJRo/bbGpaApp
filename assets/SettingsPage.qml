import bb.cascades 1.0
import com.bbGpaApp.coursedata 1.0

Sheet {
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
            ListView {
                layout: FlowListLayout {
                }
                topPadding: -70
                dataModel: XmlDataModel {
                    source: "asset:///xml/items.xml"
                }
                listItemComponents: [
                    
                    ListItemComponent {
                        type: "header"
                        
                        ToggleButton {
                            id: graphChecker
                            translationY: 105.0
                            translationX: 540.0
                            checked: Qt.settings.isGraphEnabled
                            onCheckedChanged: {
                                Qt.settings.isGraphEnabled = graphChecker.checked;
                                console.log("SettingsPage:  isGraphEnabled =", Qt.settings.isGraphEnabled)
                            }
                        }
                    }
                ]
            }
        }
        actions: [
            ActionItem {
                title: qsTr("Close") + Retranslate.onLanguageChanged
                ActionBar.placement: ActionBarPlacement.OnBar
                onTriggered: {
                    settingsPg.close();
                }
                imageSource: "asset:///images/ic_down.png"
            
            }
        ]
    }
}
