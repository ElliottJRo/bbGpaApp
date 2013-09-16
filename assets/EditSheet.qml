import bb.cascades 1.0
import com.bbGpaApp.listModel 1.0
// This QML sheet is used for editing and adding new courses to the gpaApp

Sheet {
    id: editSheet

    // Custom properties
    property alias title: addBar.title
    property alias hintText: courseName.hintText
    property alias courseText: courseName.text
    property alias profText: professorName.text
    property alias mark: markSlider.value
    property alias credits: creditsSlider.value
    property alias semester: semesterPicker.description
    

    // A custom signal is triggered when the acceptAction is triggered.
    signal saveCourseItem()
    Page {
        id: addPage
        titleBar: TitleBar {
            id: addBar
            title: qsTr("Add") + Retranslate.onLanguageChanged
            visibility: ChromeVisibility.Visible
            
            dismissAction: ActionItem {
                title: qsTr("Cancel") + Retranslate.onLanguageChanged
                onTriggered: {
                    // Hide the Sheet.
                    editSheet.close()
                }
            }
            
            acceptAction: ActionItem {
                title: qsTr("Save") + Retranslate.onLanguageChanged
                onTriggered: {
                    // Hide the Sheet and emit signal that the course should be saved.
                    
                    editSheet.saveCourseItem();
                    editSheet.close();
                }
            }
        }
        Container {
            id: editPane
            property real margins: 40
            background: Color.create("#f8f8f8")
            topPadding: editPane.margins
            leftPadding: editPane.margins
            rightPadding: editPane.margins

            layout: DockLayout {
            }

            attachedObjects: [
                TextStyleDefinition {
                    id: editTextStyle
                    base: SystemDefaults.TextStyles.TitleText
                }
            ]
            ScrollView {
                scrollViewProperties.scrollMode: ScrollMode.Vertical
                scrollViewProperties.overScrollEffectMode: OverScrollEffectMode.Default
                scrollViewProperties.pinchToZoomEnabled: false
                
                Container {
                    id: editItem
                    TextField {
                        id: courseName
                        hintText: qsTr("Course Name") + Retranslate.onLanguageChanged
                        topMargin: editPane.margins
                        bottomMargin: topMargin
                        preferredHeight: 450
                        maxHeight: 450
                        horizontalAlignment: HorizontalAlignment.Fill

                        textStyle {
                            base: editTextStyle.style
                        }
                    }
                    TextField {
                        id: professorName
                        hintText: qsTr("Professor Name") + Retranslate.onLanguageChanged
                        topMargin: editPane.margins
                        bottomMargin: topMargin
                        preferredHeight: 100
                        maxHeight: 100
                        horizontalAlignment: HorizontalAlignment.Fill

                        textStyle {
                            base: editTextStyle.style
                        }
                    }
                    Picker {
                        id: semesterPicker
                        title: qsTr("Semester") + Retranslate.onLanguageChanged
                        description: "0"
                        rootIndexPath: []
                        preferredRowCount: 3
                        dataModel: XmlDataModel {
                        	source: "asset:///xml/semesterList.xml"
                        }
                        pickerItemComponents: [
                            PickerItemComponent {
                                type: "item2"
                                
                                content: Container {
                                    Label {
                                        text: pickerItemData.text
                                        textStyle.fontSizeValue: 18.0
                                    }
                                }
                            }
                      ]
                        onSelectedValueChanged: {
                            var semesterValue = semesterPicker.selectedValue;
                            semesterValue++;
                            semesterPicker.description = semesterValue;
                        }
                    }

                    Divider {
                        minHeight: 10
                    }
                    TextField {
                        id: markText
                        inputMode: TextFieldInputMode.Text
                        enabled: false
                        text: qsTr("Mark:") + Retranslate.onLanguageChanged + Math.floor(mark)
                        horizontalAlignment: HorizontalAlignment.Center
                        leftPadding: 50.0
                        rightPadding: 50.0

                    }
                    TextField {
                        id: gradeText
                        inputMode: TextFieldInputMode.Text
                        enabled: false
                        text: qsTr("Grade:") + Retranslate.onLanguageChanged + tempModel.markToGrade(mark)
                        horizontalAlignment: HorizontalAlignment.Center
                        leftPadding: 50.0
                        rightPadding: 50.0
                    
                    }
                    Slider {
                        id: markSlider
                        fromValue: 0.0
                        toValue: 100.0
                        onImmediateValueChanged: {
                            mark = immediateValue;
                        }
                    }
                    Divider {
                        minHeight: 10
                    }
                    TextField {
                        id: creditsText
                        inputMode: TextFieldInputMode.Text
                        enabled: false
                        text: qsTr("Credits:  ") + Retranslate.onLanguageChanged + Math.floor(creditsSlider.value)
                        horizontalAlignment: HorizontalAlignment.Center
                        leftPadding: 50
                        rightPadding: 50

                    }
                    Slider {
                        id: creditsSlider
                        fromValue: 0
                        toValue: 4
                        onImmediateValueChanged: {
                            creditsText.text = qsTr("Credits: ") + Retranslate.onLanguageChanged + Math.floor(creditsSlider.immediateValue)
                        }
                    }

                } // Text Area Container
            } // Scroll View
        } // Edit pane Container
    attachedObjects: [
	    MyListModel{
	        id:tempModel
	    }
    ]
    }// Page
    
    
}// Sheet
