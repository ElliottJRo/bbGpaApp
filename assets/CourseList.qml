import bb.cascades 1.0
import com.rim.example.custom 1.0

ListView {
    id: courseList
    objectName: "courseList"

    dataModel: MyListModel {
        id: myListModel
    }
    property int activeItem: -1
    
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
                    var flags = myListModel.value(courseList.activeItem, "flags");
                    if (! flags) flags = {
                    };
                    flags.broken = ! flags.broken;
                    title = flags.broken ? qsTr("Unbreak") : qsTr("Break");
                    myListModel.setValue(courseList.activeItem, "flags", flags)
                    myListModel.setValue(courseList.activeItem, "image", assetForFlags(flags));
                    myListModel.setValue(courseList.activeItem, "status", statusForFlags(flags));
                }
            }
            ActionItem {
                title: qsTr("Hide")
                onTriggered: {
                    console.log("action triggered: " + title)
                    var flags = myListModel.value(courseList.activeItem, "flags");
                    if (! flags) flags = {
                    };
                    flags.hidden = ! flags.hidden;
                    title = flags.hidden ? qsTr("Show") : qsTr("Hide");
                    myListModel.setValue(courseList.activeItem, "flags", flags)
                    myListModel.setValue(courseList.activeItem, "image", assetForFlags(flags));
                    myListModel.setValue(courseList.activeItem, "status", statusForFlags(flags));
                }
            }
        }
    ]
    // Override default GroupDataModel::itemType() behaviour, which is to return item type "header"

    onSelectionChanged: {
        // slot called when ListView emits selectionChanged signal
        // A slot naming convention is used for automatic connection of list view signals to slots
        console.log("onSelectionChanged, selected: " + selected)
    }
    onActivationChanged: {
        console.log("onActivationChanged, active: " + active)
        if (active) courseList.activeItem = indexPath[0]
    }
    layoutProperties: StackLayoutProperties {
        spaceQuota: 1.0
    }
    horizontalAlignment: HorizontalAlignment.Fill
    verticalAlignment: VerticalAlignment.Fill
    
    onCreationCompleted: {
        // this signal will be called when the qml page is created or loaded
        myListModel.load("app/native/assets/mydata.json")
    }
}