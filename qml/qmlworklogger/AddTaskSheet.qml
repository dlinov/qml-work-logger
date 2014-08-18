import QtQuick 1.1
import com.nokia.meego 1.1
import com.nokia.extras 1.1
import 'components'
import 'js/core.js' as Core

Sheet {
    property alias taskName: taskNameEditor.value
    property alias taskDescription: taskDescriptionEditor.value
    acceptButtonText: "Save"
    rejectButtonText: "Cancel"
    acceptButton.enabled: projectsSelector.selectedIndex > -1

    content: Item {
        anchors.fill: parent

        SimplePropertyEditor {
            id: taskNameEditor
            key: 'Task name:'
            placeholder: 'Enter task name'
            allowEmptyInput: false
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
            }
        }

        LongTextPropertyEditor {
            id: taskDescriptionEditor
            key: 'Task description:'
            placeholder: 'Enter task description'
            allowEmptyInput: false
            anchors {
                top: taskNameEditor.bottom
                left: parent.left
                right: parent.right
            }
        }

        SelectionPropertySelector {
            id: projectsSelector
            key: 'Project selection'
            anchors {
                top: taskDescriptionEditor.bottom
                left: parent.left
                right: parent.right
            }
        }
    }

    Component.onCompleted: projectData(projectsSelector.model)

    function projectId() {
        return projectsSelector.model.get(projectsSelector.selectedIndex).id;
    }

    function projectData(model) {
        model.clear()
        var dbData = Core.readProjects();
        for (var j = 0; j < dbData.length; j++) {
            model.append({
                 id: dbData[j].id,
                 name: dbData[j].name
             });
        }
    }
}
