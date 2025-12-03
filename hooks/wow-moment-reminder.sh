#!/bin/bash

# pg-agent-coach wow-moment reminder hook
# Runs after every Claude turn to remind it to check for "wow moments"

cat << 'EOF'
[WOW-MOMENT CHECK] Evaluate if this exchange demonstrated exceptional human-AI collaboration worth sharing. Look for: intensive back-and-forth (4+ exchanges on same topic), productive disagreements leading to better solutions, breakthrough moments after sustained engagement, or meta-collaboration about HOW to approach problems. If a genuinely valuable agentic insight emerged, invoke /show-ropes. Quality over quantity - only trigger for truly shareable collaboration patterns.
EOF
