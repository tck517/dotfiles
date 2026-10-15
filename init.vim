" ==============================================================================
" NEOVIM CONFIGURATION
" ==============================================================================

set nocompatible

" ==============================================================================
" PLUGIN DECLARATIONS
" ==============================================================================

call plug#begin("~/.config/nvim/bundle")

" Git Integration
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'esmuellert/codediff.nvim'

" AI Assistant
Plug 'nvim-lua/plenary.nvim'
Plug 'avifenesh/claucode.nvim'

" File Explorer
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'

" Fuzzy Finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Language Support
Plug 'hashivim/vim-terraform'
Plug 'ellisonleao/glow.nvim'

" Editing Enhancements
Plug 'tpope/vim-surround'
Plug 'cohama/lexima.vim'
Plug 'honza/vim-snippets'
Plug 'junegunn/vim-peekaboo'

" Writing Tools
Plug 'junegunn/goyo.vim'
Plug 'reedes/vim-pencil'
Plug 'junegunn/limelight.vim'

" Testing
Plug 'vim-test/vim-test'

" Navigation
Plug 'christoomey/vim-tmux-navigator'
Plug 'MattesGroeger/vim-bookmarks'

" UI/Themes
Plug 'vim-airline/vim-airline'
Plug 'morhetz/gruvbox'

" Miscellaneous
Plug 'vim-scripts/dbext.vim'
Plug 'wolandark/vim-loremipsum'

call plug#end()

" ==============================================================================
" GENERAL SETTINGS
" ==============================================================================

filetype plugin indent on
syntax on
set noswapfile

" Leader key
let mapleader = "_"

" Disable netrw (using nvim-tree instead)
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

" Completion settings
set completeopt-=preview
let g:deoplete#enable_at_startup = 1

" Indentation
set tabstop=2
set shiftwidth=2
set expandtab

" Cursor
set guicursor=i:ver100-iCursor

" Terminal colors
set termguicolors

" ==============================================================================
" THEME CONFIGURATION
" ==============================================================================

colorscheme gruvbox
set background=dark

" ==============================================================================
" PLUGIN CONFIGURATIONS
" ==============================================================================

" Test Runner
let test#strategy = "neovim"
let g:test#python#runner = "pytest"
let test#project_root = "/Users/teddykim/projects/vibeacademy/agentic-patterns/tests"

" Limelight
let g:limelight_conceal_ctermfg = '#282828'
let g:limelight_conceal_ctermfg = 235
let g:limelight_default_coefficient = 0.7
let g:limelight_paragraph_span = 2
let g:limelight_bop = '^\s'
let g:limelight_eop = '\ze\n^\s'
let g:limelight_priority = -1


" Conceal markers
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" ==============================================================================
" LUA CONFIGURATIONS
" ==============================================================================

" NvimTree setup
lua << EOF
require'nvim-tree'.setup {
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
  filters = {
    dotfiles = true,
  }
}
EOF

" ClauCode setup
lua << EOF
local ok, claucode = pcall(require, 'claucode')
if ok then
  claucode.setup({
    command = vim.fn.expand("~/.local/bin/claude"),
  })
end
EOF

" CodeDiff setup (VS Code-style diff viewer: :CodeDiff, :CodeDiff --staged, :CodeDiff pr <n>)
lua << EOF
local ok, codediff = pcall(require, 'codediff')
if ok then
  codediff.setup({})
end
EOF

" Glow markdown preview setup
lua << EOF
local ok, glow = pcall(require, 'glow')
if ok then
  glow.setup()
end
EOF

