import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as QQC
import qs.Commons
import qs.Widgets

ColumnLayout {
  id: root

  // Plugin API injected by PluginService
  property var pluginApi: null

  // Local state for settings
  property int updateIntervalValue: (pluginApi && pluginApi.pluginSettings && pluginApi.pluginSettings.updateInterval !== undefined) ? pluginApi.pluginSettings.updateInterval : 60000
  property bool showDayTotalValue: (pluginApi && pluginApi.pluginSettings && pluginApi.pluginSettings.showDayTotal !== undefined) ? pluginApi.pluginSettings.showDayTotal : true
  property bool showWeekTotalValue: (pluginApi && pluginApi.pluginSettings && pluginApi.pluginSettings.showWeekTotal !== undefined) ? pluginApi.pluginSettings.showWeekTotal : true
  property string clickActionValue: (pluginApi && pluginApi.pluginSettings && pluginApi.pluginSettings.clickAction !== undefined) ? pluginApi.pluginSettings.clickAction : "terminal"
  property string terminalCommandValue: (pluginApi && pluginApi.pluginSettings && pluginApi.pluginSettings.terminalCommand !== undefined) ? pluginApi.pluginSettings.terminalCommand : "alacritty -e timew summary :week"

  spacing: Style.marginL

  // Update Interval
  ColumnLayout {
    spacing: Style.marginXS
    Layout.fillWidth: true

    NText {
      text: "Update Interval"
      pointSize: Style.fontSizeL
      font.weight: Style.fontWeightBold
      color: Color.mOnSurface
    }

    NText {
      text: "How often to refresh TimeWarrior data (in seconds)"
      pointSize: Style.fontSizeS
      color: Color.mOnSurfaceVariant
      wrapMode: Text.WordWrap
      Layout.fillWidth: true
    }

    RowLayout {
      spacing: Style.marginM
      Layout.fillWidth: true

      QQC.SpinBox {
        id: intervalSpinBox
        from: 5
        to: 300
        stepSize: 5
        value: updateIntervalValue / 1000
        editable: true
        
        onValueChanged: {
          updateIntervalValue = value * 1000
        }
        
        Layout.preferredWidth: 150
      }

      NText {
        text: "seconds (" + (intervalSpinBox.value * 1000) + "ms)"
        pointSize: Style.fontSizeS
        color: Color.mOnSurfaceVariant
      }
    }
  }

  // Show Day Total
  RowLayout {
    spacing: Style.marginM
    Layout.fillWidth: true

    ColumnLayout {
      spacing: Style.marginXS
      Layout.fillWidth: true

      NText {
        text: "Show Daily Total"
        pointSize: Style.fontSizeL
        font.weight: Style.fontWeightBold
        color: Color.mOnSurface
      }

      NText {
        text: "Display total time tracked today"
        pointSize: Style.fontSizeS
        color: Color.mOnSurfaceVariant
        wrapMode: Text.WordWrap
        Layout.fillWidth: true
      }
    }

    NSwitch {
      checked: showDayTotalValue
      onCheckedChanged: showDayTotalValue = checked
      Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
    }
  }

  // Show Week Total
  RowLayout {
    spacing: Style.marginM
    Layout.fillWidth: true

    ColumnLayout {
      spacing: Style.marginXS
      Layout.fillWidth: true

      NText {
        text: "Show Weekly Total"
        pointSize: Style.fontSizeL
        font.weight: Style.fontWeightBold
        color: Color.mOnSurface
      }

      NText {
        text: "Display total time tracked this week"
        pointSize: Style.fontSizeS
        color: Color.mOnSurfaceVariant
        wrapMode: Text.WordWrap
        Layout.fillWidth: true
      }
    }

    NSwitch {
      checked: showWeekTotalValue
      onCheckedChanged: showWeekTotalValue = checked
      Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
    }
  }

  // Click Action
  ColumnLayout {
    spacing: Style.marginXS
    Layout.fillWidth: true

    NText {
      text: "Click Action"
      pointSize: Style.fontSizeL
      font.weight: Style.fontWeightBold
      color: Color.mOnSurface
    }

    NText {
      text: "What happens when you click the widget"
      pointSize: Style.fontSizeS
      color: Color.mOnSurfaceVariant
    }

    RowLayout {
      spacing: Style.marginM

      NRadioButton {
        text: "Open terminal"
        checked: clickActionValue === "terminal"
        onClicked: clickActionValue = "terminal"
      }

      NRadioButton {
        text: "None"
        checked: clickActionValue === "none"
        onClicked: clickActionValue = "none"
      }
    }
  }

  // Terminal Command
  ColumnLayout {
    visible: clickActionValue === "terminal"
    spacing: Style.marginXS
    Layout.fillWidth: true

    NText {
      text: "Terminal Command"
      pointSize: Style.fontSizeL
      font.weight: Style.fontWeightBold
      color: Color.mOnSurface
    }

    NText {
      text: "Command to run when clicking the widget"
      pointSize: Style.fontSizeS
      color: Color.mOnSurfaceVariant
    }

    NTextInput {
      id: commandField
      text: terminalCommandValue
      placeholderText: "e.g., alacritty -e timew summary :week"
      
      onTextChanged: terminalCommandValue = text
      
      Layout.fillWidth: true
    }

    // Command suggestions
    ColumnLayout {
      spacing: Style.marginXS
      Layout.fillWidth: true

      NText {
        text: "Common commands:"
        pointSize: Style.fontSizeS
        font.weight: Style.fontWeightBold
        color: Color.mOnSurfaceVariant
      }

      Repeater {
        model: [
          "alacritty -e timew summary :week",
          "kitty timew summary :month",
          "foot timew summary :day",
          "gnome-terminal -- timew summary :week"
        ]

        NButton {
          text: modelData
          type: "outlined"
          Layout.fillWidth: true
          onClicked: terminalCommandValue = modelData
        }
      }
    }
  }

  // Preview/Status
  Rectangle {
    Layout.fillWidth: true
    Layout.preferredHeight: 60
    radius: Style.radiusM
    color: Color.mSurfaceVariant
    border.width: 1
    border.color: Color.mOutline

    ColumnLayout {
      anchors.centerIn: parent
      spacing: Style.marginXS

      NText {
        text: "💡 Tip"
        pointSize: Style.fontSizeM
        font.weight: Style.fontWeightBold
        color: Color.mPrimary
        Layout.alignment: Qt.AlignHCenter
      }

      NText {
        text: "Make sure TimeWarrior (timew) is installed and configured"
        pointSize: Style.fontSizeS
        color: Color.mOnSurfaceVariant
        Layout.alignment: Qt.AlignHCenter
      }
    }
  }

  // Spacer
  Item {
    Layout.fillHeight: true
  }

  // Apply/Save happens automatically when this component is closed
  Component.onDestruction: {
    if (pluginApi && pluginApi.pluginSettings) {
      // Save settings
      pluginApi.pluginSettings.updateInterval = updateIntervalValue
      pluginApi.pluginSettings.showDayTotal = showDayTotalValue
      pluginApi.pluginSettings.showWeekTotal = showWeekTotalValue
      pluginApi.pluginSettings.clickAction = clickActionValue
      pluginApi.pluginSettings.terminalCommand = terminalCommandValue
      
      // Persist to disk
      if (pluginApi.saveSettings) {
        pluginApi.saveSettings()
      }
    }
  }
}
