#!/bin/bash

# pg-agent-coach wow-moment reminder hook
# Runs before each message to inject reminder into Claude's context

cat << 'EOF'
[WOW-MOMENT CHECK] Evaluate if this exchange demonstrated exceptional human-AI collaboration worth sharing. Look for: intensive back-and-forth (3+ exchanges on same topic), productive disagreements leading to better solutions, breakthrough moments after sustained engagement, or meta-collaboration about HOW to approach problems. If a genuinely valuable agentic insight emerged, invoke /show-ropes. Quality over quantity - only trigger for truly shareable collaboration patterns.
EOF
