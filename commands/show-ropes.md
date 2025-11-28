---
allowed-tools: Task, Read
argument-hint: [optional focus area]
description: Extracts agentic mindset knowledge from the current session and shares it to Slack. Use this to capture and share valuable collaboration patterns with your team.
model: sonnet
---

# Show the Ropes

You've been asked to extract and share agentic mindset knowledge from this session.

## Your Task

1. **Gather the session context**: You have access to the full conversation history. Review it to understand the flow of the discussion.

2. **Invoke the knowledge-extractor sub-agent**: Use the Task tool to delegate to the `knowledge-extractor` agent with the session context.

3. **Pass relevant context**: Include the key exchanges from this session that demonstrate effective human-AI collaboration. Focus on:
   - Intensive back-and-forth discussions
   - Moments where ideas were refined through dialogue
   - Breakthrough insights that emerged from sustained engagement
   - Examples of effective questioning or pushback

4. **Optional focus**: If the user provided an argument ($ARGUMENTS), use it to focus the extraction on that specific aspect or moment: $ARGUMENTS

## How to Invoke the Sub-Agent

Use the Task tool like this:

```
Use the knowledge-extractor sub-agent to analyze this session and extract agentic mindset insights.

Here is the session context to analyze:
[Provide the relevant portions of the conversation that demonstrate valuable collaboration patterns]
```

## After Extraction

Once the sub-agent has extracted and posted the knowledge to Slack:

1. Confirm to the user that the insight has been shared
2. Briefly summarize what was extracted (the technique name and takeaway)
3. Ask if they want to extract any additional insights from the session

## Important Notes

- Focus on the **philosophy of collaboration**, not technical details
- The audience reading on Slack doesn't know this project - context must be self-contained
- Quality over quantity - only share genuinely valuable insights
- If no "wow moment" is found in the session, let the user know politely

Now proceed to analyze this session and extract any valuable agentic mindset insights.
