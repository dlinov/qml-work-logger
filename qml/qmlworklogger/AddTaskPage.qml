import QtQuick 1.1
import com.nokia.meego 1.1
import com.nokia.extras 1.1

Sheet {
    acceptButtonText: "Save"
    rejectButtonText: "Cancel"
    property alias taskName : taskName.text
    property alias taskDescription : taskDescription.text

    content: Item {
        anchors.fill: parent

        Label {
            id: taskNameLabel
            text: qsTr("Task name:");
            anchors {
                top: parent.top
                right: parent.right
                left: parent.left
                margins: 8
            }
        }

        TextField {
            id: taskName
            anchors {
                top: taskNameLabel.bottom
                right: parent.right
                left: parent.left
                margins: 8
            }
            placeholderText: "Please enter task name";

            onTextChanged: {
                if (errorHighlight) {
                    errorHighlight = false;
                }
            }

            onAccepted: {
                if (taskDescription.text.length > 0) {
                    taskDescription.focus = true;
                } else {
                    errorHighlight = true;
                }
            }
        }

        Label {
            id: taskDescriptionLabel
            text: qsTr("Description:")
            anchors {
                top: taskName.bottom
                right: parent.right
                left: parent.left
                margins: 8
            }
        }

        TextArea {
            id: taskDescription
            anchors {
                top: taskDescriptionLabel.bottom
                right: parent.right
                left: parent.left
                margins: 8
            }
        }
    }
}
