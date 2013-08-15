import bb.cascades 1.0

Page {
    Container {
        
        Header {
            title: "Settings"
        }
        layout: DockLayout {
        }
        Label{
            text: "Graph"
            translationY: 80.0
            textStyle.fontSize: FontSize.XXLarge
            translationX: 20.0
        }
        ToggleButton {
            id: graphButton
            translationY: 90.0
            onCheckedChanged: {
            }
            translationX: 470.0
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

