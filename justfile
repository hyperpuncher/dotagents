# Link AGENTS.md to pi and opencode config directories
agents:
	ln -sf {{justfile_directory()}}/AGENTS.md ~/.pi/agent/AGENTS.md
	ln -sf {{justfile_directory()}}/AGENTS.md ~/.config/opencode/AGENTS.md
