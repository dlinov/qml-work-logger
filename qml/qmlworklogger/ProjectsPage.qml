import QtQuick 1.1
import com.nokia.meego 1.1
import com.nokia.extras 1.1
import 'components'
import 'delegates'
import 'js/core.js' as Core

Page {
    property int projectId: -1

    tools: ToolBarLayout {
        ToolIcon {
            platformIconId: "toolbar-back"
            anchors.left: (parent === undefined) ? undefined : parent.left
            onClicked: pageStack.pop()
        }
        ToolIcon {
            platformIconId: "toolbar-add"
            anchors.right: (parent === undefined) ? undefined : parent.right
            onClicked: addProjectPage.open()
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

    ListView {
        id: projectView
        anchors {
            top: pageHeader.bottom
            bottom: (parent === undefined) ? undefined : parent.bottom
            left: (parent === undefined) ? undefined : parent.left
            right: (parent === undefined) ? undefined : parent.right
        }
        model: ListModel { }
        delegate: ListDelegateEx {
            id: projectDelegate
            title: model.name
            subTitle: qsTr("id: %1; hourly rate %2").arg(model.id, model.rate)
            onClicked: switchToPage("ProjectInfoPage.qml", {itemId: model.id})
        }
    }

    ScrollDecorator {
        flickableItem: projectView
    }

    AddProjectPage {
        id: addProjectPage
        title: qsTr("New project")
        onAccepted: {
            Core.insertProject({name: addProjectPage.projectName, description: addProjectPage.projectDescription, rate: parseDouble(addProjectPage.projectHourlyRate)});
            refreshDataModel();
            addProjectPage.projectName = "";
            addProjectPage.projectDescription = "";
        }
    }

    onStatusChanged: refreshDataModel()

    function refreshDataModel() {
        projectData();
        addProjectPage.projectData();
    }

    function projectData(model) {
        projectView.model.clear()
        var dbData = Core.readProjects();
        for (var j = 0; j < dbData.length; j++) {
            projectView.model.append(dbData[j]);
        }
    }
}
