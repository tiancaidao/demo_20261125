# IDressy team conventions

## Before implementing a change
- Search for similar features, shared components, services, model helpers, and existing tests.
- Identify what can be reused and which caller-specific behavior must remain different.
- Briefly explain the existing implementation you found and the smallest appropriate change before editing.

## Implementation
- Prefer reusing an existing implementation over introducing a parallel one.
- If reuse needs an extension, make a focused, backward-compatible change. Preserve existing callers and defaults.
- Reuse existing model transformations before adding equivalent parameters or adapters.
- Follow established architecture, naming, state management, localization, and error-handling patterns.
- Preserve data semantics, side effects, and user-visible behavior outside the requested change.
- Avoid unrelated refactoring, new dependencies, and speculative abstractions.
- If reuse would distort the existing contract or materially expand scope, explain the tradeoff and ask for a design decision.

## Review and verification
- Inspect the diff for duplicated behavior, compatibility changes, and unintended side effects.
- Cover both the new use case and existing callers with focused regression tests when execution is requested and available.
- Use synthetic data and isolated dependencies. Do not use production services.
- Report actual verification results and gaps. Never describe unrun checks as passed.
