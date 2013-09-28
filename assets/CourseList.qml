import bb.cascades 1.0
import com.bbGpaApp.listModel 1.0


ListView {
    id: courseList
    dataModel: listModel
    
    property int activeItem: -1
    property variant item

    listItemComponents: [
        // define delegates for different item types here
        ListItemComponent {
            // StandardListItem is a convivience component for lists with default cascades look and feel
            StandardListItem {
                
                title: ListItemData.text
                description: qsTr("Semester") + Retranslate.onLanguageChanged+ ": " + ListItemData.semester
                status: qsTr("Grade")+ Retranslate.onLanguageChanged + ": " + ListItemData.grade+" : "+ListItemData.mark +"% : "+ qsTr("Credits") + Retranslate.onLanguageChanged + ":" + ListItemData.credits
                imageSpaceReserved: false
            }
            
        }
        
    ]
    
    contextActions: [
        ActionSet {
            // put context menu actions here
            title: qsTr("Course actions") + Retranslate.onLanguageChanged
            subtitle: qsTr("Set of the useful things to do ...") + Retranslate.onLanguageChanged
            
            //Got rid of edit from course list because its not working atm
//            ActionItem {
//                title: qsTr("Edit")
//                imageSource: "asset:///images/ic_edit.png"
//                onTriggered: {
//                    var selectionList = courseList.selectionList();
//                    courseList.clearSelection();
//                    var chosenItem = dataModel.data(selectionList);
//                    courseList.item = chosenItem;
//                    // define action handler here
//                    editFromCourseList.open();
//                    editFromCourseList.courseText = item.text;
//                    editFromCourseList.semester = item.semester;
//                    editFromCourseList.mark=item.mark;
//                    editFromCourseList.credits=item.credits;
//                }
//            }
            DeleteActionItem {
                title: qsTr("Delete") + Retranslate.onLanguageChanged
                
                onTriggered: {
                    // Delete the selected items. Clear selection before items are manipulated to avoid blink.
                    var selectionList = courseList.selectionList();
                    courseList.clearSelection();
                    listModel.deleteSelectedItems(selectionList);
                    
                    if(listModel.isCourseListEmpty()) {
                        courseListIns.visible = false;
                        emptyCourseListContainer.visible = true;
                    } else {
                        courseListIns.visible = true;
                        emptyCourseListContainer.visible = false;
                    }
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
    attachedObjects: [
        EditSheet {
            // an attached sheet to edit the course via courseList Page
            id: editFromCourseList
            title: qsTr("Edit") + Retranslate.onLanguageChanged
            hintText: "Update course item description"
            onSaveCourseItem: {
                // Call the function to update the item data.
                var tempItem=listModel.editSelectedItem(item,courseText,mark.toFixed(0),credits,semester);
                
                // Then copy all values back to 'coursePage.item'
                courseList.item = tempItem
            }
        }
    ]

    onCreationCompleted: {
        // this signal will be called when the qml page is created or loaded
        listModel.load("data/json/mydata.json")
    }

    layoutProperties: StackLayoutProperties {
        spaceQuota: 1.0
    }
    horizontalAlignment: HorizontalAlignment.Fill
    verticalAlignment: VerticalAlignment.Fill

}