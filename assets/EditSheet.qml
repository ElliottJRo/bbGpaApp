import bb.cascades 1.0

// This QML sheet is used for editing and adding new courses to the gpaApp

Sheet {
    id: editSheet

    // Custom properties
    property alias title: addBar.title
    property alias hintText: courseName.hintText
    property alias courseText: courseName.text
    property alias profText: professorName.text
    property alias currentMark: currentMark.value
    property alias wantedMark: wantedMark.value

    // A custom signal is triggered when the acceptAction is triggered.
//    signal saveCourseItem(string text)
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
                    editSheet.close();
//                    editSheet.saveCourseItem(courseName.text);
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
                    Divider {
                        minHeight: 10.
                    }
                    TextField {
                        id: currentMarkText
                        inputMode: TextFieldInputMode.Text
                        enabled: false
                        text: "Current Mark:" + Math.floor(currentMark.value)
                        horizontalAlignment: HorizontalAlignment.Center
                        leftPadding: 50.0
                        rightPadding: 50.0

                    }
                    Slider {
                        id: currentMark
                        fromValue: 0.0
                        toValue: 100.0

                    }
                    Divider {
                        minHeight: 10.0
                    }
                    TextField {
                        id: wantedMarkText
                        inputMode: TextFieldInputMode.Text
                        enabled: false
                        text: "Wanted Mark:" + Math.floor(wantedMark.value)
                        horizontalAlignment: HorizontalAlignment.Center
                        leftPadding: 50.0
                        rightPadding: 50.0

                    }
                    Slider {
                        id: wantedMark
                        fromValue: 0.0
                        toValue: 100.0

                    }

                } // Text Area Container
            } // Scroll View
        } // Edit pane Container
    }// Page
    
//    onOpened: {
//        courseName.requestFocus()
//    }
    
}// Sheet
