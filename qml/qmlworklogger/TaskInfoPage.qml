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
            platformIconId: "toolbar-delete"
            anchors.horizontalCenter: (parent === undefined) ? undefined : parent.horizontalCenter
            onClicked: {
                Core.removeTask(itemId);
                pageStack.pop();
            }
        }
    }

    property int itemId: -1

    PageHeader {
        id: header
        title: "Task Info"
        visible: !appWindow.pageStack.busy || !theme.inverted
    }

    Column {
        anchors.top: header.bottom
        anchors.margins: 8
        Row {
            Label {
                text: "Title: "
                font.bold: true
            }
            Label {
                id: title
                text: ""
            }
        }
        Row {
            Label {
                text: "Task id: "
                font.bold: true
            }
            Label {
                text: itemId
            }
        }
        Row {
            Label {
                text: "Current state: "
                font.bold: true
            }
            Label {
                id: state
                text: ""
            }
        }
        Row {
            Label {
                text: "Description: "
                font.bold: true
            }
            Label {
                id: description
                text: ""
            }
        }
        Row {
            Label {
                text: "Created: "
                font.bold: true
            }
            Label {
                id: created
                text: ""
            }
        }
        Repeater {
            // TODO: task parts
        }
    }

    Component.onCompleted: {
        var task = Core.readTask(itemId);
        var taskParts = Core.readTaskPartsForTask(itemId);
        title.text = task.name;
        description.text = task.description;
        created.text = task.created;
    }
}
