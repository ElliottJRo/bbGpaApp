import bb.cascades 1.0
import com.bbGpaApp.listModel 1.0



ListView {
    id: courseList
    //objectName: "courseList"

    dataModel: listModel 
    //dataModel: courseModel
    
    property int activeItem: -1

   /* listItemComponents: [
        ListItemComponent {
            courseListItem {
                // List item component (see items/TodoItem.qml for definition).
            }
        }
    ] */
    
    listItemComponents: [
        // define delegates for different item types here
        ListItemComponent {
            // StandardListItem is a convivience component for lists with default cascades look and feel
            StandardListItem {
                title: ListItemData.text
                description: ListItemData.description
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
            title: qsTr("Picture actions")
            subtitle: qsTr("Set of the useful things to do ...")
            ActionItem {
                title: qsTr("Break")
                onTriggered: {
                    // define action handler here
                    console.log("action triggered: " + title + " active item: " + courseList.activeItem)
                    var flags = listModel.value(courseList.activeItem, "flags");
                    if (! flags) flags = {
                    };
                    flags.broken = ! flags.broken;
                    title = flags.broken ? qsTr("Unbreak") : qsTr("Break");
                    listModel.setValue(courseList.activeItem, "flags", flags)
                    listModel.setValue(courseList.activeItem, "image", assetForFlags(flags));
                    listModel.setValue(courseList.activeItem, "status", statusForFlags(flags));
                }
            }
            ActionItem {
                title: qsTr("Hide")
                onTriggered: {
                    console.log("action triggered: " + title)
                    var flags = listModel.value(courseList.activeItem, "flags");
                    if (! flags) flags = {
                    };
                    flags.hidden = ! flags.hidden;
                    title = flags.hidden ? qsTr("Show") : qsTr("Hide");
                    listModel.setValue(courseList.activeItem, "flags", flags)
                    listModel.setValue(courseList.activeItem, "image", assetForFlags(flags));
                    listModel.setValue(courseList.activeItem, "status", statusForFlags(flags));
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
    // Override default GroupDataModel::itemType() behaviour, which is to return item type "header"
    function assetForFlags(flags) {
        var ret = "asset:///images/picture1.png";
        if (flags.hidden) ret = null;
        else if (flags.broken) ret = "asset:///images/picture2.png";
        return ret;
    }
    function statusForFlags(flags) {
        var ret = "";
        if (flags.hidden) ret = qsTr("hidden");
        if (flags.broken) {
            if (ret) ret += ", ";
            ret += qsTr("broken");
        }
        return ret;
    }
    
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