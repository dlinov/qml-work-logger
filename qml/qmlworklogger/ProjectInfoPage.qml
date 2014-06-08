import QtQuick 1.1
import com.nokia.meego 1.1
import com.nokia.extras 1.1
import 'components'
import 'delegates'
import 'js/core.js' as Core

Page {
    tools: backOnlyTools

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

    Label {
        id: labelCreatedTitle
        text: qsTr("Created on:")
        anchors {
            top: (parent === undefined) ? undefined : labelNameTitle.bottom
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

    function loadData() {
        var dbData = Core.readProject(itemId);
        var tasks = Core.readTasksCountForProject(itemId);
        labelName.text = qsTr(dbData.name);
        labelCreated.text = qsTr(dbData.created);
        labelStarted.text = qsTr(dbData.started);
        labelTasksCount.text = qsTr(tasks);
    }

    Component.onCompleted: {
        Core.openDB();
        loadData();
    }
}
