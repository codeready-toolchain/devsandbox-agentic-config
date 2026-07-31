# Pull Request Review Comment - Context

**The user's message contains a Pull Request review comment that needs to be
addressed.**

Treat the user's input as the reviewer's feedback. Your job is to **decide**
whether to implement, disagree, clarify, or skip — not to make the review
green by default.

---

## How to Address the PR Comment

Follow this systematic approach:

## 1. Identify the Context

**First, determine what code the comment refers to:**

- Read the files mentioned or implied by the comment
- Use recently viewed files, or file context to identify relevant files
- Understand the current implementation before proceeding
- Check how **sibling code** handles the same concern (other tools, callers,
  established patterns in this repo). Inconsistency is a signal the suggestion
  may be over-scoped.

## 2. Analysis Phase

**Do not blindly implement the suggestion.** Analyze before writing code.

### Soundness vs necessity

A comment can be **technically correct** and still **not worth doing**. Judge
both:

| Question | Ask |
|----------|-----|
| Sound? | Is the finding still true against current code? Is the reviewer mistaken or missing context? |
| Necessary? | What concrete scenario does this prevent or improve? How likely is it here? |
| Proportionate? | Does the added complexity/cost match the realistic risk or benefit? |
| Consistent? | Do peer paths (similar tools/APIs) already accept the same tradeoff? |

**"Still valid" means still true in the code — not "must implement."** Valid but
unnecessary nits (theoretical TOCTOU, speculative caching, style-only refactors
with large blast radius) should use the **disagree / skip** path unless the
user explicitly wants them.

### Before implementing security, concurrency, or perf nits

State in your reasoning (and to the user if you will change code):

1. **Scenario** — the concrete failure or race (actors, timing, preconditions)
2. **Likelihood** — why it would or would not happen in this product/path
3. **Decision** — implement / skip / ask

If you cannot name a plausible scenario, **do not implement**; disagree or ask.

### Critical: Understand Full Implications

**A suggestion may be correct but incomplete.** Always consider:

- **Ripple effects:** Changes in one area often require updates elsewhere
- **Cross-component impact:** Backend changes may require frontend updates, and
  vice versa
- **API contracts:** Changing interfaces affects all consumers
- **Database schema:** Model changes require migration scripts and all affected
  queries
- **Tests:** Implementation changes require corresponding test updates
- **Documentation:** Code changes may need doc updates

**If you choose to implement and the suggestion requires changes beyond what's
explicitly mentioned, make those changes too.** A partial implementation is
worse than no implementation. If the full fix is large, say so and confirm
before proceeding.

## 3. Decision Gate (required before coding)

Pick **one** outcome and tell the user briefly which it is:

1. **Implement** — sound, necessary, and proportionate; then follow §4
2. **Disagree / skip** — explain why (scenario unlikely, inconsistent with
   siblings, cost outweighs benefit, reviewer mistaken); **do not** change code
   unless the user overrides
3. **Clarify** — ask before changing anything
4. **Partial / alternative** — propose a smaller fix or different approach;
   implement only after the user agrees if the delta is non-trivial

Do **not** optimize for "address every bullet in the review." Optimize for a
correct product decision.

## 4. Response Strategy

### If you implement

- Acknowledge the useful part of the feedback
- Implement the fix (or a justified alternative)
- Explain briefly if your change differs from the suggestion
- Add or adjust tests when behavior changes
- Update documentation if relevant

### If the comment is unclear

- **Ask for clarification** before making changes
- Explain your current understanding and why it might be ambiguous
- Suggest alternatives if you have ideas about what they meant

### If you disagree or skip

- Respectfully explain with technical justification (scenario + likelihood +
  cost)
- Provide context the reviewer might have missed (including sibling patterns)
- Suggest alternatives or a middle ground when useful
- Stay open to discussion — you might be missing something too

## 5. Implementation Guidelines

Only after choosing **Implement** (or the user accepts an alternative):

- **Make comprehensive changes:** Modify everything necessary to fully address
  the comment, including related components
- **Think across boundaries:** If backend changes, check if frontend needs
  updates; if models change, update all consumers
- **Maintain consistency:** Follow existing code style and patterns across all
  modified files
- **Preserve functionality:** Don't introduce new bugs while fixing issues
- **Consider edge cases:** Think beyond the immediate change
- **Test coverage:** When making changes, prioritize test updates:
   - **First choice:** Adjust existing tests to cover the change (better than
    adding new tests)
   - **Second choice:** Add new tests if existing ones don't cover the changed
    behavior
   - **Always:** Ensure all tests pass after your changes
   - **When to skip:** Only skip test updates if it's too tricky or doesn't make
    sense for the specific change
- **Check for linter errors:** Fix any new warnings or errors introduced in all
  modified files

## 6. Final Checklist

Before considering the comment addressed:

- [ ] Have I distinguished soundness from necessity?
- [ ] For nits: did I name a concrete scenario (or skip/disagree)?
- [ ] Did I compare with sibling/existing patterns?
- [ ] Did I pick an explicit decision (implement / skip / clarify / alternative)
      before coding?
- [ ] If I implemented: is the change proportionate and complete (tests, callers)?
- [ ] If I skipped: did I explain clearly enough for the user to reply to the
      reviewer?
- [ ] Have I communicated the rationale to the user?
