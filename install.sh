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
curl -fsSL "$REPO_URL/skills/wow-moment/SKILL.md" -o SKILL.md

# Create directories
mkdir -p ~/.claude/agents
mkdir -p ~/.claude/commands
mkdir -p ~/.claude/skills/wow-moment

# Install files and configure webhook URL
cp knowledge-extractor.md ~/.claude/agents/
sed -i '' "s|SLACK_WEBHOOK_URL_PLACEHOLDER|$SLACK_WEBHOOK_URL|g" ~/.claude/agents/knowledge-extractor.md
echo "  Installed: ~/.claude/agents/knowledge-extractor.md"

cp show-ropes.md ~/.claude/commands/
echo "  Installed: ~/.claude/commands/show-ropes.md"

cp SKILL.md ~/.claude/skills/wow-moment/
echo "  Installed: ~/.claude/skills/wow-moment/SKILL.md"

echo ""
echo "pg-agent-coach installed successfully!"
echo ""
echo "Usage:"
echo "  - Manual: Run /show-ropes in any Claude Code session"
echo "  - Auto: The wow-moment skill will detect insights automatically"
