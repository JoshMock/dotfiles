# Changelog

All notable changes to the TimeWarrior Widget plugin will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-02-03

### Added
- Initial release as a Noctalia plugin
- Bar widget showing current tracking status and weekly total
- Settings UI for configuration
- Live tracking status with pulsing indicator
- Weekly time summary display
- Configurable update interval (5-300 seconds)
- Toggle for showing/hiding weekly total
- Click action to open terminal with detailed summary
- Customizable terminal command
- Automatic refresh timer
- Tooltip with detailed information
- Theme-aware styling using Noctalia design system
- Complete documentation (README, INSTALL, SUMMARY)

### Features
- **Live Status**: Real-time display of current task and duration
- **Weekly Summary**: Shows cumulative time for the week
- **Visual Feedback**: Green pulsing dot when actively tracking
- **Auto-Refresh**: Configurable update interval
- **Click Action**: Opens full weekly summary in terminal
- **Settings Integration**: Full Noctalia Settings UI integration
- **Theme Support**: Automatically matches your Noctalia theme

### Technical
- Uses Quickshell Process for command execution
- Implements proper plugin API (pluginApi)
- Follows Noctalia plugin manifest specification
- Uses Noctalia design system components (NText, NButton, NSwitch, etc.)
- Persistent settings through pluginApi.saveSettings()
- Proper error handling for missing TimeWarrior installation

### Documentation
- Complete README with features, installation, usage
- Quick start INSTALL guide for chezmoi users
- Comprehensive SUMMARY document
- Troubleshooting section
- Configuration examples
- Development notes for extending the plugin

## [Unreleased]

### Planned Features (Future Versions)
- Desktop widget with detailed daily breakdown
- Panel with charts and statistics
- IPC commands for start/stop tracking via keybinds
- Support for multiple language translations
- More granular time displays (today, month, year)
- Task tag display in widget
- Quick action buttons in tooltip
- Color coding by task/project
- Export functionality
- Integration with other time tracking services

## Version History

### Version Number Scheme

- **MAJOR**: Incompatible API changes or major feature overhauls
- **MINOR**: New features in a backwards-compatible manner
- **PATCH**: Backwards-compatible bug fixes

### Release Notes

**v1.0.0** - Initial stable release
- First public release as a Noctalia plugin
- Full feature set for basic time tracking display
- Complete documentation and installation guide
- Tested with Noctalia >= 3.6.0 and TimeWarrior 1.9.1

---

## Upgrade Guide

### From Pre-Plugin Version

If you used the earlier bar widget integration (before it became a plugin):

1. **Backup old settings** (if any manual modifications)
2. **Remove old widget** from BarWidgetRegistry (if manually integrated)
3. **Install plugin** via chezmoi apply
4. **Enable in Settings** → Plugins → TimeWarrior Widget
5. **Reconfigure** your preferences in the Settings UI

The plugin provides the same functionality with better integration!

### Future Updates

To update the plugin:

```bash
# Update your chezmoi dotfiles
cd ~/.local/share/chezmoi
git pull  # or however you manage your dotfiles

# Apply updates
chezmoi apply

# Restart Noctalia to reload plugin
pkill quickshell
quickshell &
```

Settings will be preserved across updates.

---

## Contributing

Found a bug? Have a feature request?

1. Check if already reported in issues
2. Create a detailed issue with:
   - Plugin version (from manifest.json)
   - Noctalia version
   - TimeWarrior version
   - Steps to reproduce (for bugs)
   - Expected vs actual behavior

Pull requests welcome! Please update this CHANGELOG with your changes.

---

**Current Version**: 1.0.0  
**Last Updated**: 2026-02-03  
**Maintainer**: Your Name
