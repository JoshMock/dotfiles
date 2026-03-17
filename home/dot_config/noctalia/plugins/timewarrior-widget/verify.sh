#!/usr/bin/env bash
# TimeWarrior Widget Plugin - Installation Verification Script

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  TimeWarrior Widget Plugin - Verification"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

PLUGIN_DIR="$HOME/.config/noctalia/plugins/timewarrior-widget"
CHEZMOI_SOURCE="$HOME/.local/share/chezmoi/home/dot_config/noctalia/plugins/timewarrior-widget"

# Check 1: Chezmoi source files
echo "1. Checking chezmoi source files..."
if [ -d "$CHEZMOI_SOURCE" ]; then
    echo -e "${GREEN}✓${NC} Found plugin in chezmoi source"
    echo "  Location: $CHEZMOI_SOURCE"
    
    # Count files
    file_count=$(find "$CHEZMOI_SOURCE" -type f | wc -l)
    echo "  Files: $file_count"
    
    # Check required files
    for file in manifest.json BarWidget.qml Settings.qml README.md; do
        if [ -f "$CHEZMOI_SOURCE/$file" ]; then
            echo -e "  ${GREEN}✓${NC} $file"
        else
            echo -e "  ${RED}✗${NC} $file (missing)"
        fi
    done
else
    echo -e "${RED}✗${NC} Plugin not found in chezmoi source"
    echo "  Expected: $CHEZMOI_SOURCE"
fi
echo ""

# Check 2: Installed plugin
echo "2. Checking installed plugin..."
if [ -d "$PLUGIN_DIR" ]; then
    echo -e "${GREEN}✓${NC} Plugin installed"
    echo "  Location: $PLUGIN_DIR"
    
    # Validate manifest
    if [ -f "$PLUGIN_DIR/manifest.json" ]; then
        echo -e "  ${GREEN}✓${NC} manifest.json found"
        
        # Check if valid JSON
        if jq empty "$PLUGIN_DIR/manifest.json" 2>/dev/null; then
            echo -e "  ${GREEN}✓${NC} manifest.json is valid JSON"
            
            # Show key details
            plugin_id=$(jq -r '.id' "$PLUGIN_DIR/manifest.json")
            plugin_name=$(jq -r '.name' "$PLUGIN_DIR/manifest.json")
            plugin_version=$(jq -r '.version' "$PLUGIN_DIR/manifest.json")
            
            echo "  Plugin ID: $plugin_id"
            echo "  Name: $plugin_name"
            echo "  Version: $plugin_version"
        else
            echo -e "  ${RED}✗${NC} manifest.json is invalid JSON"
        fi
    else
        echo -e "  ${RED}✗${NC} manifest.json missing"
    fi
else
    echo -e "${YELLOW}!${NC} Plugin not installed yet"
    echo "  Run: chezmoi apply"
    echo "  Expected location: $PLUGIN_DIR"
fi
echo ""

# Check 3: TimeWarrior
echo "3. Checking TimeWarrior..."
if command -v timew &> /dev/null; then
    echo -e "${GREEN}✓${NC} TimeWarrior installed"
    timew_version=$(timew --version 2>&1 | head -1)
    echo "  Version: $timew_version"
    
    # Test timew command
    if timew 2>&1 | grep -q "Tracking\|There is no active"; then
        echo -e "  ${GREEN}✓${NC} timew command works"
    else
        echo -e "  ${YELLOW}!${NC} timew output unexpected"
    fi
    
    # Test summary command
    if timew summary :week &> /dev/null; then
        echo -e "  ${GREEN}✓${NC} timew summary :week works"
    else
        echo -e "  ${YELLOW}!${NC} timew summary :week failed"
    fi
else
    echo -e "${RED}✗${NC} TimeWarrior not installed"
    echo "  Install with:"
    echo "    sudo pacman -S timew  # Arch"
    echo "    sudo apt install timewarrior  # Debian/Ubuntu"
fi
echo ""

# Check 4: Noctalia
echo "4. Checking Noctalia..."
if pgrep -x quickshell > /dev/null; then
    echo -e "${GREEN}✓${NC} Noctalia (quickshell) is running"
else
    echo -e "${YELLOW}!${NC} Noctalia is not running"
    echo "  Start with: quickshell &"
fi

if [ -f "$HOME/.config/noctalia/settings.json" ]; then
    echo -e "${GREEN}✓${NC} Noctalia settings found"
else
    echo -e "${YELLOW}!${NC} Noctalia settings not found"
fi
echo ""

# Summary
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Summary:"
echo ""

all_good=true

if [ ! -d "$CHEZMOI_SOURCE" ]; then
    echo -e "${RED}✗${NC} Plugin not in chezmoi source"
    all_good=false
fi

if [ ! -d "$PLUGIN_DIR" ]; then
    echo -e "${YELLOW}!${NC} Plugin not installed - run: chezmoi apply"
    all_good=false
fi

if ! command -v timew &> /dev/null; then
    echo -e "${RED}✗${NC} TimeWarrior not installed"
    all_good=false
fi

if $all_good; then
    echo -e "${GREEN}✓ All checks passed!${NC}"
    echo ""
    echo "Next steps:"
    if [ ! -d "$PLUGIN_DIR" ]; then
        echo "1. Run: chezmoi apply"
    fi
    echo "1. Open Noctalia Settings (Super+,)"
    echo "2. Go to Plugins section"
    echo "3. Enable 'TimeWarrior Widget'"
    echo "4. Configure settings if desired"
    echo "5. Start tracking: timew start <task>"
else
    echo ""
    echo "Please resolve the issues above before proceeding."
fi
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
