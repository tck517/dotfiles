# Oh My Zsh Configuration
export ZSH=~/.oh-my-zsh
ZSH_THEME="agnoster"
plugins=(git vi-mode)
source $ZSH/oh-my-zsh.sh

# Environment Variables
export REVIEW_BASE='main'
export NVM_DIR="/Users/teddykim/.nvm"
export CLOUDFLARE_API_TOKEN=""
export CLOUDFLARE_ACCOUNT_ID=""
export GH_USER=""
export GH_PASS=""
# export GITHUB_TOKEN=""
export AWS_ACCESS_KEY_ID=""
export AWS_SECRET_ACCESS_KEY=""

# PATH Configuration
export PATH="$HOME/bin:/usr/local/go/bin:$PATH"

# Aliases
alias python=python3
alias pip=pip3
alias be='bundle exec'
alias cl='clear'
alias tf='terraform'
alias hb='hub'
alias gcb='git checkout -b'
alias gcm='git checkout main'
alias gpl='git pull'
alias claude="/Users/teddykim/.claude/local/claude"

# FZF Configuration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS="--extended"
export FZF_DEFAULT_COMMAND="fd --type f"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# NVM Configuration
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# SDKMAN Configuration
[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ] && source "$HOME/.sdkman/bin/sdkman-init.sh"
# Created by `pipx` on 2025-07-05 23:15:06
export PATH="$PATH:/Users/teddykim/.local/bin"
export PATH="/opt/homebrew/bin:$PATH"
eval "$(~/.local/bin/mise activate)"

export PATH="/usr/local/opt/openjdk@17/bin:$PATH"

# Secrets (untracked) — Anthropic, GitHub PATs, Supabase, Railway,
# Cal.com, YouTube, Replicate, Typefully API keys.
[ -f "$HOME/.zsh_secrets" ] && source "$HOME/.zsh_secrets"
launchctl setenv GITHUB_PERSONAL_ACCESS_TOKEN $(gh auth token)
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# ~/.zshrc
autoload -Uz add-zsh-hook
LONGRUNTIME=10   # seconds

_zsh_cmd_start() { ZSH_CMD_START=$SECONDS }
_zsh_cmd_done() {
  if (( SECONDS - ZSH_CMD_START >= LONGRUNTIME )); then
    print -n "\a"   # ring bell => tmux => kitty
  fi
}

add-zsh-hook preexec _zsh_cmd_start
add-zsh-hook precmd _zsh_cmd_done
export TYPEFULLY_SOCIAL_SET_ID="78110"

export CAL_COM_EVENT_TYPE_BJJ=123  # Your event type ID

export GOOGLE_APPLICATION_CREDENTIALS="$HOME/ga-credentials.json"
export GOOGLE_PROJECT_ID="745576316519"

export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# OpenClaw Completion
source <(openclaw completion --shell zsh)

# Added by Agile Flow bootstrap
export AGILE_FLOW_WORKER_ACCOUNT="va-worker"

# Added by Agile Flow bootstrap
export AGILE_FLOW_REVIEWER_ACCOUNT="va-reviewer"

