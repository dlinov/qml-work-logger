import QtQuick 1.1
import com.nokia.meego 1.1
import com.nokia.extras 1.1

Page {
    tools: backOnlyTools

    Label { text: qsTr("Add Task Page"); }

    Label { text: qsTr("Task name"); }
    TextEdit {
        id: newTaskName
    }

    Button {
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: label.bottom
            topMargin: 10
        }
        text: qsTr("Submit")
    }
}
