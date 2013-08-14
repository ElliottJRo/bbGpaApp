/* Copyright (c) 2012 Research In Motion Limited.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 * http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import bb.cascades 1.0

// This details Page for a course item that shows the entire task contained in a course
// item and adds functionality for editing the item.

Page {
    id: coursePage
    property variant item
    property variant courseModel
    property alias title: titleBar.title

    titleBar: TitleBar {
        id: titleBar
        visibility: ChromeVisibility.Visible
    }

    Container {
        layout: DockLayout {
        }

        Container {
            leftPadding: 22
            rightPadding: leftPadding
            horizontalAlignment: HorizontalAlignment.Left

            Label {
                id: courseText
                multiline: true
                text: coursePage.item.title
                textStyle.base: SystemDefaults.TextStyles.TitleText
            }
        }
    }

    actions: [
        ActionItem {
            title: qsTr("Edit") + Retranslate.onLanguageChanged
//            imageSource: "asset:///images/edit.png"
            ActionBar.placement: ActionBarPlacement.OnBar

//            onTriggered: {
//                editSheet.open();
//                editSheet.text = courseText.text;
//            }
        }
    ]

    attachedObjects: [
//      EditSheet {
//          id: editSheet
//          title: qsTr("Edit") + Retranslate.onLanguageChanged
//          hintText: "Update course item description"
//
//          onSaveCourseItem: {
//              // Call the function to update the item data.
//              courseModel.editCourseItem(coursePage.item, text);
//
//              // Update the current item property data used in this Page to do this
//              // one has to copy all values to 'tempItem'.
//              var tempItem = coursePage.item
//              // Update the item property
//              tempItem.title = text
//              // Then copy all values back to 'coursePage.item'
//              coursePage.item = tempItem
//          }
//      }
    ]
}
