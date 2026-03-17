# TimeWarrior Widget - Quick Installation Guide

## For Users

### Step 1: Install TimeWarrior

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

### Step 2: Install the Plugin

Since you're using **chezmoi**, the plugin is already in your dotfiles!

```bash
# Apply your dotfiles
chezmoi apply

# This will copy the plugin to:
# ~/.config/noctalia/plugins/timewarrior-widget/
```

### Step 3: Enable the Plugin

1. Open **Noctalia Settings** (usually `Super+,`)
2. Go to **Plugins** section
3. Find **TimeWarrior Widget**
4. Click **Enable**
5. The widget appears in your bar automatically!

### Step 4: Configure (Optional)

1. In Plugins section, click the **Settings** (gear) icon next to TimeWarrior Widget
2. Adjust:
   - Update interval (how often to refresh)
   - Show/hide weekly total
   - Click action and terminal command

## Verification

Check the plugin was installed correctly:

```bash
# Plugin directory should exist
ls -la ~/.config/noctalia/plugins/timewarrior-widget/

# Should contain:
# - manifest.json
# - BarWidget.qml
# - Settings.qml
# - README.md
```

Test TimeWarrior:

```bash
# Start tracking
timew start testing

# Check status (widget reads this)
timew

# Stop tracking
timew stop

# View summary (click action shows this)
timew summary :week
```

## What You'll See

After enabling, you'll see in your bar:

- **When tracking**: `● task-name • 0:12:34  Week: 8:09:50`
- **When not tracking**: `● Not tracking  Week: 8:09:50`

The dot pulses green when actively tracking.

## Troubleshooting

**Widget not showing up?**
- Restart Noctalia: `pkill quickshell && quickshell &`
- Check plugin is enabled in Settings → Plugins

**Shows "Loading..." forever?**
- Make sure `timew` command works in terminal
- Check: `which timew`

**Can't click to open summary?**
- Update terminal command in plugin settings
- Default assumes `alacritty` is installed

## Usage

### Basic TimeWarrior Commands

```bash
# Start tracking
timew start <task-name> [tags...]

# Stop tracking
timew stop

# Summary
timew summary :day
timew summary :week
timew summary :month

# Continue last task
timew continue

# Cancel last interval
timew cancel
```

### Examples

```bash
# Start tracking development work
timew start dev environment

# Start meeting with tags
timew start meeting client project-alpha

# Switch tasks (stop current, start new)
timew stop
timew start coding feature-xyz

# View what you're currently tracking
timew
```

## Next Steps

- Configure widget settings to your preference
- Set up TimeWarrior with your tasks and tags
- Optionally bind TimeWarrior commands to keyboard shortcuts via Noctalia

## More Info

- Full documentation: `~/.config/noctalia/plugins/timewarrior-widget/README.md`
- TimeWarrior docs: https://timewarrior.net/docs/
- Noctalia plugin docs: https://docs.noctalia.dev/development/plugins/

---

**Happy time tracking!** ⏱️
