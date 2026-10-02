---
description: "Run this repo's verification and fix every failure until it passes"
---

# Check and Fix

Run this repo's verification and fix every failure until it passes.

Do not create documentation or summaries. The result is a clean check.

---

## Find the check

Use the command this repo already treats as the full gate. Look in the
Makefile, task runner, package scripts, `AGENTS.md`, and CI:

1. A single target such as `make check-all`, `make check`, `make verify`, or
   `make ci`, when one exists.
2. Otherwise run the pieces that exist, in this order: format, build, lint
   (prefer an autofix target when the repo has one), then tests.

Do not invent targets or tools the repo does not use. Skip steps that have
no command here (for example, no format target).

## Fix loop

1. Run the check and read the failures.
2. Fix compile errors, format, and lint in the source.
3. For a failing test, read the test and the code under test.
   - Fix the product code when the behavior is wrong.
   - Fix the test when the product behavior is right and the test is stale
     or incorrect.
   - Do not delete, skip, or weaken a test to get green.
4. Re-run the failing step, then the full check.
5. Repeat until the check passes with no remaining issues.

Do not disable linters or lower coverage gates to force a pass. Suppress a
lint finding only when it is a real exception, keep that suppression narrow,
and note why.
