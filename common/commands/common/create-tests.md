---
description: "Write practical tests for the current change, using this repo's own test conventions"
---

# Create Tests

Write practical tests for the current change. Cover new or modified behavior.
Leave the rest of the codebase alone.

The change is whatever the user described. If they did not name a scope, use
uncommitted work (`git diff` and `git diff --cached`). If the working tree is
clean, use the commits on this branch that are not on the default branch.

---

## Before writing

1. Read the changed code. Understand the public behavior, including error
   paths.
2. Find tests that already cover that area. Match their framework, file
   layout, helpers, assertions, naming, and license headers.
3. Learn how this repo runs tests. Check the Makefile, package scripts,
   `AGENTS.md`, and CI workflows. Use those commands. Do not invent a runner
   or a framework this repo does not already use.

If the diff mixes a behavior change with formatting or rename noise, test the
behavior change.

## What to test

Test behavior that could realistically break: the happy path, edge cases, and
error handling that the change introduces.

Skip:

- Trivial getters, styling, and one-line wrappers
- Framework or library behavior
- Tests that need heavier mocking than the code they protect
- Cases already covered at the same level

A few tests of real logic are worth more than broad, brittle coverage.
Coverage percentage is not the goal.

Prefer extending an existing test (an extra case or subtest) over a new test
that repeats the same setup. Add a new test when the behavior does not fit
what is already there.

Use the level this repo already uses for that kind of code. Unit tests for
logic. A higher-level test when mocks get in the way. Do not retest the same
behavior at the same level. Covering it at both unit and integration level is
fine when the project already does that.

## Rules

1. **Test behavior, not implementation.** Assert inputs, outputs, and
   observable effects. Do not lock tests to private call sequences.
2. **No historical comments.** No "added for ticket X" or "tests the new
   implementation". The test name should say what behavior it checks.
3. **Every new test must pass.** Run them. If a test is too brittle to get
   right, delete it. Do not leave it failing or skipped.
4. **A failing test may be a product bug.** Read the test and the code under
   test. Fix the implementation when it is wrong. Change the test only when
   the implementation is correct and the expectation was not. Do not encode
   buggy behavior. Ask when it is unclear which side is wrong.
5. **No documentation files.** Do not add summaries, coverage reports, or
   other markdown unless the user asked for them.
6. **Match this repo.** Table-driven or parameterized tests, helpers,
   cleanup, markers, and headers — copy the local pattern. If existing test
   files carry a license header, include the same header.

## Run and finish

Run the narrowest existing target that executes the new tests. Then run the
broader suite CI uses for this area when that is practical.

Done when the new tests pass, follow local conventions, and only cover
behavior the change needs.

**Be practical. Create only tests that bring real value.**
