#: If you come from bash you might have to change your $PATH.
# export PATH=$HOME/Library/Android/sdk/emulator:$HOME/flutter/bin:$HOME/.pub_cache/bin:$HOME/bin:/usr/local/bin:$HOME/.pub-cache/bin:$PATH
#source /usr/local/bin/virtualenvwrapper.sh
# export PATH="$PATH":"$HOME/.pub-cache/bin"
# Make python 3 the default
alias python=python3
alias pip=pip3
alias be='bundle exec'
alias cl='clear'
alias tf='terraform'
alias hb='hub'
alias gcb='git checkout -branch'
alias gcm='git checkout main'
alias gpl='git pull'

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

export REVIEW_BASE='main'

# hub completions
#if type brew &>/dev/null; then
#  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
#fi
#FPATH=(~/.zsh/completions $fpath)
#autoload -U compinit && compinit

#JAVA STUFF
# export JAVA_HOME=/Users/theodorekim/.sdkman/candidates/java/current

# Need this because pip can't compile pygraphviz without being pointed to graphviz
#export CFLAGS="-I/usr/local/include -L/usr/local/lib"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13
export NVM_DIR="/Users/teddykim/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git vi-mode
)

source $ZSH/oh-my-zsh.sh
# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# intellij home
# export  INTELLIJ_HOME="/Applications/IntelliJ IDEA.app/Contents"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
# export PATH="$PATH:$HOME/Library/android/sdk/tools:$HOME/.rvm/bin:$INTELLIJ_HOME/bin"

# android home
# export ANDROID_HOME="/Users/teddy.kim/Library/Android/sdk/tools"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS="--extended"
export FZF_DEFAULT_COMMAND="fd --type f"
#export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

#HIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
# export SDKMAN_DIR="/Users/teddy.kim/.sdkman"

#eval "$(pyenv init -)"
#eval "$(pyenv virtualenv-init -)"
# [[ -s "/Users/teddy.kim/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/teddy.kim/.sdkman/bin/sdkman-init.sh"


# export NVM_DIR="$HOME/.nvm"
# . "/usr/local/opt/nvm/nvm.sh"

# export path="$home/.fastlane/bin:$path"

# alias rake="noglob rake"

# eval "$(rbenv init -)"

# Added by ./setup
#PATH=/Users/theodorekim/.gem/ruby/2.3.0/bin:$PATH

# Added by ./setup
#PATH=.bundle/bin:$PATH

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
#[[ -f /Users/theodorekim/.nvm/versions/node/v8.10.0/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/theodorekim/.nvm/versions/node/v8.10.0/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
#[[ -f /Users/theodorekim/.nvm/versions/node/v8.10.0/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/theodorekim/.nvm/versions/node/v8.10.0/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh

#export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

#export PATH="$HOME/.bundle/bin:$HOME/.rbenv/bin:$PATH"
#eval "$(rbenv init -)"

export GH_USER=
export GH_PASS=

# export GITHUB_TOKEN=38420da55104201c3d856ef7cfdecbe75ee4f776
export GITHUB_TOKEN=
#Start OktaAWS source "/Users/theodorekim/sportsengine/bin/installers/okta-aws/bash_functions_sportsengine"
#End OktaAWS

export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=
# export GOOGLE_APPLICATION_CREDENTIALS="$HOME/hot-prospect.json"

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias claude="/Users/teddykim/.claude/local/claude"

source "$HOME/.sdkman/bin/sdkman-init.sh"
export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"

export CLOUDFLARE_API_TOKEN="uh58eHipQ7f_LXWPTiNwJuAezAJH16pqSt6rEBdq"
export CLOUDFLARE_ACCOUNT_ID="7452f3c4529113d7668c83fb7e693f8a"
