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
import com.bbGpaApp.listModel 1.0

// This details Page for a course item that shows the entire task contained in a course
// item and adds functionality for editing the item.

Page {
    id: coursePage
    property variant item
    property variant courseModel

    titleBar: TitleBar {
        id: titleBar
        visibility: ChromeVisibility.Visible
        title: coursePage.item.text
    }

    Container {
        layout: DockLayout {
        }

        Container {
            leftPadding: 22
            rightPadding: leftPadding
            horizontalAlignment: HorizontalAlignment.Left

            Label {
                id: courseName
                multiline: true
                text:  qsTr("Course: ") + Retranslate.onLanguageChanged + coursePage.item.text
                textStyle.base: SystemDefaults.TextStyles.TitleText
            }
            Label {
                id: semeserNum
                multiline: true
                text:  qsTr("Semester: ") + Retranslate.onLanguageChanged + coursePage.item.semester
                textStyle.base: SystemDefaults.TextStyles.TitleText
           }
            Label {
                id: courseMark
                multiline: true
                text: qsTr("Mark:  ") + Retranslate.onLanguageChanged + coursePage.item.mark
                textStyle.base: SystemDefaults.TextStyles.TitleText
            }
            Label {
                id: courseGrade
                multiline: true
                text: qsTr("Grade:  ") + Retranslate.onLanguageChanged + coursePage.item.grade
                textStyle.base: SystemDefaults.TextStyles.TitleText
            }
            Label {
                id: courseCredits
                multiline: true
                text: qsTr("Credits:  ") + Retranslate.onLanguageChanged + coursePage.item.credits
                textStyle.base: SystemDefaults.TextStyles.TitleText
            }
        }
    }

    actions: [
        ActionItem {
            title: qsTr("Edit") + Retranslate.onLanguageChanged
            imageSource: "asset:///images/ic_edit.png"
            ActionBar.placement: ActionBarPlacement.OnBar

            onTriggered: {
                editSheet2.open();
                editSheet2.courseText = item.text;
                editSheet2.mark=item.mark;
                editSheet2.semester=item.semester;
                editSheet2.credits=item.credits;

            }
        }
    ]

    attachedObjects: [
      EditSheet {
          id: editSheet2
          title: qsTr("Edit") + Retranslate.onLanguageChanged
          hintText: "Update course item description"

          onSaveCourseItem: {
              // Call the function to update the item data.
              var tempItem = listModel.editSelectedItem(item,courseText,mark.toFixed(0),credits,semester);
              coursePage.item = tempItem
          }
      }
    ]
}
