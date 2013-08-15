import bb.cascades 1.0

// This the item component for the items in the course list. It is a StandardListItem

StandardListItem {
    id: courseItem
    title: ListItemData.title
    imageSpaceReserved: false
    description: "test"
    status: "woot"

    contextActions: [
        ActionSet {
            title: ListItemData.title
            subtitle: qsTr("Bucket action") + Retranslate.onLanguageChanged

            ActionItem {
                title: qsTr("Todo") + Retranslate.onLanguageChanged
                enabled: courseItem.ListItem.view.dataModel.filter == "todo" ? false : true
                //imageSource: "asset:///images/todo.png"

                onTriggered: {
                    if (enabled) {
                        courseItem.ListItem.view.dataModel.setStatus(courseItem.ListItem.indexPath, "todo");
                        courseItem.ListItem.view.updateBBMStatus(qsTr("Added to my course list: ") + courseItem.title, "images/todo.png");
                    }
                }
            }
            ActionItem {
                title: qsTr("Finished") + Retranslate.onLanguageChanged
                enabled: courseItem.ListItem.view.dataModel.filter == "finished" ? false : true
                //imageSource: "asset:///images/finished.png"

                onTriggered: {
                    if (enabled) {
                        courseItem.ListItem.view.dataModel.setStatus(courseItem.ListItem.indexPath, "finished");
                        courseItem.ListItem.view.updateBBMStatus(qsTr("Kicked from my course list: ") + courseItem.title, "images/finished.png");
                    }
                }
            }
            ActionItem {
                title: qsTr("Chickened out") + Retranslate.onLanguageChanged
                enabled: courseItem.ListItem.view.dataModel.filter == "chickened" ? false : true
                //imageSource: "asset:///images/chickened.png"

                onTriggered: {
                    if (enabled) {
                        courseItem.ListItem.view.dataModel.setStatus(courseItem.ListItem.indexPath, "chickened");
                        courseItem.ListItem.view.updateBBMStatus(qsTr("Chickened out on my course list: ") + courseItem.title, "images/chickened.png");
                    }
                }
            }
            ActionItem {
                title: qsTr("Share Item") + Retranslate.onLanguageChanged
                //imageSource: "asset:///images/ic_share.png"
                onTriggered: {
                    courseItem.ListItem.view.dataModel.shareBucketItem(courseItem.title);

                }
            }
            DeleteActionItem {
                title: qsTr("Delete") + Retranslate.onLanguageChanged

                onTriggered: {
                    courseItem.ListItem.view.dataModel.deleteBucketItems(courseItem.ListItem.indexPath);
                }
            }

            MultiSelectActionItem {
                multiSelectHandler: courseItem.ListItem.view.multiSelectHandler

                onTriggered: {
                    multiSelectHandler.active;
                }
            }
        }
    ]
}