" mdfried markdown preview: <leader>m opens the current buffer in mdfried --watch.
" Uses a tmux side pane when inside tmux (passthrough is on, so Kitty graphics
" work); otherwise a Neovim :terminal vsplit.
lua << EOF
local function mdfried_preview()
  local file = vim.api.nvim_buf_get_name(0)
  if file == "" then
    vim.notify("Buffer has no file name; save it first", vim.log.levels.WARN)
    return
  end
  if vim.bo.modified then vim.cmd("write") end
  if vim.fn.executable("mdfried") == 0 then
    vim.notify("mdfried not found on PATH", vim.log.levels.ERROR)
    return
  end
  local cmd = { "mdfried", "--watch", file }
  if vim.env.TMUX then
    vim.fn.system({ "tmux", "split-window", "-h", table.concat(vim.tbl_map(vim.fn.shellescape, cmd), " ") })
  else
    -- jobstart(term=true) takes over the *current* buffer, so give it a fresh
    -- empty one instead of the markdown buffer that vsplit just mirrored.
    vim.cmd("vsplit | enew")
    vim.bo.bufhidden = "wipe"
    vim.fn.jobstart(cmd, { term = true })
    vim.cmd("startinsert")
  end
end
vim.keymap.set("n", "<leader>m", mdfried_preview, { desc = "Preview markdown with mdfried", silent = true })
EOF

" Fugitive: side-by-side diff of a commit (or a file within it) vs its parent.
" Active only inside fugitive commit / log buffers, bound to `dv`.
lua << EOF
local function commit_sha()
  -- fugitive resolves the buffer's git object (the commit SHA)
  local ok, obj = pcall(vim.fn["fugitive#Object"], vim.fn.expand("%"))
  if ok and obj and obj:match("^%x%x%x%x%x%x") then return obj end
  -- fallback: parse the SHA off the fugitive buffer name (…//<sha>)
  return (vim.fn.expand("%")):match("//(%x+)$")
end

local function diff_commit_under_cursor()
  local sha, file
  local is_fugitive = vim.fn.expand("%"):match("^fugitive://") ~= nil

  if is_fugitive then
    -- Commit-object buffer: SHA from fugitive, file from the diff hunk
    sha = commit_sha()
    local l = vim.fn.search([[\v^diff --git ]], "bncW")
    file = (l > 0) and vim.fn.getline(l):match(" b/(.*)$") or nil
    if not file then
      vim.notify("Put the cursor inside a file's diff hunk", vim.log.levels.WARN)
      return
    end
  else
    -- Log/status buffer: SHA under cursor, alternate file (#)
    sha = vim.fn.expand("<cword>")
    if not sha:match("^%x%x%x%x%x%x%x") then
      vim.notify("No commit SHA under cursor", vim.log.levels.WARN)
      return
    end
    file = vim.fn.expand("#:.")
    if file == "" then file = vim.fn.expand("%:.") end
  end

  if not sha or sha == "" then
    vim.notify("Could not determine commit SHA", vim.log.levels.WARN)
    return
  end
  if not file or file == "" then
    vim.notify("Could not determine file", vim.log.levels.WARN)
    return
  end

  vim.cmd(("Gedit %s:%s"):format(sha, file))
  vim.cmd(("Gvdiffsplit %s~1:%s"):format(sha, file))
end

-- Bind `dv` only inside fugitive buffers so it never clashes with global keys.
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "git", "fugitive" },
  callback = function(ev)
    vim.keymap.set("n", "dv", diff_commit_under_cursor, {
      buffer = ev.buf,
      desc = "Side-by-side: commit/file under cursor vs parent",
    })
  end,
})
EOF

" ==============================================================================
" KEY MAPPINGS
" ==============================================================================

" Test runner mappings
nnoremap t<C-n> :TestNearest<CR>
nnoremap t<C-f> :TestFile<CR>
nnoremap t<C-s> :TestSuite<CR>
nnoremap t<C-l> :TestLast<CR>
nnoremap t<C-g> :TestVisit<CR>

" Search highlighting toggle
nnoremap <C-n> :set hlsearch!<CR>

" Line movement
nnoremap <S-Up> :m-2<CR>
nnoremap <S-Down> :m+<CR>
inoremap <S-Up> <Esc>:m-2<CR>
inoremap <S-Down> <Esc>:m+<CR>

