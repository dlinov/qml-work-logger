import QtQuick 1.1
import com.nokia.meego 1.1
import com.nokia.extras 1.1

Sheet {
    acceptButtonText: "Save"
    rejectButtonText: "Cancel"
    property alias projectName : projectName.text
    property alias projectDescription : projectDescription.text

    content: Item {
        anchors.fill: parent

        Label {
            id: projectNameLabel
            text: qsTr("Project name:");
            anchors {
                top: parent.top
                right: parent.right
                left: parent.left
                margins: 8
            }
        }

        TextField {
            id: projectName
            anchors {
                top: projectNameLabel.bottom
                right: parent.right
                left: parent.left
                margins: 8
            }
            placeholderText: "Please enter project name";

            onTextChanged: {
                if (errorHighlight) {
                    errorHighlight = false;
                }
            }

            onAccepted: {
                if (projectDescription.text.length > 0) {
                    projectDescription.focus = true;
                } else {
                    errorHighlight = true;
                }
            }
        }

        Label {
            id: projectDescriptionLabel
            text: qsTr("Description:")
            anchors {
                top: projectName.bottom
                right: parent.right
                left: parent.left
                margins: 8
            }
        }

        TextArea {
            id: projectDescription
            anchors {
                top: projectDescriptionLabel.bottom
                right: parent.right
                left: parent.left
                margins: 8
            }
        }
    }
}
