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
Plug 'rbong/vim-flog'
Plug 'kristijanhusak/vim-create-pr'

" AI/Copilot
Plug 'github/copilot.vim'
Plug 'zbirenbaum/copilot.lua'
Plug 'nvim-lua/plenary.nvim'
Plug 'CopilotC-Nvim/CopilotChat.nvim', { 'branch': 'canary' }

" File Explorer
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'

" Fuzzy Finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Language Support
Plug 'hashivim/vim-terraform'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'FuDesign2008/mermaidViewer.vim'

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
Plug 'junegunn/seoul256.vim'
Plug 'jez/vim-colors-solarized'

" Miscellaneous
Plug 'AGHost-7/critiq.vim'
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
let g:test#javascript#runner = "jest"
let test#project_root = "/Users/teddykim/projects/gldmdl/src"

" Limelight
let g:limelight_conceal_ctermfg = '#282828'
let g:limelight_conceal_ctermfg = 235
let g:limelight_default_coefficient = 0.7
let g:limelight_paragraph_span = 2
let g:limelight_bop = '^\s'
let g:limelight_eop = '\ze\n^\s'
let g:limelight_priority = -1

" Copilot
let g:copilot_no_tab_map = v:true

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

" CopilotChat setup
lua << EOF
require("CopilotChat").setup {
  debug = true,
  show_system_prompt = false,
  show_help = false,
}
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

" Copilot mappings
nnoremap <C-c> :CopilotChatToggle<CR>
nnoremap <C-r> :CopilotChatReset<CR>
nnoremap <leader>e :CopilotChat /explain<CR>
imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")

" Documentation preview
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Folding mappings
nnoremap <leader>f :set foldmethod=indent<CR>

" Line number toggle
nnoremap <leader>n :set number!<CR>

" Writing mode (Goyo + SoftPencil)
nnoremap <leader>z :Goyo<CR>:SoftPencil<CR>

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
