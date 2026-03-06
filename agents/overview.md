# AI / Agent Overview

## Tech Stack example

- Agent Tool:
  - **Windsurf** is currently ranked #1 for its Cascade agent and Arena Mode, which allows side-by-side model comparisons.
  - **Cursor** remains a powerhouse with its Composer interface, supporting up to eight parallel agents for concurrent task execution.
- AI Model:
  - **Claude 4.6 Opus** ...is the 2026 technical leader with a 1M token context window and the highest SWE-bench scores (80.8%) for solving real-world software engineering issues.
- Connectivity: Model Context Protocol (**MCP**).
  - This standardized "adapter" allows your AI agent to securely connect to your local files, terminal, browser, and external SaaS tools (like Jira or Slack) without custom glue code.

### Claude (Anthropic)

- [Getting started](https://code.claude.com/docs/en/overview)
- [Pricing](https://claude.com/pricing)

A "Collaborative Agent" stack. It prioritizes safety, deep reasoning, and keeping the human in the loop. It is built as a lightweight shell (Claude Code) around a powerful reasoning model (Claude Opus)

**Claude Code** (CLI/IDE Extension):

Operates directly on your local file system. It is your primary "daily driver" for active coding sessions.

### Codex (OpenAI)

- [Getting started](https://developers.openai.com/codex)
- [Pricing](https://developers.openai.com/codex/pricing)

An "Autonomous Agent" stack. It is optimized for high-speed, background task execution in isolated cloud environments. It is powered by specialized coding variants of GPT-5.

**Codex Agent** (Cloud/CLI):

Operates in a sandboxed cloud VM. It is your "background worker" for tasks like "Write unit tests for these 50 files" or "Migrate this legacy DB to the new schema."

- [Claude vs Codex](https://www.builder.io/blog/codex-vs-claude-code)
