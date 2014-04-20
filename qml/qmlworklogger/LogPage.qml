import QtQuick 1.1
import com.nokia.meego 1.1
import com.nokia.extras 1.1
import QtMobility.sensors 1.1

Page {
    tools: backOnlyTools

    Label { text: qsTr("Log Page"); }

    Text {
        id: txtOrientation
        anchors.centerIn: parent
        text: "Log Page"
        font.pointSize: 25
    }

    // TODO: remove or reuse
//    OrientationSensor {
//        id: oriData
//        active: true

//        onReadingChanged: {
//            txtOrientation.text = "Orientation: " + reading.orientation;
//        }
//    }
}
