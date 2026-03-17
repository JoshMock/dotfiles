# TimeWarrior Widget Plugin - Summary

## What Was Created

A complete Noctalia plugin that displays TimeWarrior tracking status in your bar.

### Plugin Location

```
~/.local/share/chezmoi/home/dot_config/noctalia/plugins/timewarrior-widget/
```

After running `chezmoi apply`, it will be at:

```
~/.config/noctalia/plugins/timewarrior-widget/
```

### File Structure

```
timewarrior-widget/
├── manifest.json       # Plugin metadata and configuration
├── BarWidget.qml       # Main widget displayed in the bar
├── Settings.qml        # Settings UI component
├── README.md           # Complete documentation
├── INSTALL.md          # Quick installation guide
└── PREVIEW.md          # How to add a preview image
```

## Features

✅ **Live Status Display**
- Shows currently tracked task
- Displays elapsed time
- Pulsing green indicator when tracking

✅ **Weekly Summary**
- Shows total time tracked this week
- Toggleable in settings

✅ **Auto-Refresh**
- Configurable update interval (5-300 seconds)
- Default: 60 seconds

✅ **Click Action**
- Opens terminal with full weekly summary
- Customizable terminal command
- Can be disabled

✅ **Settings UI**
- Fully integrated with Noctalia Settings
- Easy configuration through GUI
- Persistent settings

✅ **Proper Plugin Architecture**
- Follows Noctalia plugin system
- Uses pluginApi for settings
- Proper manifest.json
- Theme-aware styling

## Installation

### Prerequisites

1. **Noctalia Shell** >= 3.6.0
2. **TimeWarrior** (timew)

```bash
# Install TimeWarrior
sudo pacman -S timew  # Arch
sudo apt install timewarrior  # Debian/Ubuntu
```

### Apply with Chezmoi

```bash
# The plugin is already in your chezmoi dotfiles!
chezmoi apply

# This installs it to ~/.config/noctalia/plugins/timewarrior-widget/
```

### Enable the Plugin

1. Open **Noctalia Settings** (`Super+,`)
2. Navigate to **Plugins**
3. Find **TimeWarrior Widget**
4. Click **Enable**
5. Widget appears in your bar automatically!

## Configuration

Access settings:
1. **Settings** → **Plugins** → **TimeWarrior Widget** → **Gear Icon**

Available options:
- **Update Interval**: 5-300 seconds (default: 60)
- **Show Weekly Total**: Yes/No (default: Yes)
- **Click Action**: Terminal or None
- **Terminal Command**: Custom command to run on click

## Usage

### Basic TimeWarrior Commands

```bash
# Start tracking
timew start dev environment

# Stop tracking
timew stop

# View status (what widget shows)
timew

# View summary (what click opens)
timew summary :week
```

### Widget Display

**When tracking:**
```
● dev environment • 1:23:45
  Week: 8:09:50
```

**When not tracking:**
```
● Not tracking
  Week: 8:09:50
```

## Customization

All customization is done through the Noctalia Settings UI. No manual file editing required!

**Advanced users** can edit the QML files directly for deeper customization:
- `BarWidget.qml` - Widget appearance and behavior
- `Settings.qml` - Settings UI layout

## Technical Details

### How It Works

1. **Data Collection**: Runs `timew` and `timew summary :week` commands
2. **Parsing**: Extracts task name, duration, and weekly total from output
3. **Display**: Shows in bar using Noctalia's design system components
4. **Refresh**: Timer triggers updates at configured interval
5. **Settings**: Uses pluginApi for persistent configuration

### Plugin API Usage

- `pluginApi.pluginSettings` - Access user settings
- `pluginApi.saveSettings()` - Persist settings to disk
- Uses Noctalia's design system (`qs.Commons`, `qs.Widgets`)
- Follows plugin manifest specification

### Dependencies

- **Runtime**: TimeWarrior (timew command)
- **Noctalia**: >= 3.6.0
- **QML Modules**: QtQuick, Quickshell, Quickshell.Io

## Differences from Initial Version

### Old Approach (Bar Widget)
- Required manual integration into BarWidgetRegistry
- Needed source code access
- Manual settings registration
- Complex installation

### New Approach (Plugin)
- ✅ Self-contained plugin
- ✅ Easy enable/disable through UI
- ✅ Automatic settings integration
- ✅ No source code access needed
- ✅ Proper plugin lifecycle
- ✅ Managed through Noctalia plugin system

## Troubleshooting

See `README.md` for detailed troubleshooting, including:
- Widget not appearing
- Shows "Loading..." forever  
- Weekly total shows 0:00:00
- Click action doesn't work
- Plugin not loading after enable

## Future Enhancements

Possible additions (not included, but easy to add):

1. **Desktop Widget** - Show detailed breakdown on desktop
2. **Panel** - Full statistics and graphs
3. **IPC Commands** - Start/stop tracking via keybinds
4. **Translations** - Multi-language support
5. **More Stats** - Today/month totals, charts
6. **Tags Display** - Show task tags
7. **Quick Actions** - Start/stop buttons in tooltip

## Documentation

- **INSTALL.md** - Quick start guide
- **README.md** - Complete documentation
- **PREVIEW.md** - How to add preview image
- **This file** - Project summary

## Support

- Noctalia Discord: https://discord.noctalia.dev
- Noctalia Docs: https://docs.noctalia.dev/development/plugins/
- TimeWarrior Docs: https://timewarrior.net/docs/

---

## Quick Reference

**Install**: `chezmoi apply`  
**Enable**: Settings → Plugins → TimeWarrior Widget → Enable  
**Configure**: Settings → Plugins → TimeWarrior Widget → ⚙️  
**Use**: `timew start <task>` to begin tracking  

**That's it!** Your time tracking is now in your bar. ⏱️
