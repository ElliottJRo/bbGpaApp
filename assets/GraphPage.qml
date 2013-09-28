import bb.cascades 1.0
import bb.cascades.advertisement 1.0

Page{
    property alias webview : webViewScrollable
    property variant address
    titleBar: TitleBar {
        id: graphBar
        title: qsTr("Graph")+Retranslate.onLanguageChanged
        visibility: ChromeVisibility.Visible
    }
    Container {
        layout: DockLayout {
            
        }
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
                    text: qsTr(" Improvement Graph") + Retranslate.onLanguageChanged
                }
                
                WebView {
                    id: webViewScrollable
                    objectName: "graphView"
                    
                    onMinContentScaleChanged: {
                        scrollView.scrollViewProperties.minContentScale = minContentScale;
                    }
                    
                    onMaxContentScaleChanged: {
                        scrollView.scrollViewProperties.maxContentScale = maxContentScale;
                    }
                }
            }
        }
        Button {
            text:"F5"
            onClicked: {
                if(!settingsPg.isGraphOn){
                    
                    webViewScrollable.url=dirPaths.html+"GraphOff.html"
                    //listModel.resetUrl(gp.webview,"local:///assets/html/GraphOff.html")
                }else{
                    
                    webViewScrollable.url=dirPaths.html+"GPAGraph.html"
                    //listModel.resetUrl(gp.webview,"local:///assets/html/GPAGraph.html")
                }
                console.log("url="+webViewScrollable.url)
            }
            verticalAlignment: VerticalAlignment.Bottom
            horizontalAlignment: HorizontalAlignment.Center
            translationY: -100
            
        }
        Banner {
            id:ad
            zoneId: 117145//217188	
            refreshRate: 60
            preferredWidth: 300		
            preferredHeight: 50
            //transitionsEnabled: true
            //                placeHolderURL: "asset:///placeholder_728x90.png"
            backgroundColor: Color.Transparent
            borderColor: Color.Blue
            borderWidth: 2
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Bottom
        }
    }//end of container
}