" Buffer navigation
nnoremap <C-b> :Buffers<CR>
nnoremap <leader>bp :bprevious<CR>

" FZF mappings
nnoremap <C-p> :Files<CR>
nnoremap <silent> <leader>g :Rg! <C-R><C-W><CR>

" Explorer mappings
nnoremap <C-t> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>

" Documentation preview
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Folding mappings
nnoremap <leader>f :set foldmethod=indent<CR>

" Line number toggle
nnoremap <leader>n :set number!<CR>

" Writing mode (Goyo + SoftPencil)
nnoremap <leader>z :Goyo<CR>:SoftPencil<CR>

" Claude Code mappings
xnoremap <leader>e :Claude Explain this code<CR>

" Remove whitespace-only lines
nnoremap <leader>ws :%s/^\s\+$//<CR>

" Remove trailing whitespace
nnoremap <leader>wt :%s/\s\+$//<CR>

" ==============================================================================
" CUSTOM COMMANDS
" ==============================================================================

" FZF with preview
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" ==============================================================================
" AUTOCOMMANDS
" ==============================================================================

" Highlight trailing whitespace
highlight RedundantSpaces ctermbg=red guibg=red
match RedundantSpaces /\s\+$/

" Goyo integration
autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" ==============================================================================
" FUNCTIONS
" ==============================================================================

function! CheckBackSpace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:goyo_enter()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status off
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  endif
  set noshowmode
  set noshowcmd
  set scrolloff=999
  SoftPencil
endfunction

function! s:goyo_leave()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status on
    silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  endif
  set showmode
  set showcmd
  set scrolloff=5
  SoftPencil
endfunction

" ── Branch picker: :Branches → j/k to move, <CR> to switch local ──
function! s:BranchSwitch() abort
  let l:branch = trim(getline('.'))
  if empty(l:branch) | return | endif
  close
  execute 'Git switch ' . fnameescape(l:branch)
endfunction

function! s:BranchList() abort
  let l:branches = systemlist('git branch --format="%(refname:short)"')
  if v:shell_error
    echohl ErrorMsg | echomsg 'git branch failed' | echohl None | return
  endif
  botright 12new
  setlocal buftype=nofile bufhidden=wipe noswapfile nobuflisted nonumber
  call setline(1, l:branches)
  setlocal nomodifiable
  let l:head = get(systemlist('git rev-parse --abbrev-ref HEAD'), 0, '')
  call search('\V\^' . escape(l:head, '\') . '\$', 'cw')
  nnoremap <buffer> <silent> <CR> :call <SID>BranchSwitch()<CR>
  nnoremap <buffer> <silent> q :close<CR>
endfunction
command! Branches call s:BranchList()

" ── PR picker: :PRs [gh pr list flags] → fzf over PRs, <CR> to review in CodeDiff ──
function! s:PRReview(line) abort
  let l:num = matchstr(a:line, '^\d\+')
  if empty(l:num) | return | endif
  execute 'CodeDiff pr ' . l:num
endfunction

function! s:PRList(args) abort
  let l:out = system('gh pr list --json number,title,author,headRefName ' . a:args)
  if v:shell_error
    echohl ErrorMsg | echomsg 'gh pr list failed: ' . get(split(l:out, "\n"), 0, '') | echohl None | return
  endif
  let l:prs = map(json_decode(l:out),
    \ {_, pr -> printf('%-5d %s  [%s · %s]', pr.number, pr.title, pr.author.login, pr.headRefName)})
  if empty(l:prs)
    echomsg 'No pull requests' | return
  endif
  call fzf#run(fzf#wrap({
    \ 'source': l:prs,
    \ 'sink': function('s:PRReview'),
    \ 'options': ['--prompt', 'PRs> ', '--preview', 'env GH_FORCE_TTY=100% gh pr view {1}',
    \             '--preview-window', 'up,70%,wrap'],
    \ }))
endfunction
command! -nargs=* PRs call s:PRList(<q-args>)
