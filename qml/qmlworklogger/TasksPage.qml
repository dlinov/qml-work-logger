import QtQuick 1.1
import com.nokia.meego 1.1
import com.nokia.extras 1.1
import 'components'
import 'delegates'
import 'js/core.js' as Core

Page {
    tools: ToolBarLayout {
        ToolIcon {
            platformIconId: "toolbar-back"
            anchors.left: (parent === undefined) ? undefined : parent.left
            onClicked: pageStack.pop()
        }
        ToolIcon {
            platformIconId: "toolbar-add"
            anchors.right: (parent === undefined) ? undefined : parent.right
            onClicked: addTaskSheet.open()
        }
    }

    PageHeader {
        id: pageHeader
        title: "Tasks"
        visible: !appWindow.pageStack.busy || !theme.inverted
    }

    ListModel {
        id: tasksListModel
    }

    ListView {
        id: tasksView
        anchors {
            top: pageHeader.bottom
            bottom: (parent === undefined) ? undefined : parent.bottom
            left: (parent === undefined) ? undefined : parent.left
            right: (parent === undefined) ? undefined : parent.right
        }
        model: tasksListModel
        delegate: ListDelegateEx {
            id: taskDelegate
            title: model.name
            subTitle: qsTr("id: %1").arg(model.id)
            onClicked: switchToPage("TaskInfoPage.qml", {itemId: model.id})
        }
    }

    ScrollDecorator {
        flickableItem: tasksView
    }

    AddTaskSheet {
        id: addTaskSheet
        title: qsTr("New task")
        onAccepted: {
            Core.insertTask({name: addTaskSheet.taskName, description: addTaskSheet.taskDescription, projectId: addTaskSheet.projectId()});
            projectData(tasksView.model);
            addTaskSheet.taskName = "";
            addTaskSheet.taskDescription = "";
        }
        onRejected: {
            addTaskSheet.taskName = "";
            addTaskSheet.taskDescription = "";
        }
    }

    function projectData(model) {
        model.clear()
        var dbData = Core.readTasks();
        for (var j = 0; j < dbData.length; j++) {
            model.append({
                 id: dbData[j].id,
                 name: dbData[j].name,
                 description: dbData[j].description,
                 projectId: dbData[j].projectId
             });
        }
    }

    onStatusChanged: if (status === PageStatus.Activating) projectData(tasksListModel)
}
