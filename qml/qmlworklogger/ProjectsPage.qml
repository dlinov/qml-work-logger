import QtQuick 1.1
import com.nokia.meego 1.1
import com.nokia.extras 1.1
//import QtMobility.systeminfo 1.2
import 'components'
import 'delegates'
import 'js/core.js' as Core

Page {
    property int projectId: -1

    tools: ToolBarLayout {
        ToolIcon {
            platformIconId: "toolbar-add"
            anchors.right: (parent === undefined) ? undefined : parent.right
            onClicked: addProjectPage.open()
        }
        ToolIcon {
            platformIconId: "toolbar-back"
            anchors.left: (parent === undefined) ? undefined : parent.left
            onClicked: pageStack.pop()
        }
    }

    PageHeader {
        id: pageHeader
        title: "Projects"
//        visible: !mainPageStack.busy || !theme.inverted
        visible: !appWindow.pageStack.busy || !theme.inverted
    }

    Label {
        text: qsTr("Project page label");
        anchors.fill: parent
    }

    ListModel {
        id: projectListModel
    }

    ListView {
        id: projectView
        anchors {
            top: pageHeader.bottom
            bottom: (parent === undefined) ? undefined : parent.bottom
            left: (parent === undefined) ? undefined : parent.left
            right: (parent === undefined) ? undefined : parent.right
        }
        model: projectListModel
        delegate: ListDelegateEx {
            id: projectDelegate
            title: model.name
            subTitle: qsTr("id: %1; created: %2; started: %3; finished: %4")
                .arg(model.id).arg(model.created).arg(model.started).arg(model.finished)
            onClicked: {
                console.log(qsTr("%1 %2").arg(model.id).arg(model.name));
                switchToPage("ProjectInfoPage.qml");
            }
        }
        clip: true
    }

    ScrollDecorator {
        flickableItem: projectView
    }

    AddProjectPage {
        id: addProjectPage
        title: qsTr("New project")
        onAccepted: Core.insertProject({
                                           name: addProjectPage.projectName,
                                           description: addProjectPage.projectDescription
                                       }
                                       );
    }

    function projectData(model) {
        model.clear()
        var dbData = Core.readProjects();
        for (var j = 0; j < dbData.length; j++) {
            model.append({
                             id: dbData[j].id,
                             name: dbData[j].name,
                             created: dbData[j].created,
                             started: dbData[j].started,
                             finished: dbData[j].finished
                         });
        }
    }

//    onStatusChanged: {
//        if (status === PageStatus.Activating) {
//            projectView.model = 0;
//            projectData(projectListModel);
//            projectView.model = projectListModel;
//        }
//    }
    Component.onCompleted: {
        // Initialize the database
        Core.openDB();
        projectView.model = 0;
        projectData(projectListModel);
        projectView.model = projectListModel;
        //Storage.initialize();
        // Sets a value in the database
        //Storage.setSetting("mySetting","myValue");
        // Sets the textDisplay element's text to the value we just set
        //textDisplay.text = "The value of mySetting is:\n" + Storage.getSetting("mySetting");
    }
}
