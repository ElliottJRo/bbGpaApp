import bb.cascades 1.0
import com.bbGpaApp.recordModel 1.0

ListView {
    id: recordList
    
    dataModel: gpaRecord
    
    listItemComponents: [
        // define delegates for different item types here
        ListItemComponent {
            // StandardListItem is a convivience component for lists with default cascades look and feel
            StandardListItem {
                status: ListItemData.recordTime
                title: (ListItem.indexPath[0]+1)+qsTr(".		") + ListItemData.gpa.toFixed(2)+ qsTr("		") + ListItemData.credits
                
            }
        }
    ]
    contextActions: [
        ActionSet {
            DeleteActionItem {
                title: qsTr("Delete") + Retranslate.onLanguageChanged
                
                onTriggered: {
                    // Delete the selected items. Clear selection before items are manipulated to avoid blink.
                    var selectionList = recordList.selectionList();
//                    courseList.clearSelection();
                    gpaRecord.deleteSelectedItems(selectionList);
                }
            }
        }
    ]
    verticalAlignment: VerticalAlignment.Bottom
    horizontalAlignment: HorizontalAlignment.Center
    topMargin: 0.0
    onCreationCompleted: {
        gpaRecord.setFilePath("data/html/GPA.json")
    }
}