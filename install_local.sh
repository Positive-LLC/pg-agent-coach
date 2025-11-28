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
mkdir -p ~/.claude/skills/wow-moment

# Copy agent and configure webhook URL
cp "$SCRIPT_DIR/agents/knowledge-extractor.md" ~/.claude/agents/
sed -i '' "s|SLACK_WEBHOOK_URL_PLACEHOLDER|$SLACK_WEBHOOK_URL|g" ~/.claude/agents/knowledge-extractor.md
echo "  Installed: ~/.claude/agents/knowledge-extractor.md"

# Copy command
cp "$SCRIPT_DIR/commands/show-ropes.md" ~/.claude/commands/
echo "  Installed: ~/.claude/commands/show-ropes.md"

# Copy skill
cp "$SCRIPT_DIR/skills/wow-moment/SKILL.md" ~/.claude/skills/wow-moment/
echo "  Installed: ~/.claude/skills/wow-moment/SKILL.md"

echo ""
echo "pg-agent-coach installed successfully!"
echo ""
echo "Usage:"
echo "  - Manual: Run /show-ropes in any Claude Code session"
echo "  - Auto: The wow-moment skill will detect insights automatically"
