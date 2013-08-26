import bb.cascades 1.0
import com.bbGpaApp.listModel 1.0

Page {
    id: sum
    Container {
        layout: DockLayout {
            
        }
        Header {
            title: "Summary"
        }
        Label {
            id: gpaResult
            text: qsTr("~~~~~~")
            verticalAlignment: VerticalAlignment.Top
            horizontalAlignment: HorizontalAlignment.Center
            textStyle.fontSizeValue: 2.0

        }
        Button {
            text: qsTr("Press Here")
            onClicked: {
                gpaResult.text = listModel.calculateGpa433();
            }
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
        }
    }

    actions: [
        ActionItem {
            title: "Graph"
        }

    ]


}