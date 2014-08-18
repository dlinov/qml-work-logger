import QtQuick 1.1
import com.nokia.meego 1.1

Item {
    property alias key: propertyLabel.text
    property alias value: propertyText.text
    property alias placeholder: propertyText.placeholderText
    property bool allowEmptyInput: false

    height: propertyLabel.height + propertyText.height + 2 * propertyLabel.anchors.margins + 2 * propertyText.anchors.margins

    Label {
        id: propertyLabel
        text: qsTr(key);
        anchors {
            top: parent.top
            right: parent.right
            left: parent.left
            margins: 8
        }
    }

    TextArea {
        id: propertyText
        anchors {
            top: propertyLabel.bottom
            right: parent.right
            left: parent.left
            margins: 8
        }

        onTextChanged: {
            if (errorHighlight) {
                errorHighlight = false;
            }
        }

        onFocusChanged: {
            errorHighlight = !allowEmptyInput && propertyText.text.length === 0;
        }
    }
}
