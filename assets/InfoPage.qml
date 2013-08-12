import bb.cascades 1.0

Page {
    Container {
        Header {
            title: "Information"
        }

        Container {
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center

            TextArea {
                text: "Credits:"

                editable: false
                scrollMode: TextAreaScrollMode.Stiff
                textStyle.fontSize: FontSize.Large
                textStyle.fontStyle: FontStyle.Italic
                textStyle.textAlign: TextAlign.Justify
                textStyle.color: Color.White
            }
            TextArea {
                text: "Aaqib Khorasi\nDanish Khakwani\nElliot Ro\nRui Zheng\nSunny Chowdhury\nQaim Maknojia"

                editable: false
                scrollMode: TextAreaScrollMode.Stiff
                textStyle.fontSize: FontSize.XXSmall
                textStyle.fontStyle: FontStyle.Italic
                textStyle.textAlign: TextAlign.Justify
                textStyle.color: Color.White
            }
            Label {
                //Open a email browser (fix it)
                text: "<html>sfugpaapp@gmail.com</html>"
                horizontalAlignment: HorizontalAlignment.Center
                textStyle.fontSize: FontSize.XLarge
            }
        }

        Button {
            text: "Close Info"
            onClicked: info.close()
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Bottom
        }
    }
}
