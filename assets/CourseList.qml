import bb.cascades 1.0
//import com.rim.example.custom 1.0
import com.courselist.coursedata 1.0

ListView {
    id: courseList
    objectName: "courseList"

//    dataModel: MyListModel {
//        id: myListModel
//    }
    dataModel: courseModel
    
    property int activeItem: -1

   listItemComponents: [
        ListItemComponent {
            courseListItem {
                // List item component (see items/courseListItem.qml for definition).
            }
        }
    ]
    /*
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
    } */
    
    //************************** SIGNALS ************************** //
    
    
    onSelectionChanged: {
        // slot called when ListView emits selectionChanged signal
        // A slot naming convention is used for automatic connection of list view signals to slots
//        console.log("onSelectionChanged, selected: " + selected)
    }
    onActivationChanged: {
        console.log("onActivationChanged, active: " + active)
//        if (active) courseList.activeItem = indexPath[0]
    }

    onTriggered: {
        // When an item is triggered, a navigation takes place to a detailed
        // view of the item where the user can edit the item. The page is created
        // via the ComponentDefinition from the attached objects in the NavigationPane.
        var chosenItem = dataModel.data(indexPath);
        var page = coursePage.createObject();

        // Set the Page properties and push the Page to the NavigationPane.
        page.item = chosenItem;
        page.courseModel = courseModel;
        //page.title = myListModel.text;
        courseListNav.push(page);
    }

    onCreationCompleted: {
        // this signal will be called when the qml page is created or loaded
        // courseModel.load("app/native/assets/mydata.json")
    }

    layoutProperties: StackLayoutProperties {
        spaceQuota: 1.0
    }
    horizontalAlignment: HorizontalAlignment.Fill
    verticalAlignment: VerticalAlignment.Fill
}