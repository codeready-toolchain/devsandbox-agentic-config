---
description: "Run this repo's linters, fix every finding, then confirm build and tests still pass"
---

# Lint and Fix

Run this repo's linters and fix every finding until lint is clean. Then
confirm the project still builds and its tests still pass.

Do not create documentation or summaries.

---

## Find the lint command

Look in the Makefile, task runner, package scripts, `AGENTS.md`, and CI.
Prefer the repo's lint target (`make lint` or the equivalent). If the repo
has an autofix target (`make lint-fix`, a `--fix` flag, or similar), run
that first.

Do not introduce a new linter.

## Fix loop

1. Run the autofix target when one exists.
2. Run lint and fix whatever remains by hand, in the style of the
   surrounding code.
3. Re-run lint until it reports a clean result.
4. Run the repo's build and test targets when they exist, and fix anything
   those surface. Lint-only edits should not change behavior.

Fix the finding in the code. Suppress it only when it is a real exception:
a false positive, generated code, or a case where changing the code would
be worse than the warning. Keep the suppression as narrow as that exception
and note why. Do not turn a rule off, or ignore a file, just to get a clean
run.
