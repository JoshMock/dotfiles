import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import qs.Commons

// ponytail: no settings panel, no animations — just a visibility toggle
Item {
  id: root

  property var pluginApi: null
  property var screen
  property real scaling: 1.0

  property string activeSubmap: ""

  // Only take up space when visible
  implicitHeight: bubble.visible ? bubble.implicitHeight : 0
  implicitWidth: bubble.visible ? bubble.implicitWidth : 0

  Connections {
    target: Hyprland
    function onRawEvent(event) {
      if (event.name === "submap") {
        root.activeSubmap = event.data.trim()
      }
    }
  }

  Rectangle {
    id: bubble
    visible: root.activeSubmap !== "" && root.activeSubmap !== "reset"

    implicitHeight: Math.round(Style.capsuleHeight * scaling * 0.75)
    implicitWidth: label.implicitWidth + Math.round(16 * scaling)
    height: implicitHeight
    width: implicitWidth

    radius: height / 2
    color: "#cc2222"

    NText {
      id: label
      anchors.centerIn: parent
      text: root.activeSubmap.toUpperCase()
      pointSize: Style.fontSizeXS * scaling
      font.weight: Style.fontWeightBold
      color: "#ffffff"
    }
  }
}
