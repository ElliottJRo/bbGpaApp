import bb.cascades 1.0
Sheet {
    id: insideInfo
    Page {
        titleBar: TitleBar {
            title: qsTr("Information") + Retranslate.onLanguageChanged
        }
        actionBarVisibility: ChromeVisibility.Overlay
        Container {
            id: infoContainer
            topPadding: 10
            TextArea {
                text: qsTr("Credits:") + Retranslate.onLanguageChanged

                editable: false
                    scrollMode: TextAreaScrollMode.Stiff
                    textStyle.fontSize: FontSize.Large
                    textStyle.fontStyle: FontStyle.Italic
                    textStyle.textAlign: TextAlign.Justify
                translationY: -30.0
            }
                TextArea {
                    text: "Aaqib Khorasi\nDanish Khakwani\nElliott Ro\nRui Zheng\nSunny Chowdhury\nQaim Maknojia"
    
                    editable: false
                    scrollMode: TextAreaScrollMode.Stiff
                    textStyle.fontSize: FontSize.XXSmall
                    textStyle.fontStyle: FontStyle.Italic
                    textStyle.textAlign: TextAlign.Justify
                translationY: -80.0
                translationX: 20.0
            }
            
            Button{
                text: qsTr("Email") + Retranslate.onLanguageChanged
                preferredWidth: 200
                translationY: -70.0
                horizontalAlignment: HorizontalAlignment.Center
                onClicked: {
                emailInvocation.query.uri = "mailto:sfugpaapp@gmail.com"
                emailInvocation.query.updateQuery();
                }
            }
              Label {
                  text: "<html>sfugpaapp@gmail.com</html>"
                  horizontalAlignment: HorizontalAlignment.Center
                  textStyle.fontSize: FontSize.XLarge
                  translationY: -90.0
            }
        }
        actions: [
            ActionItem {
                title: qsTr("Close") + Retranslate.onLanguageChanged
                ActionBar.placement: ActionBarPlacement.OnBar
                onTriggered: {
                    insideInfo.close();
                }
                imageSource: "asset:///images/ic_down.png"
            }
        ]
        attachedObjects:[
            Invocation {
                id: emailInvocation
                query.mimeType: "text/plain"
                query.invokeTargetId: "sys.pim.uib.email.hybridcomposer"
                query.invokeActionId: "bb.action.SENDEMAIL"
                onArmed: {
                    emailInvocation.trigger(emailInvocation.query.invokeActionId);
                }
            }
        ]    	
    }
}
