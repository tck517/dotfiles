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
export GITHUB_TOKEN=""
export AWS_ACCESS_KEY_ID=""
export AWS_SECRET_ACCESS_KEY=""

# PATH Configuration
export PATH="$HOME/bin:/opt/homebrew/opt/openjdk@17/bin:$PATH"

# Aliases
alias python=python3
alias pip=pip3
alias be='bundle exec'
alias cl='clear'
alias tf='terraform'
alias hb='hub'
alias gcb='git checkout -branch'
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
source "$HOME/.sdkman/bin/sdkman-init.sh"