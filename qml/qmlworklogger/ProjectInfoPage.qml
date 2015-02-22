import QtQuick 1.1
import com.nokia.meego 1.1
import com.nokia.extras 1.1
import 'components'
import 'delegates'
import 'js/core.js' as Core

Page {
    tools: ToolBarLayout {
        ToolIcon {
            platformIconId: "toolbar-add"
            anchors.right: (parent === undefined) ? undefined : parent.right
            onClicked: addTaskPage.open()
        }
        ToolIcon {
            platformIconId: "toolbar-back"
            anchors.left: (parent === undefined) ? undefined : parent.left
            onClicked: pageStack.pop()
        }
    }

    property int itemId: -1
    property variant projectName: ""    // TODO: change variant type to some analog of string

    PageHeader {
        id: pageHeader
        title: "Project Info"
        visible: !appWindow.pageStack.busy || !theme.inverted
    }

    Label {
        id: labelNameTitle
        text: qsTr("Name:")
        anchors {
            top: (parent === undefined) ? undefined : pageHeader.bottom
            left: (parent === undefined) ? undefined : parent.left
        }
        font {
            pointSize: 16
            bold: true
        }
    }

    Label {
        id: labelName
        anchors {
            top: (parent === undefined) ? undefined : pageHeader.bottom
            left: (parent === undefined) ? undefined : labelNameTitle.right
        }
        font.pointSize: 16
    }

    TextField {
        id: projectHourlyRateInput
        anchors {
            top: labelName.bottom
            right: parent.right
            left: parent.left
            margins: 8
        }
        text: "0";
        validator: DoubleValidator {}
    }

    Label {
        id: labelCreatedTitle
        text: qsTr("Created on:")
        anchors {
            top: (parent === undefined) ? undefined : projectHourlyRateInput.bottom
            left: (parent === undefined) ? undefined : parent.left
        }
        font {
            pointSize: 16
            bold: true
        }
    }

    Label {
        id: labelCreated
        anchors {
            top: (parent === undefined) ? undefined : labelName.bottom
            left: (parent === undefined) ? undefined : labelCreatedTitle.right
        }
        font.pointSize: 16
    }

    Label {
        id: labelStartedTitle
        text: qsTr("Started on:")
        anchors {
            top: (parent === undefined) ? undefined : labelCreatedTitle.bottom
            left: (parent === undefined) ? undefined : parent.left
        }
        font {
            pointSize: 16
            bold: true
        }
    }

    Label {
        id: labelStarted
        anchors {
            top: (parent === undefined) ? undefined : labelCreated.bottom
            left: (parent === undefined) ? undefined : labelStartedTitle.right
        }
        font.pointSize: 16
    }

    Label {
        id: labelTasksCountTitle
        text: qsTr("Tasks count:")
        anchors {
            top: (parent === undefined) ? undefined : labelStartedTitle.bottom
            left: (parent === undefined) ? undefined : parent.left
        }
        font {
            pointSize: 16
            bold: true
        }
    }

    Label {
        id: labelTasksCount
        anchors {
            top: (parent === undefined) ? undefined : labelStarted.bottom
            left: (parent === undefined) ? undefined : labelTasksCountTitle.right
        }
        font.pointSize: 16
    }

    ListModel {
        id: tasksModel
    }

    ListView {
        id: tasksView
        anchors {
            top: (parent === undefined) ? undefined : labelTasksCountTitle.bottom
            left: (parent === undefined) ? undefined : parent.left
            bottom: (parent === undefined) ? undefined : parent.bottom
            right: (parent === undefined) ? undefined : parent.right
        }
        model: tasksModel
        delegate: ListDelegateEx {
            id: tasksDelegate
            title: model.name
            onClicked: {
                switchToPage("TaskInfoPage.qml", {itemId: model.id});
            }
        }
        clip: true
    }

    ScrollDecorator {
        flickableItem: tasksView
    }

    AddTaskSheet {
        id: addTaskPage
        title: qsTr("New task")
        onAccepted: {
            Core.insertTask({name: addTaskPage.taskName, description: addTaskPage.taskDescription, projectId: itemId});
            loadData();
            addTaskPage.taskName = "";
            addTaskPage.taskDescription = "";
        }
    }

    function loadData() {
        var dbData = Core.readProject(itemId);
        var tasks = Core.readTasksForProject(itemId);
        labelName.text = qsTr(dbData.name);
        projectHourlyRateInput = dbData.rate.toString;  // TODO: check if toString needed
        labelCreated.text = qsTr(dbData.created);
        labelStarted.text = qsTr(dbData.started);
        labelTasksCount.text = qsTr(tasks.length.toString());  // TODO: check if toString needed
        tasksModel.clear();
        for (var i = 0; i < tasks.length; i++) {
            tasksModel.append(tasks[i]);
        }
    }

    onStatusChanged: if (status === PageStatus.Activating) loadData();
}
