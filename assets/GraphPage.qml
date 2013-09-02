import bb.cascades 1.0
//import com.bbGpaApp.drawModel 1.0

//Sheet {
//    id: graphSheet
//    
//    property alias title: graphBar.title
    Page{
        //id: graphPage
        
        property alias webview : webViewScrollable
        titleBar: TitleBar {
            id: graphBar
            title: qsTr("Graph")+Retranslate.onLanguageChanged
            visibility: ChromeVisibility.Visible
        }
        Container {
            
            ScrollView {
                id: scrollView
                scrollViewProperties {
                    scrollMode: ScrollMode.Both
                    pinchToZoomEnabled: true
                }
                layoutProperties: StackLayoutProperties { spaceQuota: 1.0 }
                
                Container {
                    background: Color.LightGray
                    
                    Label {
                        text: " Improvement Graph"
                    }
                    
                    WebView {
                        id: webViewScrollable
                        url: "local:///assets/html/GPAGraph.html"
                        
                        onMinContentScaleChanged: {
                            scrollView.scrollViewProperties.minContentScale = minContentScale;
                        }
                        
                        onMaxContentScaleChanged: {
                            scrollView.scrollViewProperties.maxContentScale = maxContentScale;
                        }
                    }
                }
            }
            
        }    
        
//        attachedObjects: [
//            DrawingModel{
//                id:dModel
//            }
//        ]
    }

//}
