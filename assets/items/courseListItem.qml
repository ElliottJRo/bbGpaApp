import bb.cascades 1.0

// This the item component for the items in the course list. It is a StandardListItem

StandardListItem {
    id: courseItem
    title: ListItemData.title
    imageSpaceReserved: false
    description: "test"
    status: "woot"

    //    contextActions: [
//        ActionSet {
//            title: ListItemData.title
//            subtitle: qsTr("Bucket action") + Retranslate.onLanguageChanged
//
//            ActionItem {
//                title: qsTr("Todo") + Retranslate.onLanguageChanged
//                enabled: bucketItem.ListItem.view.dataModel.filter == "todo" ? false : true
//                imageSource: "asset:///images/todo.png"
//
//                onTriggered: {
//                    if (enabled) {
//                        bucketItem.ListItem.view.dataModel.setStatus(bucketItem.ListItem.indexPath, "todo");
//                        bucketItem.ListItem.view.updateBBMStatus(qsTr("Added to my bucket list: ") + bucketItem.title, "images/todo.png");
//                    }
//                }
//            }
//            ActionItem {
//                title: qsTr("Finished") + Retranslate.onLanguageChanged
//                enabled: bucketItem.ListItem.view.dataModel.filter == "finished" ? false : true
//                imageSource: "asset:///images/finished.png"
//
//                onTriggered: {
//                    if (enabled) {
//                        bucketItem.ListItem.view.dataModel.setStatus(bucketItem.ListItem.indexPath, "finished");
//                        bucketItem.ListItem.view.updateBBMStatus(qsTr("Kicked from my bucket list: ") + bucketItem.title, "images/finished.png");
//                    }
//                }
//            }
//            ActionItem {
//                title: qsTr("Chickened out") + Retranslate.onLanguageChanged
//                enabled: bucketItem.ListItem.view.dataModel.filter == "chickened" ? false : true
//                imageSource: "asset:///images/chickened.png"
//
//                onTriggered: {
//                    if (enabled) {
//                        bucketItem.ListItem.view.dataModel.setStatus(bucketItem.ListItem.indexPath, "chickened");
//                        bucketItem.ListItem.view.updateBBMStatus(qsTr("Chickened out on my bucket list: ") + bucketItem.title, "images/chickened.png");
//                    }
//                }
//            }
//            ActionItem {
//                title: qsTr("Share Item") + Retranslate.onLanguageChanged
//                imageSource: "asset:///images/ic_share.png"
//                onTriggered: {
//                    bucketItem.ListItem.view.dataModel.shareBucketItem(bucketItem.title);
//
//                }
//            }
//            DeleteActionItem {
//                title: qsTr("Delete") + Retranslate.onLanguageChanged
//
//                onTriggered: {
//                    bucketItem.ListItem.view.dataModel.deleteBucketItems(bucketItem.ListItem.indexPath);
//                }
//            }
//
//            MultiSelectActionItem {
//                multiSelectHandler: bucketItem.ListItem.view.multiSelectHandler
//
//                onTriggered: {
//                    multiSelectHandler.active;
//                }
//            }
//        }
//    ]
}
