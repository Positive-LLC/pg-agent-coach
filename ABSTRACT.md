# What is this project?
It's a project building "Claude Code Command/Skill/Agent" to be used by Claude Code in any project, that extracts the knowledge/philosophy of "Agentic Mindset" in the current session while him/her using Claude Code and delivers the knowledge to Slack, to be shared with the team.

# Why we need this project?
In the team, there are some experts really good at working with Claude Code. The knowledge of them is hidden in the interactions with Claude Code, which is in the history of the session. Mostly it's about "Mindset/Philosophy" so it's not easy to be verbalized and shared with the team. This project/tool is designed to let the Claude Code to always stay alert about the current session, whether it's a "wow moment" that worthy to be shared.

# The Claude Components of this project

## The "knowledge-extractor" Claude Code Agent
The main agent (Claude Code) will pass part of the history of the current session to this sub-agent. This sub-agent extracts some knowledges according to the following notes:
- What important is "Finding the brilliant mindset", not the actual context of the session.
- The audience of reading the shared knowledge, does not know the project. In order to let the knowledge be more understandable, this sub-agent may need to add minimal and necessary context within the knowledge sent to Slack.
- IMPORTANT: It's all about "showing the ropes" of using Claude Code, the Agentic Mindset.
- Read this page to know more about SubAgent: https://code.claude.com/docs/en/sub-agents

## The "wow-moment" Claude Code Skill
This skill is "loaded" 24/7 to let the main agent (Claude Code) stay alert, so the `description` in the `SKILL.md` is critically important. Main agent depends on this `description` to know:
- What is the "wow moment"?

The body of `SKILL.md` is the place to describe how the main agent to use the "/show-ropes" command immediately when the "wow moment" is detected.

To read this page to know more about Claude Code Skill: https://code.claude.com/docs/en/skills

## The "/show-ropes" Claude Code Command
This command shows the main agent (Claude Code), how to use the knowledge-extractor sub-agent. This command can be triggered by the user manaually or automatically by the "wow-moment" Claude Code Skill.

To read this page to know more about Claude Code Command: https://code.claude.com/docs/en/slash-commands

# The 2 Triggers
- The user wants to share the current session now.
  - "/show-ropes" triggered by the user manually.
  - "knowledge-extractor" sub-agent triggered by the command.
- The Claude Code Skill "wow-moment" triggered automatically.
  - "/show-ropes" triggered by the Claude Code Skill.
  - "knowledge-extractor" sub-agent triggered by the command.

# Installation
These tools should be installed in the user levle of Claude Code. Meaning the `~/.claude` directory. Always overwrite the existing files.

## What to Where?
- The `./agents/knowledge-extractor.md` should be copied to `~/.claude/agents/knowledge-extractor.md`.
- The `./commands/show-ropes.md` should be copied to `~/.claude/commands/show-ropes.md`.
- The `./skills/wow-moment` directory should be copied to `~/.claude/skills/wow-moment`.

## The `install_local.sh` script
This script do the "What to Where" for you. Create the necessary directories if they don't exist.

## The `install.sh` script
The Github repo of this project is open-source so anyone can simply use the `curl -fsSL https://{GITHUB_REPO_URL}/install.sh | bash` command to download necessary files and execute the `install_local.sh` script to install this tool in their `~/.claude` directory.
