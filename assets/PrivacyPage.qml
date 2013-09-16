import bb.cascades 1.2
Sheet {    
    Page {
        titleBar: TitleBar {
            title: qsTr("Privacy Policy") + Retranslate.onLanguageChanged
        }
        actionBarVisibility: ChromeVisibility.Overlay
        Container {
            ScrollView {
                WebView {
                    url: "https://policy-portal.truste.com/core/privacy-policy/Big-Dream/b2fee9c9-b2a7-4412-acdb-ca0dfb557a21"
                }
                preferredHeight: 1050
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
    }
}
