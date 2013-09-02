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
                text:  "Course:	"+coursePage.item.text
                textStyle.base: SystemDefaults.TextStyles.TitleText
            }
            Label {
                id: semeserNum
                multiline: true
                text:  "Semester: "+coursePage.item.semester
                textStyle.base: SystemDefaults.TextStyles.TitleText
           }
            Label {
                id: courseMark
                multiline: true
                text: "Mark:	"+coursePage.item.mark
                textStyle.base: SystemDefaults.TextStyles.TitleText
            }
            Label {
                id: courseGrade
                multiline: true
                text: "Grade:	"+coursePage.item.grade
                textStyle.base: SystemDefaults.TextStyles.TitleText
            }
            Label {
                id: courseCredits
                multiline: true
                text: "Credits:	"+coursePage.item.credits
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
              var tempItem=listModel.editSelectedItem(item,courseText,mark.toFixed(0),credits,semester);

              // Update the current item property data used in this Page to do this
              // one has to copy all values to 'tempItem'.
//              var tempItem = coursePage.item
//              // Update the item property
//              tempItem.title = courseText
//              tempItem.description=mark.toFixed(0)+"    "+listModel.markToGrade(mark);
//              tempItem.status=credits.toFixed(0)
              // Then copy all values back to 'coursePage.item'
              coursePage.item = tempItem
          }
      }
    ]
}
