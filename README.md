# Agentic configurations for Developer Sandbox

The repository holds the common configurations, rules and skills used by the
Developer Sandbox team to develop, maintain and improve their projects.

## Required packages

- `stow` if you want to "autoinstall" the contents.
- [Podman](https://podman.io/) to run the Markdown linter, which runs
  [markdownlint](https://github.com/markdownlint/markdownlint) inside a
  container.

## How to install the common directives

1. Create the `.cursor` —or any other agent's directory— in the target repository.
2. Create the appropriate symlinks with stow using the following command:

   ```bash
   export PATH_DEVSANDBOX_AGENTIC_CONFIG_REPO="path/to/devsandbox-agentic-config"
   export TARGET_REPOSITORY="path/to/target/repository"
   stow --no-folding \
     --dir="${PATH_DEVSANDBOX_AGENTIC_CONFIG_REPO}" \
     --target="${TARGET_REPOSITORY}"/.cursor \
     common
   ```

   The `--no-folding` flag ensures stow creates individual file symlinks instead
   of symlinking the entire directory. This allows each repository to add its own
   commands, skills and rules along with the common ones.

3. Add the following line to the target repository's `.gitignore` to prevent the
   common symlinks from being committed:

   ```gitignore
   .cursor/**/common/
   ```

Common directives (commands, rules, skills) are placed under `common/`
subdirectories inside `.cursor/` so they can all be excluded with a single
`.gitignore` rule. Repository-specific directives live alongside the `common/`
directories and are tracked normally.

## Available commands

| Command | Description |
|---|---|
| `analyze-only` | Deep analysis and recommendations without making any changes |
| `design-with-questions` | Structured design mode: generates a design document and a companion questions document, then walks through decisions one by one |
| `jira-stories` | Translates design/planning/task documents into JIRA stories that follow the agreed upon Dev Sandbox template |
| `pr-comment` | Analyzes a PR review comment critically and addresses it with appropriate code changes |
| `promote-to-adr` | Converts an implemented proposal from `docs/proposals/` into a numbered ADR under `docs/adr/` |
| `research` | Performs comprehensive internet research with source citations and synthesis |
| `verify-design-document` | Reviews a design document for internal consistency, codebase alignment, and gaps |

## Linting

Markdown files can be linted with `make lint`.
