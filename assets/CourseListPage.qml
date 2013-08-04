// List with a context menu project template
import bb.cascades 1.0

import com.rim.example.custom 1.0
Page {
    id: page1
    content: Container {
        ListView {
            id: listView
            objectName: "listView"

            dataModel: MyListModel {
                id: myListModel
            }
            property int activeItem: -1

            contextActions: [
                ActionSet {
                    // put context menu actions here
                    title: qsTr("Picture actions")
                    subtitle: qsTr("Set of the useful things to do ...")
                    ActionItem {
                        title: qsTr("Break")
                        onTriggered: {
                            // define action handler here
                            console.log("action triggered: " + title + " active item: " + listView.activeItem)
                            var flags = myListModel.value(listView.activeItem, "flags");
                            if (! flags) flags = {
                            };
                            flags.broken = ! flags.broken;
                            title = flags.broken ? qsTr("Unbreak") : qsTr("Break");
                            myListModel.setValue(listView.activeItem, "flags", flags)
                            myListModel.setValue(listView.activeItem, "image", assetForFlags(flags));
                            myListModel.setValue(listView.activeItem, "status", statusForFlags(flags));
                        }
                    }
                    ActionItem {
                        title: qsTr("Hide")
                        onTriggered: {
                            console.log("action triggered: " + title)
                            var flags = myListModel.value(listView.activeItem, "flags");
                            if (! flags) flags = {
                            };
                            flags.hidden = ! flags.hidden;
                            title = flags.hidden ? qsTr("Show") : qsTr("Hide");
                            myListModel.setValue(listView.activeItem, "flags", flags)
                            myListModel.setValue(listView.activeItem, "image", assetForFlags(flags));
                            myListModel.setValue(listView.activeItem, "status", statusForFlags(flags));
                        }
                    }
                }
            ]
            // Override default GroupDataModel::itemType() behaviour, which is to return item type "header"
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
            onSelectionChanged: {
                // slot called when ListView emits selectionChanged signal
                // A slot naming convention is used for automatic connection of list view signals to slots
                console.log("onSelectionChanged, selected: " + selected)
            }
            onActivationChanged: {
                console.log("onActivationChanged, active: " + active)
                if (active) listView.activeItem = indexPath[0]
            }
            layoutProperties: StackLayoutProperties {
                spaceQuota: 1.0
            }
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill

        }
    }
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
    
    
    //*********************      SIGNAL HANDLERS        *************************
    
    onCreationCompleted: {
        // this signal will be called when the qml page is created or loaded
        myListModel.load("app/native/assets/mydata.json")
    }
    actionBarVisibility: ChromeVisibility.Overlay
    actions: [
        ActionItem {
            // An ActionItem for adding more items to the list
            title: qsTr("Add Class") + Retranslate.onLanguageChanged
//            imageSource: "asset:///images/add.png"
            onTriggered: {
//                addNew.open();
//                addNew.text = "";
            }
        },
        ActionItem {
            title: "Delete Class"
        },
        ActionItem {
            title: "Sort"
        }
    ]
    attachedObjects: [
//        EditSheet {
//            // A sheet is used to add new items to the list, which is the same sheet used to edit items
//            id: addNew
//
//            onSaveCourseItem: {
//                courseModel.addCourseItem(text);
//                courseList.scrollToPosition(ScrollPosition.Beginning, ScrollAnimation.Default);
//            }
//        }
//        ComponentDefinition {
//            // A Component definition of the Page used to display more details on the Course item.
//            id: coursePage
//            source: "CoursePage.qml"
//        }
    ]

}