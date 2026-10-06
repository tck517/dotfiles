function fish_title
    # Inside tmux, leave the pane title alone so `select-pane -T` sticks.
    if set -q TMUX
        return
    end
    echo (prompt_pwd)
end
