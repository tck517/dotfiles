# mise (version manager — handles Python, Node, etc.)
if test -x $HOME/.local/bin/mise
    $HOME/.local/bin/mise activate fish | source
end

# NVM (Node version manager)
# nvm is bash-only; mise handles Node versions too.
# If you need nvm specifically, install fish-nvm: fisher install jorgebucaran/nvm.fish

# SDKMAN (JVM version manager)
# SDKMAN is bash-only. For fish, use the wrapper:
# fisher install reitzig/sdkman-for-fish
# Until then, SDKMAN commands work via: bash -c "source ~/.sdkman/bin/sdkman-init.sh && sdk <command>"

# FZF key bindings (Ctrl-T, Ctrl-R, Alt-C)
if test -f $HOME/.fzf/shell/key-bindings.fish
    source $HOME/.fzf/shell/key-bindings.fish
end

# OpenClaw completions
if command -q openclaw
    openclaw completion --shell fish | source
end
