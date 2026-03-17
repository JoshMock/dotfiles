# TimeWarrior Widget Plugin for Noctalia

A Noctalia plugin that displays your TimeWarrior tracking status and weekly summary directly in your bar.

## Features

- **Live Tracking Status**: Shows currently tracked task and elapsed time
- **Weekly Summary**: Displays total time tracked this week
- **Visual Indicator**: Pulsing dot when actively tracking
- **Auto-refresh**: Configurable update interval (default: 60 seconds)
- **Click Action**: Opens full weekly summary in terminal
- **Fully Configurable**: Customize all settings through Noctalia Settings UI

## What It Looks Like

```
┌──────────────────────────────────────┐
│ ● dev environment • 1:23:45          │
│   Week: 8:09:50                      │
└──────────────────────────────────────┘
```

- **Green pulsing dot** = Currently tracking
- **First line** = Current task and duration
- **Second line** = Total time this week
- **Click** = Opens full summary in terminal

## Requirements

- Noctalia Shell >= 3.6.0
- TimeWarrior installed and configured

### Install TimeWarrior

```bash
# Arch Linux
sudo pacman -S timew

# Debian/Ubuntu
sudo apt install timewarrior

# Fedora
sudo dnf install timew

# macOS
brew install timewarrior
```

Verify installation:
```bash
timew --version
```

## Installation

### Method 1: Manual Installation

1. Create the plugin directory:
   ```bash
   mkdir -p ~/.config/noctalia/plugins/timewarrior-widget
   ```

2. Copy all plugin files to the directory:
   ```bash
   cp -r timewarrior-widget/* ~/.config/noctalia/plugins/timewarrior-widget/
   ```

3. Open Noctalia Settings → Plugins

4. Find "TimeWarrior Widget" and click **Enable**

5. The widget will appear in your bar automatically

### Method 2: Via Chezmoi (if managing dotfiles)

If you're using chezmoi to manage your dotfiles:

```bash
# The plugin is already in your chezmoi dotfiles at:
# ~/.local/share/chezmoi/home/dot_config/noctalia/plugins/timewarrior-widget/

# Apply chezmoi to install
chezmoi apply

# Enable in Noctalia Settings → Plugins
```

## Configuration

### Through Noctalia UI

1. Open **Settings** (usually `Super+,`)
2. Navigate to **Plugins** section
3. Find **TimeWarrior Widget**
4. Click the **Settings** (gear) icon

### Available Settings

**Update Interval**
- How often to refresh TimeWarrior data
- Range: 5-300 seconds
- Default: 60 seconds (1 minute)
- Tip: Lower values = more responsive but higher CPU usage

**Show Weekly Total**
- Toggle display of weekly total time
- Default: Enabled
- Tip: Disable to make widget more compact

**Click Action**
- **Open terminal**: Runs a command when clicked
- **None**: No action on click

**Terminal Command** (if click action is "Open terminal")
- Command to execute when widget is clicked
- Default: `alacritty -e timew summary :week`
- Common alternatives:
  - `kitty timew summary :month`
  - `foot timew summary :day`
  - `gnome-terminal -- timew summary :week`

## Usage

### Start Tracking

```bash
# Start tracking a task
timew start dev environment

# Start with multiple tags
timew start meeting client projectname
```

### Stop Tracking

```bash
# Stop current task
timew stop

# Stop and immediately start a new task
timew stop meeting
timew start coding
```

### View Summary

```bash
# Week summary (what the widget shows)
timew summary :week

# Today summary
timew summary :day

# Month summary
timew summary :month
```

## Customization

### Widget Appearance

The widget uses Noctalia's design system and will automatically match your theme:

- **Colors**: Adapts to your current theme
- **Size**: Scales with your bar density setting
- **Style**: Follows Noctalia's design language

### Manual Theme Adjustment

If you want to customize colors, edit `BarWidget.qml`:

```qml
// Change background color
color: Color.mSurfaceVariant

// Change border color
border.color: Color.mOutline

// Change tracking indicator color
color: root.isTracking ? Color.mPrimary : Color.mSecondary

// Change text colors
color: Color.mOnSurface  // Main text
color: Color.mOnSurfaceVariant  // Secondary text
```

## Troubleshooting

### Widget shows "Loading..." forever

**Cause**: TimeWarrior is not installed or not in PATH

**Solution**:
```bash
# Check if timew is installed
which timew

# If not found, install it
sudo pacman -S timew  # Arch
sudo apt install timewarrior  # Debian/Ubuntu
```

### Widget shows "Not tracking" but I am tracking

**Cause**: TimeWarrior not returning expected output

**Solution**:
```bash
# Test timew output
timew

# Should show something like:
# Tracking taskname
#   Started 2026-02-03T09:00:00
#   Current            10:49:54
#   Total               1:49:54
```

### Weekly total shows "0:00:00" but I've tracked time

**Cause**: No time tracked this week, or data parsing issue

**Solution**:
```bash
# Check weekly summary manually
timew summary :week

# Verify you have data
timew summary
```

### Click action doesn't work

**Cause**: Terminal command is incorrect or terminal not installed

**Solution**:
1. Check your terminal is installed:
   ```bash
   which alacritty  # or kitty, foot, etc.
   ```

2. Test the command manually:
   ```bash
   alacritty -e timew summary :week
   ```

3. Update the terminal command in settings if needed

### Plugin doesn't appear after enabling

**Cause**: Plugin not loaded properly

**Solution**:
1. Restart Noctalia Shell:
   ```bash
   pkill quickshell
   quickshell &
   ```

2. Check plugin files are in the correct location:
   ```bash
   ls -la ~/.config/noctalia/plugins/timewarrior-widget/
   ```

3. Verify `manifest.json` is valid:
   ```bash
   cat ~/.config/noctalia/plugins/timewarrior-widget/manifest.json
   ```

## Development

### Plugin Structure

```
timewarrior-widget/
├── manifest.json      # Plugin metadata
├── BarWidget.qml      # Main bar widget
├── Settings.qml       # Settings UI
├── preview.png        # Plugin preview image
└── README.md          # This file
```

### Extending the Plugin

Want to add more features? Here are some ideas:

**Add a Desktop Widget**
- Create `DesktopWidget.qml`
- Show detailed daily breakdown
- Add to manifest.json entryPoints

**Add a Panel**
- Create `Panel.qml`
- Show full statistics and graphs
- Add charts using quickshell components

**Add IPC Commands**
- Create `Main.qml`
- Add IPC handlers for start/stop tracking
- Bind to keyboard shortcuts

**Add Translations**
- Create `i18n/en.json` and other languages
- Use `pluginApi.tr()` in QML files

## Contributing

Found a bug or have a feature request?

1. Check existing issues: https://github.com/noctalia-dev/noctalia-plugins/issues
2. Create a new issue with:
   - Description of the problem/feature
   - Steps to reproduce (for bugs)
   - Your Noctalia version
   - Your TimeWarrior version

Pull requests welcome!

## License

MIT License - see LICENSE file for details

## Credits

- **TimeWarrior**: https://timewarrior.net/
- **Noctalia Shell**: https://noctalia.dev/
- **Plugin System**: https://docs.noctalia.dev/development/plugins/

## Support

- **Noctalia Discord**: https://discord.noctalia.dev
- **Noctalia Docs**: https://docs.noctalia.dev
- **TimeWarrior Docs**: https://timewarrior.net/docs/

---

**Enjoy tracking your time!** ⏱️
