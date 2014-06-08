import QtQuick 1.1
import com.nokia.meego 1.1
import com.nokia.extras 1.1

PageStackWindow {
    id: appWindow    
    initialPage: homePage

    property variant uiConstants : ""

    HomePage {
        id: homePage
    }

    ToolBarLayout {
        id: backOnlyTools
        visible: false
        ToolIcon {
            platformIconId: "toolbar-back"
            anchors.left: (parent === undefined) ? undefined : parent.left
            onClicked: pageStack.pop()
        }
    }

    Menu {
        id: myMenu
        visualParent: pageStack
        MenuLayout {
            MenuItem {
                text: qsTr("Options")
                onClicked: switchToPage("OptionsPage.qml")
            }
            MenuItem {
                text: qsTr("Exit (debug only)")
                onClicked: Qt.quit()
            }
        }
    }

    function switchToPage(page, params) {
        pageStack.push(Qt.resolvedUrl(page), params);
    }

    function extendJavaScript() {
        String.prototype.startsWith = function(str) { var matched = this.match("^"+str+".*"); if (matched===null) { return false; }; return (matched.toString().localeCompare(this)===0); }
    }

    Component.onCompleted: {
        extendJavaScript();

        // for simulator support
        // TODO: add code to differ simulator and real device environment
        uiConstants = UiConstants;

//        if (!generalInfo.firmwareVersion.startsWith("DFL61\_HARMATTAN\_1")) {
//            //! Starting from PR1.1 UiConstants available from Qt Components
//            uiConstants = UiConstants;
//        } else {
//            uiConstants = {
//                "DefaultMargin" : 16,
//                "ButtonSpacing" : 6,
//                "HeaderDefaultHeightPortrait" : 72,
//                "HeaderDefaultHeightLandscape" : 46,
//                "HeaderDefaultTopSpacingPortrait" : 20,
//                "HeaderDefaultBottomSpacingPortrait" : 20,
//                "HeaderDefaultTopSpacingLandscape" : 16,
//                "HeaderDefaultBottomSpacingLandscape" : 14,
//                "ListItemHeightSmall" : 64,
//                "ListItemHeightDefault" : 80,
//                "IndentDefault" : 16,
//                "GroupHeaderHeight" : 40,
//                "BodyTextFont" : initializeFont("Nokia Pure Text Light", 24, false),
//                "GroupHeaderFont" : initializeFont("Nokia Pure Text", 18, true),
//                "HeaderFont": initializeFont("Nokia Pure Text Light", 32, false),
//                "TitleFont" : initializeFont("Nokia Pure Text", 26, true),
//                "SmallTitleFont" : initializeFont("Nokia Pure Text", 24, true),
//                "FieldLabelFont" : initializeFont("Nokia Pure Text Light", 22, false),
//                "FieldLabelColor" : "#505050",
//                "SubtitleFont" : initializeFont("Nokia Pure Text Light", 22, false),
//                "InfoFont" : initializeFont("Nokia Pure Text Light", 18, false)
//            };
//        }
    }
}
