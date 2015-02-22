import QtQuick 1.1
import com.nokia.meego 1.1
import com.nokia.extras 1.1
import 'js/core.js' as Core

Sheet {
    acceptButtonText: "Save"
    rejectButtonText: "Cancel"
    property alias projectName: projectName.text
    property alias projectDescription: projectDescription.text
    property alias projectHourlyRate: projectHourlyRateInput.text

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
            id: projectHourlyRateLabel
            text: qsTr("Hourly rate:");
            anchors {
                top: projectName.bottom
                right: parent.right
                left: parent.left
                margins: 8
            }
        }

        TextField {
            id: projectHourlyRateInput
            anchors {
                top: projectHourlyRateLabel.bottom
                right: parent.right
                left: parent.left
                margins: 8
            }
            text: "0";
            validator: DoubleValidator {}
        }

        Button {
            id: currencyButton
            anchors {
                top: projectHourlyRateInput.bottom
                right: parent.right
                left: parent.left
                margins: 8
            }
            text: "..."
            onClicked: {
                currencyCombobox.open();
            }

            SelectionDialog {
                id: currencyCombobox
                titleText: "Select currency"
                model: ListModel {}
                onAccepted: {
                    currencyButton.text = currencyCombobox.model.get(currencyCombobox.selectedIndex).name
                }
                onModelChanged: { console.log('currency list refreshed'); }
            }
        }

        Label {
            id: projectDescriptionLabel
            text: qsTr("Description:")
            anchors {
                top: currencyButton.bottom
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

    function projectData() {
        currencyCombobox.model.clear();
        var dbData = Core.readCurrencies();
        for (var j = 0; j < dbData.length; j++) {
            currencyCombobox.model.append(dbData[j]);
        }
    }

    function getSelectedCurrency() {
        return currencyCombobox.model.get(currencyCombobox.selectedIndex);
    }
}
