import QtQuick 1.1
import com.nokia.meego 1.1

Item {
    property alias key: button.text
    property alias selectedIndex: singleSelectionDialog.selectedIndex
    property variant model: singleSelectionDialog.model

    height: button.height + 2 * button.anchors.margins

    Button {
        id: button
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
            margins: 8
        }
        onClicked: {
            singleSelectionDialog.open();
        }
    }

    SelectionDialog {
        id: singleSelectionDialog
        titleText: "Projects"
    }
}
