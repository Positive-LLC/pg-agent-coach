#!/bin/bash

# pg-agent-coach Remote Installation Script
# Install with: curl -fsSL https://raw.githubusercontent.com/Positive-LLC/pg-agent-coach/main/install.sh | bash

set -e

# GitHub raw content URL - UPDATE THIS WITH YOUR REPO
REPO_URL="https://raw.githubusercontent.com/Positive-LLC/pg-agent-coach/main"

echo "Installing pg-agent-coach from GitHub..."
echo ""

# Prompt for Slack webhook URL (required)
# Note: Using /dev/tty to read input when script is piped from curl
echo "Slack webhook URL is required for posting insights to your team."
read -p "Enter your Slack webhook URL: " SLACK_WEBHOOK_URL < /dev/tty

if [ -z "$SLACK_WEBHOOK_URL" ]; then
    echo "Error: Slack webhook URL is required. Installation aborted."
    exit 1
fi

echo ""

# Create temp directory
TEMP_DIR=$(mktemp -d)
trap "rm -rf $TEMP_DIR" EXIT

cd "$TEMP_DIR"

# Download files
echo "  Downloading components..."
curl -fsSL "$REPO_URL/agents/knowledge-extractor.md" -o knowledge-extractor.md
curl -fsSL "$REPO_URL/commands/show-ropes.md" -o show-ropes.md
curl -fsSL "$REPO_URL/hooks/wow-moment-reminder.sh" -o wow-moment-reminder.sh

# Create directories
mkdir -p ~/.claude/agents
mkdir -p ~/.claude/commands
mkdir -p ~/.claude/hooks

# Install files and configure webhook URL
cp knowledge-extractor.md ~/.claude/agents/
sed -i '' "s|SLACK_WEBHOOK_URL_PLACEHOLDER|$SLACK_WEBHOOK_URL|g" ~/.claude/agents/knowledge-extractor.md
echo "  Installed: ~/.claude/agents/knowledge-extractor.md"

cp show-ropes.md ~/.claude/commands/
echo "  Installed: ~/.claude/commands/show-ropes.md"

cp wow-moment-reminder.sh ~/.claude/hooks/
chmod +x ~/.claude/hooks/wow-moment-reminder.sh
echo "  Installed: ~/.claude/hooks/wow-moment-reminder.sh"

# Configure hooks in settings.json
SETTINGS_FILE=~/.claude/settings.json
HOOK_CMD="bash ~/.claude/hooks/wow-moment-reminder.sh"

if [ -f "$SETTINGS_FILE" ]; then
    # Existing settings.json - need jq to merge
    if ! command -v jq &> /dev/null; then
        echo "  jq not found, installing via Homebrew..."
        if command -v brew &> /dev/null; then
            brew install jq
        else
            echo ""
            echo "Error: jq is required to merge with existing settings.json"
            echo "Please install Homebrew (https://brew.sh) and run this script again,"
            echo "or manually add the hook config to ~/.claude/settings.json"
            exit 1
        fi
    fi
    # Use jq to merge hooks config with correct nested structure
    TEMP_SETTINGS=$(mktemp)
    jq --arg cmd "$HOOK_CMD" '
      .hooks.UserPromptSubmit //= [] |
      if (.hooks.UserPromptSubmit | map(select(.hooks[]?.command == $cmd)) | length) == 0
      then .hooks.UserPromptSubmit += [{"hooks": [{"type": "command", "command": $cmd}]}]
      else .
      end
    ' "$SETTINGS_FILE" > "$TEMP_SETTINGS"
    mv "$TEMP_SETTINGS" "$SETTINGS_FILE"
    echo "  Updated: ~/.claude/settings.json (hooks configured)"
else
    # No existing settings.json - create fresh (no jq needed)
    cat > "$SETTINGS_FILE" << 'SETTINGS_EOF'
{
  "hooks": {
    "UserPromptSubmit": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "bash ~/.claude/hooks/wow-moment-reminder.sh"
          }
        ]
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
