import QtQuick 1.1
import com.nokia.meego 1.1
import com.nokia.extras 1.1
import 'components'
import 'delegates'

Page {
    tools: ToolBarLayout {
        ToolIcon {
            platformIconId: "toolbar-view-menu"
            anchors.right: (parent === undefined) ? undefined : parent.right
            onClicked: (myMenu.status === DialogStatus.Closed) ? myMenu.open() : myMenu.close()
        }
    }

    PageHeader {
        id: homePageHeader
        title: qsTr("Work logger")
        visible: !appWindow.pageStack.busy || !theme.inverted
    }

    ListModel {
        id: pagesModel

        ListElement {
            page: "ProjectsPage.qml"
            title: "Projects"
            subtitle: "Projects list"
        }
        ListElement {
            page: "TasksPage.qml"
            title: "Tasks"
            subtitle: "Tasks list"
        }
        ListElement {
            page: "LogPage.qml"
            title: "Quick start"
            subtitle: "Instantly starts logging"
        }
   }

    ListView {
        id: listView

        anchors {
            top: homePageHeader.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        model: pagesModel
        delegate: ListDelegateEx {
            title: model.title
            subTitle: model.subtitle
            onClicked: { switchToPage(model.page) }
        }
   }

    ScrollDecorator {
        flickableItem: listView
    }
}
