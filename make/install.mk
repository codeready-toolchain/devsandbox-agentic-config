# Install shared commands and skills into a target repository.
# Usage: make install TARGET=/path/to/repo

AGENTIC_CONFIG_ROOT := $(abspath $(dir $(lastword $(MAKEFILE_LIST)))/..)

.PHONY: install
install:
	@if [ -z "$(TARGET)" ]; then \
		echo "TARGET is required. Example: make install TARGET=/path/to/repo" >&2; \
		exit 1; \
	fi
	@set -euo pipefail; \
	ROOT="$(AGENTIC_CONFIG_ROOT)"; \
	TARGET="$(abspath $(TARGET))"; \
	if [ ! -d "$$TARGET" ]; then \
		echo "TARGET is not a directory: $$TARGET" >&2; \
		exit 1; \
	fi; \
	link_dir() { \
		src="$$1"; \
		dest="$$2"; \
		replace_dir="$$3"; \
		dest_parent="$$(dirname "$$dest")"; \
		mkdir -p "$$dest_parent"; \
		if [ -d "$$dest" ] && [ ! -L "$$dest" ]; then \
			if [ "$$replace_dir" = "yes" ]; then \
				rm -rf "$$dest"; \
			else \
				echo "Refusing to replace existing directory: $$dest" >&2; \
				exit 1; \
			fi; \
		fi; \
		ln -sfnT "$$(realpath --relative-to="$$dest_parent" "$$src")" "$$dest"; \
		echo "$$dest -> $$(readlink "$$dest")"; \
	}; \
	commands="$$ROOT/common/commands/common"; \
	if [ ! -d "$$commands" ]; then \
		echo "Missing commands directory: $$commands" >&2; \
		exit 1; \
	fi; \
	link_dir "$$commands" "$$TARGET/.cursor/commands/common" yes; \
	link_dir "$$commands" "$$TARGET/.claude/commands/common" yes; \
	skills="$$ROOT/common/skills"; \
	if [ -d "$$skills" ]; then \
		while IFS= read -r skill_md; do \
			skill_dir="$$(dirname "$$skill_md")"; \
			name="$$(basename "$$skill_dir")"; \
			link_dir "$$skill_dir" "$$TARGET/.agents/skills/$$name" no; \
			link_dir "$$skill_dir" "$$TARGET/.claude/skills/$$name" no; \
		done < <(find "$$skills" -mindepth 2 -maxdepth 2 -type f -name SKILL.md | sort); \
	fi
