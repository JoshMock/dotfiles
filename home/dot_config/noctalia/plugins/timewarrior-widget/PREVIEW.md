# Preview Image

To add a preview image for the Noctalia plugin gallery:

1. Take a screenshot of the widget in action
2. Crop to approximately 800x600px
3. Save as one of:
   - preview.png (recommended)
   - preview.jpg
   - preview.jpeg
   - preview.webp

4. Place in this directory (timewarrior-widget/)

## Recommended Content

Show the widget in your bar with:
- Currently tracking a task
- The pulsing green indicator visible
- Weekly total displayed
- Perhaps include a small screenshot of the settings panel

## Example Screenshot Content

```
Bar with widget showing:
┌─────────────────────────────────────────────────────┐
│ [Other widgets] ● dev project • 1:23:45  Week: 8:09:50 [Other widgets] │
└─────────────────────────────────────────────────────┘
```

Or show the settings panel to demonstrate configurability.

## Tools for Screenshots

- **Wayland**: `grim` + `slurp` for region selection
  ```bash
  grim -g "$(slurp)" preview.png
  ```

- **Hyprland**: Built-in screenshot
  ```bash
  hyprctl dispatch exec "grim preview.png"
  ```

- **Niri**: Screenshot command
  ```bash
  niri msg action screenshot
  ```

Once you have a preview image, the plugin will display it in the Noctalia plugin gallery!
