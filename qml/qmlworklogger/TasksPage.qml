import QtQuick 1.1
import com.nokia.meego 1.1
import com.nokia.extras 1.1

Page {
    tools: backOnlyTools

    Label { text: qsTr("Log Page"); }

    Text {
        id: txtOrientation
        anchors.centerIn: parent
        text: "Tasks page"
        font.pointSize: 36
    }
}
