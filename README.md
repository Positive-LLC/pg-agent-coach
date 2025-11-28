# pg-agent-coach

A Claude Code tool that captures and shares "agentic mindset" knowledge from your sessions to Slack.

## What is this?

When you work with Claude Code, sometimes brilliant collaboration moments happen - intensive discussions where both you and Claude refine ideas through back-and-forth dialogue. These "wow moments" demonstrate the art of human-AI collaboration that's hard to teach but valuable to share.

**pg-agent-coach** automatically detects these moments and shares the insights with your team on Slack.

## How it works

```
┌─────────────────────────────────────────────────────────────┐
│  Your Claude Code Session                                   │
│                                                             │
│  wow-moment skill (monitors 24/7)                           │
│         │                                                   │
│         ▼ (detects intensive collaboration)                 │
│  /show-ropes command                                        │
│         │                                                   │
│         ▼ (extracts insights)                               │
│  knowledge-extractor agent                                  │
│         │                                                   │
│         ▼                                                   │
│  Slack message with shareable insight                       │
└─────────────────────────────────────────────────────────────┘
```

## Installation

```bash
curl -fsSL https://raw.githubusercontent.com/Positive-LLC/pg-agent-coach/main/install.sh | bash
```

During installation, you'll be prompted to enter your Slack webhook URL (required).

This installs three components to your `~/.claude` directory:
- `agents/knowledge-extractor.md` - Extracts and formats insights
- `commands/show-ropes.md` - The `/show-ropes` slash command
- `skills/wow-moment/SKILL.md` - Monitors for wow moments

## Usage

### Automatic (recommended)

Just use Claude Code as normal. The **wow-moment** skill monitors your sessions and automatically triggers when it detects:

- Intensive back-and-forth discussions (4+ exchanges on same topic)
- Productive disagreements that lead to better solutions
- Breakthrough moments after sustained engagement
- Meta-collaboration (discussing *how* to approach problems)

### Manual

Run `/show-ropes` in any Claude Code session to manually extract and share insights.

```
/show-ropes
```

Or with a focus:

```
/show-ropes the discussion about error handling
```

## What gets shared

Insights are posted to Slack in this format:

```
*Agentic Insight*

*The Technique:* "Asking Claude to argue against its own solution"

*What Happened:*
• User received a working solution but asked "What would you change if you were reviewing this critically?"
• Claude identified 3 improvements it hadn't initially suggested
• User picked one, leading to a more elegant final solution

*The Takeaway:*
Don't accept the first working answer. Ask Claude to critique its own work - it often knows improvements it didn't volunteer initially.
```

## Configuration

### Slack Webhook

Your Slack webhook URL is configured during installation. To update it later, edit `~/.claude/agents/knowledge-extractor.md` and replace the webhook URL.

## Components

| Component | Purpose |
|-----------|---------|
| `wow-moment` skill | Monitors sessions for valuable collaboration patterns |
| `/show-ropes` command | Triggers knowledge extraction (manual or automatic) |
| `knowledge-extractor` agent | Analyzes sessions and posts insights to Slack |

## Philosophy

This tool is about **"showing the ropes"** - capturing the tacit knowledge of effective AI collaboration. It focuses on:

- **The mindset**, not the code
- **The technique**, not the project details
- **Reusable patterns** anyone can apply

## License

MIT
