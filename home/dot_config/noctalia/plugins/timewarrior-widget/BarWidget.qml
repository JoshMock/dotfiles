import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import qs.Commons
import qs.Services.UI
import qs.Widgets

Rectangle {
  id: root

  // Plugin API injected by PluginService
  property var pluginApi: null

  // Screen and scaling provided by Noctalia
  property var screen
  property real scaling: 1.0

  // TimeWarrior data
  property string currentTags: "Loading..."
  property string dayTotal: ""
  property string weekTotal: ""
  property bool isTracking: false

  // Widget settings from pluginApi
  property int updateInterval: (pluginApi && pluginApi.pluginSettings && pluginApi.pluginSettings.updateInterval !== undefined) ? pluginApi.pluginSettings.updateInterval : 60000
  property bool showDayTotal: (pluginApi && pluginApi.pluginSettings && pluginApi.pluginSettings.showDayTotal !== undefined) ? pluginApi.pluginSettings.showDayTotal : true
  property bool showWeekTotal: (pluginApi && pluginApi.pluginSettings && pluginApi.pluginSettings.showWeekTotal !== undefined) ? pluginApi.pluginSettings.showWeekTotal : true
  property string clickAction: (pluginApi && pluginApi.pluginSettings && pluginApi.pluginSettings.clickAction !== undefined) ? pluginApi.pluginSettings.clickAction : "terminal"
  property string terminalCommand: (pluginApi && pluginApi.pluginSettings && pluginApi.pluginSettings.terminalCommand !== undefined) ? pluginApi.pluginSettings.terminalCommand : "kitty --hold -e timew summary :week"

  implicitHeight: Math.round(Style.capsuleHeight * scaling)
  implicitWidth: {
    var baseWidth = contentText.implicitWidth + (16 + 8) * scaling // dot + margins
    var maxWidth = 400 * scaling
    return Math.min(Math.max(baseWidth, 180 * scaling), maxWidth)
  }
  radius: Math.round(Style.radiusS * scaling)
  color: Color.mSurfaceVariant
  border.width: Math.max(1, Math.round(Style.borderS * scaling))
  border.color: Color.mOutline

  // Ensure widget is visible
  opacity: 1.0
  visible: true

  // Process to get current tracking status and tags
  Process {
    id: timewCurrent
    command: ["sh", "-c", "timew export 2>&1 | jq -r '[.[] | select(has(\"end\") | not)] | if length > 0 then .[0].tags | join(\", \") else \"\" end' 2>/dev/null || echo ''"]
    running: true

    property string buffer: ""

    stdout: SplitParser {
      onRead: function(data) {
        timewCurrent.buffer += data
      }
    }

    onExited: {
      var tags = timewCurrent.buffer.trim()
      timewCurrent.buffer = ""

      if (tags && tags !== "" && tags !== "null") {
        root.isTracking = true
        root.currentTags = tags
      } else {
        root.isTracking = false
        root.currentTags = "Not tracking"
      }
    }
  }

  // Process to get daily summary total
  Process {
    id: timewDay
    command: ["sh", "-c", "timew summary :day 2>&1 | grep -oE '[0-9]+:[0-9]+:[0-9]+' | tail -1"]
    running: true

    property string buffer: ""

    stdout: SplitParser {
      onRead: function(data) {
        timewDay.buffer += data
      }
    }

    onExited: {
      var total = timewDay.buffer.trim()
      timewDay.buffer = ""

      if (total.match(/^\d+:\d+:\d+$/)) {
        root.dayTotal = total
      } else if (root.dayTotal === "") {
        root.dayTotal = "0:00:00"
      }
    }
  }

  // Process to get weekly summary total
  Process {
    id: timewWeek
    command: ["sh", "-c", "timew summary :week 2>&1 | grep -oE '[0-9]+:[0-9]+:[0-9]+' | tail -1"]
    running: true

    property string buffer: ""

    stdout: SplitParser {
      onRead: function(data) {
        timewWeek.buffer += data
      }
    }

    onExited: {
      var total = timewWeek.buffer.trim()
      timewWeek.buffer = ""

      if (total.match(/^\d+:\d+:\d+$/)) {
        root.weekTotal = total
      } else if (root.weekTotal === "") {
        root.weekTotal = "0:00:00"
      }
    }
  }

  // Process for click action (created when needed)
  Process {
    id: clickProcess
    property string pendingCommand: ""
    command: ["sh", "-c", pendingCommand]
    running: false

    function executeCommand(cmd) {
      pendingCommand = cmd + " &"
      running = true
    }
  }

  // Refresh timer
  Timer {
    interval: root.updateInterval
    running: true
    repeat: true
    onTriggered: {
      timewCurrent.running = false
      timewDay.running = false
      timewWeek.running = false
      Qt.callLater(function() {
        timewCurrent.running = true
        timewDay.running = true
        timewWeek.running = true
      })
    }
  }

  RowLayout {
    anchors.fill: parent
    anchors.margins: Style.marginXS * scaling
    spacing: Style.marginS * scaling

    // Status indicator dot
    Rectangle {
      width: Math.round(8 * scaling)
      height: Math.round(8 * scaling)
      radius: width / 2
      color: root.isTracking ? Color.mPrimary : Color.mSecondary
      Layout.alignment: Qt.AlignVCenter

      // Pulse animation when tracking
      SequentialAnimation on opacity {
        running: root.isTracking
        loops: Animation.Infinite
        NumberAnimation { to: 0.3; duration: 1000 }
        NumberAnimation { to: 1.0; duration: 1000 }
      }
    }

    // Single line text with all info
    NText {
      id: contentText
      text: {
        var parts = []
        
        // Current tags (always show) - bold
        if (root.isTracking) {
          parts.push("<b>" + root.currentTags + "</b>")
        } else {
          parts.push("Not tracking")
        }
        
        // Add day total if enabled - "Day" bold, time not bold
        if (root.showDayTotal && root.dayTotal) {
          parts.push("<b>Day:</b> " + root.dayTotal)
        }
        
        // Add week total if enabled - "Week" bold, time not bold
        if (root.showWeekTotal && root.weekTotal) {
          parts.push("<b>Week:</b> " + root.weekTotal)
        }
        
        return parts.join(" • ")
      }
      pointSize: Style.fontSizeXS * scaling
      font.weight: Style.fontWeightNormal
      color: Color.mOnSurface
      elide: Text.ElideRight
      textFormat: Text.RichText
      Layout.fillWidth: true
      Layout.alignment: Qt.AlignVCenter
    }
  }

  // Mouse interaction with tooltip
  MouseArea {
    anchors.fill: parent
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor

    onClicked: {
      if (root.clickAction === "terminal" && root.terminalCommand) {
        clickProcess.executeCommand(root.terminalCommand)
      }
    }

    onEntered: {
      root.opacity = 0.9
      var tooltipText = root.isTracking
        ? "Currently tracking: " + root.currentTags + "\nDaily total: " + root.dayTotal + "\nWeekly total: " + root.weekTotal
        : "Not tracking\nDaily total: " + root.dayTotal + "\nWeekly total: " + root.weekTotal
      TooltipService.show(tooltipText, this)
    }

    onExited: {
      root.opacity = 1.0
      TooltipService.hide()
    }
  }
}
