import bb.cascades 1.0

Page {
    Container {
        Header {
            title: "Settings"
        }

        Container {
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center

            Label {
                //Open a email browser (fix it)
                text: "<html>sfugpaapp@gmail.com</html>"
                horizontalAlignment: HorizontalAlignment.Center
                textStyle.fontSize: FontSize.XLarge
            }
        }

        Button {
            text: "Close Settings"
            onClicked: settings.close()
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Bottom
        }
    }
}
