import bb.cascades 1.0
import com.bbGpaApp.listModel 1.0



ListView {
    id: courseList
    dataModel: listModel 
    
    property int activeItem: -1
    
    listItemComponents: [
        // define delegates for different item types here
        ListItemComponent {
            // StandardListItem is a convivience component for lists with default cascades look and feel
            StandardListItem {
                title: ListItemData.text
                description: ListItemData.grade+"    "+ListItemData.mark
                status: ListItemData.status
                imageSource: ListItemData.image
                onTouch: {

                }
            }
        }
    ]
    
    contextActions: [
        ActionSet {
            // put context menu actions here
            title: qsTr("Course actions")
            subtitle: qsTr("Set of the useful things to do ...")
            ActionItem {
                title: qsTr("Edit")
                onTriggered: {
                    // define action handler here
                    console.log("action triggered: " + title + " active item: " + courseList.activeItem)
                    
                }
            }
            DeleteActionItem {
                title: qsTr("Delete") + Retranslate.onLanguageChanged
                
                onTriggered: {
                    // Delete the selected items. Clear selection before items are manipulated to avoid blink.
                    var selectionList = courseList.selectionList();
                    courseList.clearSelection();
                    listModel.deleteSelectedItems(selectionList);
                }
            }
        }
    ]
    
    //************************** SIGNALS ************************** //
    onSelectionChanged: {
        // slot called when ListView emits selectionChanged signal
        // A slot naming convention is used for automatic connection of list view signals to slots
        console.log("onSelectionChanged, selected: " + selected)
    }
    onActivationChanged: {
        console.log("onActivationChanged, active: " + active)
        if (active) courseList.activeItem = indexPath[0]
    }

    onTriggered: {
        // When an item is triggered, a navigation takes place to a detailed
        // view of the item where the user can edit the item. The page is created
        // via the ComponentDefinition from the attached objects in the NavigationPane.
        var chosenItem = dataModel.data(indexPath);
        var page = coursePage.createObject();

        // Set the Page properties and push the Page to the NavigationPane.
        page.item = chosenItem;
        page.courseModel = listModel;
        //page.title = listModel.text;
        courseListNav.push(page);
    }

    onCreationCompleted: {
        // this signal will be called when the qml page is created or loaded
        listModel.load("app/native/assets/json/mydata.json")
    }

    layoutProperties: StackLayoutProperties {
        spaceQuota: 1.0
    }
    horizontalAlignment: HorizontalAlignment.Fill
    verticalAlignment: VerticalAlignment.Fill
    

}