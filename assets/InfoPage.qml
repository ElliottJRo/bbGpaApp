import bb.cascades 1.0

Page {
    Container {
        id: infoContainer
        Header {
            title: "Information"
        }
        TextArea {
                text: "Credits:"

                editable: false
                scrollMode: TextAreaScrollMode.Stiff
                textStyle.fontSize: FontSize.Large
                textStyle.fontStyle: FontStyle.Italic
                textStyle.textAlign: TextAlign.Justify
                textStyle.color: Color.White
            translationY: -30.0
        }
            TextArea {
                text: "Aaqib Khorasi\nDanish Khakwani\nElliot Ro\nRui Zheng\nSunny Chowdhury\nQaim Maknojia"

                editable: false
                scrollMode: TextAreaScrollMode.Stiff
                textStyle.fontSize: FontSize.XXSmall
                textStyle.fontStyle: FontStyle.Italic
                textStyle.textAlign: TextAlign.Justify
                textStyle.color: Color.White
            translationY: -80.0
            translationX: 20.0
        }
        
        Button{
                text: "Email"
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


        Button {
            text: "\t\tClose Info"
            onClicked: info.close()
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Bottom
            imageSource: "asset:///images/info.png"
            preferredWidth: 600
            translationY: 70.0
        }
        
        
    }
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
