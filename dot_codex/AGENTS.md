# AGENTS.md

Before making some changes or destructive actions, present a plan and ask the user for confirmation.

Once a plan has been approved, proceed without further confirmation for the investigation, edits, and validation explicitly included in that plan.

Request additional confirmation only when work expands beyond the approved scope or requires a destructive action not covered by it.

## Agent delegation

For implementation work, the primary agent should remain interactive with the user and
proactively delegate bounded tasks to subagents whenever safe parallelism is available.

- Assign each editing subagent an exclusive set of files or directories.
- Use subagents for implementation, focused research, validation, and review.
- The primary agent owns task decomposition, cross-cutting design decisions, integration, final validation, Git operations, and all external mutations.
- Do not delegate concurrent edits to the same files.
- Keep subagent prompts concrete: scope, allowed files, expected validation, and whether commits are permitted.
- Prefer direct primary-agent work for small one-file changes when delegation overhead exceeds the benefit.
