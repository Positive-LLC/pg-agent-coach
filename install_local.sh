#!/bin/bash

# pg-agent-coach Local Installation Script
# This script installs the Claude Code components to your ~/.claude directory

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Installing pg-agent-coach..."
echo ""

# Prompt for Slack webhook URL (required)
echo "Slack webhook URL is required for posting insights to your team."
read -p "Enter your Slack webhook URL: " SLACK_WEBHOOK_URL

if [ -z "$SLACK_WEBHOOK_URL" ]; then
    echo "Error: Slack webhook URL is required. Installation aborted."
    exit 1
fi

echo ""

# Create directories if they don't exist
mkdir -p ~/.claude/agents
mkdir -p ~/.claude/commands
mkdir -p ~/.claude/hooks

# Copy agent and configure webhook URL
cp "$SCRIPT_DIR/agents/knowledge-extractor.md" ~/.claude/agents/
sed -i '' "s|SLACK_WEBHOOK_URL_PLACEHOLDER|$SLACK_WEBHOOK_URL|g" ~/.claude/agents/knowledge-extractor.md
echo "  Installed: ~/.claude/agents/knowledge-extractor.md"

# Copy command
cp "$SCRIPT_DIR/commands/show-ropes.md" ~/.claude/commands/
echo "  Installed: ~/.claude/commands/show-ropes.md"

# Copy hook and make executable
cp "$SCRIPT_DIR/hooks/wow-moment-reminder.sh" ~/.claude/hooks/
chmod +x ~/.claude/hooks/wow-moment-reminder.sh
echo "  Installed: ~/.claude/hooks/wow-moment-reminder.sh"

# Configure hooks in settings.json
SETTINGS_FILE=~/.claude/settings.json
HOOK_CMD="bash ~/.claude/hooks/wow-moment-reminder.sh"

if [ -f "$SETTINGS_FILE" ]; then
    # Check if jq is available
    if command -v jq &> /dev/null; then
        # Use jq to merge hooks config
        TEMP_SETTINGS=$(mktemp)
        jq --arg cmd "$HOOK_CMD" '
          .hooks.Stop //= [] |
          if (.hooks.Stop | map(select(.command == $cmd)) | length) == 0
          then .hooks.Stop += [{"command": $cmd}]
          else .
          end
        ' "$SETTINGS_FILE" > "$TEMP_SETTINGS"
        mv "$TEMP_SETTINGS" "$SETTINGS_FILE"
        echo "  Updated: ~/.claude/settings.json (hooks configured)"
    else
        echo "  Warning: jq not installed. Please manually add the hook to ~/.claude/settings.json"
        echo "  Add this to your settings.json:"
        echo '    "hooks": { "Stop": [{ "command": "bash ~/.claude/hooks/wow-moment-reminder.sh" }] }'
    fi
else
    # Create new settings.json
    cat > "$SETTINGS_FILE" << 'SETTINGS_EOF'
{
  "hooks": {
    "Stop": [
      {
        "command": "bash ~/.claude/hooks/wow-moment-reminder.sh"
      }
    ]
  }
}
SETTINGS_EOF
    echo "  Created: ~/.claude/settings.json"
fi

echo ""
echo "pg-agent-coach installed successfully!"
echo ""
echo "Usage:"
echo "  - Manual: Run /show-ropes in any Claude Code session"
echo "  - Auto: The hook will remind Claude to check for wow moments after each response"
