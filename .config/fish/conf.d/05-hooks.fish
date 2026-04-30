# Bell notification for long-running commands (10+ seconds)
# Rings the terminal bell so tmux activity monitor picks it up

set -g __cmd_start 0

function __record_cmd_start --on-event fish_preexec
    set -g __cmd_start (date +%s)
end

function __check_cmd_duration --on-event fish_postexec
    if test $__cmd_start -gt 0
        set -l elapsed (math (date +%s) - $__cmd_start)
        if test $elapsed -ge 10
            printf "\a"
        end
    end
    set -g __cmd_start 0
end
