---
name: notify
description: Use to send notifications to my phone or computer about an event, update, or state change.
---

To send a notification to my devices about something, use the `ntfy` API with the `joshmock-pi-agent-events` topic name.

```bash
curl \
  -H "Authorization: Bearer $(pass agents/ntfy/pi)" \
  -d "Something happened" \
  https://ntfy.sh/joshmock-pi-agent-events
```

You can also set metadata like title, tags (mapped to emoji names), priority, and a clickable URL:

```bash
curl \
  -H "Authorization: Bearer $(pass agents/ntfy/pi)" \
  -H "Title: Unauthorized access detected" \
  -H "Priority: urgent" \
  -H "Tags: warning,skull" \
  -H "Click: https://example.com/fix-it" \
  -d "Remote access to josh-laptop detected." \
  ntfy.sh/joshmock-pi-agent-events
```

Priority levels, in order of descending priority, are:

- `urgent`
- `high`
- `default`
- `low`
- `min`

Basic markdown formatting is supported:

```bash
curl \
  -H "Authorization: Bearer $(pass agents/ntfy/pi)" \
  -d "**Something** happened" \
  https://ntfy.sh/joshmock-pi-agent-events
```

Scheduled notifications are also supported:

```bash
curl \
  -H "Authorization: Bearer $(pass agents/ntfy/pi)" \
  -H "Delay: 3h"
  -d "Something happened" \
  https://ntfy.sh/joshmock-pi-agent-events
```

Supported delay time strings include:

- Unix timestamp: `1639194738`
- duration: `30m`, `3h`, `2 days`
- natural language time string: `10am`, `8:30pm`, `tomorrow`, `3pm`, `Tuesday`, `7am`
