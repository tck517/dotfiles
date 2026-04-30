if status is-interactive
    starship init fish | source
end
abbr -a g git

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

alias split-video="npx tsx ~/projects/tck517/jiujitsology/scripts/split-video.ts"
alias g="git"
