# AGENTS.md

Before making some changes or destructive actions, present a plan and ask the user for confirmation.

Once a plan has been approved, proceed without further confirmation for the investigation, edits, and validation explicitly included in that plan.

Request additional confirmation only when work expands beyond the approved scope or requires a destructive action not covered by it.

## Agent delegation

For work that benefits from delegation or independent perspectives, the primary agent
should remain interactive with the user and proactively delegate bounded tasks to
subagents when delegation provides clear value and can be safely scoped. Delegation may
be sequential or parallel, and may cover design, alternative proposals, focused
research, implementation, validation, and review—not only coding.

- Assign each editing subagent an exclusive set of files or directories.
- Give subagents a clear goal, scope, constraints, expected output, and expected
  validation. State whether commits are permitted.
- A subagent may develop a design from high-level requirements. The primary agent need
  not be the sole author of a design; it owns task decomposition, integration,
  cross-cutting consistency, final validation, Git operations, and all external
  mutations.
- Use independent reviews deliberately. For example, a subagent can develop a design,
  the primary agent can perform a first review, and the user can perform a second
  review before the primary agent feeds the user's feedback back into the delegated
  work.
- Keep priority, scope, and trade-off decisions interactive. The primary agent should
  surface material choices to the user and use that conversation to steer,
  reprioritize, or redirect delegated work.
- Prefer complementary perspectives over duplicating the same work. Useful review
  roles include checking a design's assumptions, identifying alternatives and risks,
  or assessing whether instructions are clear to a first-time reader.
- Do not delegate concurrent edits to the same files.
- Prefer direct primary-agent work for small one-file changes when delegation overhead exceeds the benefit.
