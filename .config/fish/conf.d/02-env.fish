# Review
set -gx REVIEW_BASE main

# NVM
set -gx NVM_DIR $HOME/.nvm

# Secrets (untracked) — Anthropic, GitHub PATs, Supabase, Railway,
# Cal.com, YouTube, Replicate, Typefully API keys.
test -f $HOME/.config/fish/secrets.fish; and source $HOME/.config/fish/secrets.fish

# GitHub token from gh CLI (overrides any value from secrets.fish if available)
if command -q gh
    set -gx GITHUB_PERSONAL_ACCESS_TOKEN (gh auth token 2>/dev/null)
end

# Cal.com
set -gx CAL_COM_EVENT_TYPE_BJJ 123

# Google
set -gx GOOGLE_APPLICATION_CREDENTIALS "$HOME/ga-credentials.json"
set -gx GOOGLE_PROJECT_ID "745576316519"

# Typefully
set -gx TYPEFULLY_SOCIAL_SET_ID "78110"

# Gemba Flow (renamed from AGILE_FLOW_* per dual-read shim deprecation)
set -gx GEMBAFLOW_WORKER_ACCOUNT "va-worker"
set -gx GEMBAFLOW_REVIEWER_ACCOUNT "va-reviewer"

# FZF
set -gx FZF_DEFAULT_OPTS "--extended"
set -gx FZF_DEFAULT_COMMAND "fd --type f"
set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND

# Sync token to macOS environment for non-shell processes (MCP servers, etc.)
if command -q gh
    launchctl setenv GITHUB_PERSONAL_ACCESS_TOKEN (gh auth token 2>/dev/null)
end
