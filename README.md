# Agentic configurations for Developer Sandbox

The repository holds the common configurations, rules and skills used by the
Developer Sandbox team to develop, maintain and improve their projects.

## Optional tools

- [Podman](https://podman.io/) if you want to run the local Markdown linter
  (`make lint`).

## How to install the common directives

From this repository, link the shared commands into a target project:

```bash
make install TARGET=/path/to/repo
```

`TARGET` is the project root and must already exist. The command creates two
directory symlinks, both pointing at `common/commands/common`:

- `.cursor/commands/common` — Cursor slash commands, for example `/common/commit`
- `.claude/commands/common` — Claude Code slash commands, for example
  `/common:commit`. Grok Build reads this directory when its Claude
  compatibility scan is on.

A new command file in this repo shows up in an already-installed project
without running `make install` again. Re-running it is safe when `common` is
already a symlink. A real `common` directory is left in place. Replace it
with `make install TARGET=/path/to/repo OVERWRITE=1`. Repository-specific
commands stay beside `common/`, for example `.cursor/commands/my-command.md`.

Codex has no project commands directory. When this repo contains
`common/skills/<name>/SKILL.md`, the same command also links that skill into
`.agents/skills/<name>` and `.claude/skills/<name>`. Those two directories
cover Codex, Cursor, Claude Code, and Grok. A skill linked into both can show
up twice in Cursor. There are no shared skills yet, so a current install links
commands only.

Ignore the command links in the target repository so they are not committed.
Leave off the trailing slash so Git ignores the symlink itself:

```gitignore
.cursor/**/common
.claude/**/common
```

## Available commands

| Command | Description |
|---|---|
| `analyze-only` | Deep analysis and recommendations without making any changes |
| `check-and-fix` | Run this repo's verification and fix every failure until it passes |
| `create-tests` | Write practical tests for the current change, using this repo's own test conventions |
| `design-with-questions` | Structured design mode: generates a design document and a companion questions document, then walks through decisions one by one |
| `jira-stories` | Translates design/planning/task documents into JIRA stories that follow the agreed upon Dev Sandbox template |
| `lint-and-fix` | Run this repo's linters, fix every finding, then confirm build and tests still pass |
| `pr-comment` | Critically analyzes a PR review comment and chooses Implement, Skip, Clarify, or Alternative — not “make the review green” by default |
| `promote-to-adr` | Converts an implemented proposal from `docs/proposals/` into a numbered ADR under `docs/adr/` |
| `research` | Performs comprehensive internet research with source citations and synthesis |
| `sketch-with-questions` | Produce a high-level technical sketch and a questions document, then walk through the questions one at a time |
| `verify-design-document` | Reviews a design document for internal consistency, codebase alignment, and gaps |
| `commit` | Analyze uncommitted changes, create a branch if needed, and git commit with a well-structured message |

## Linting

`make lint` is optional and local. GitHub CI does not run it. These files are
instructions for agents, so markdown style is not a merge requirement.
