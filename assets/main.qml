// Default empty project template
import bb.cascades 1.0

// creates one page with a label
TabbedPane {
    id: tabbedPane
    showTabsOnActionBar: true
    Tab {
        title: "Classes"
        CourseListPage {
        }
    } // end of first Tab

    Tab {
        title: "Course"
        CoursePage {
        } // end of second tab

    }
    Tab {
        title: "Summary"
        SummaryPage {
        }

    } // end of third Tab

}// end of TabbedPane
