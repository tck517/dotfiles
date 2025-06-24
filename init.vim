set nocompatible
" filetype off
call plug#begin("~/.config/nvim/bundle")
" Flog
Plug 'rbong/vim-flog'
" Lorem
Plug 'wolandark/vim-loremipsum'
" pull requests
Plug 'kristijanhusak/vim-create-pr'
" copilot
Plug 'github/copilot.vim'
Plug 'zbirenbaum/copilot.lua'
Plug 'nvim-lua/plenary.nvim'
Plug 'CopilotC-Nvim/CopilotChat.nvim', { 'branch': 'canary' }
" explorer
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'
" markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
" terraform
Plug 'hashivim/vim-terraform'
" honza ultisnips
Plug 'honza/vim-snippets'
" gitgutter
Plug 'airblade/vim-gitgutter'
" db
Plug 'vim-scripts/dbext.vim'
" tmuxnavigator
Plug 'christoomey/vim-tmux-navigator'
" surround
Plug 'tpope/vim-surround'
" status line
Plug 'vim-airline/vim-airline'
" code review
Plug 'AGHost-7/critiq.vim'
" mermaid viewer
Plug 'FuDesign2008/mermaidViewer.vim'
" autoclose parentheses
Plug 'cohama/lexima.vim'
" writing
Plug 'junegunn/goyo.vim'
Plug 'reedes/vim-pencil'
Plug 'junegunn/limelight.vim'
" themes
Plug 'morhetz/gruvbox'
Plug 'junegunn/seoul256.vim'
Plug 'jez/vim-colors-solarized'
" test runner
Plug 'vim-test/vim-test'
" bookmarks
Plug 'MattesGroeger/vim-bookmarks'
" git
Plug 'tpope/vim-fugitive'
" fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" register
Plug 'junegunn/vim-peekaboo'
call plug#end()

let g:deoplete#enable_at_startup = 1
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

" scratch preview
set completeopt-=preview

" test runner
let test#strategy = "neovim"
nnoremap t<C-n> :TestNearest<CR>
nnoremap t<C-f> :TestFile<CR>
nnoremap t<C-s> :TestSuite<CR>
nnoremap t<C-l> :TestLast<CR>
nnoremap t<C-g> :TestVisit<CR>

let g:test#javascript#runner = "jest"
let test#project_root = "/Users/teddykim/projects/gldmdl/src"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" mapleader
let mapleader = "_"

" highlight search
nnoremap <C-n> :set hlsearch!<CR>

" Move lines up and down
nnoremap <S-Up> :m-2<CR>
nnoremap <S-Down> :m+<CR>
inoremap <S-Up> <Esc>:m-2<CR>
inoremap <S-Down> <Esc>:m+<CR>

" buffers
nnoremap <C-b> :Buffers<CR>

" FZF
" rg in files
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" Files command with preview window
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

nnoremap <silent> <leader>g :Rg! <C-R><C-W><CR>

nnoremap <C-p> :Files<CR>
" scheme
colorscheme gruvbox
set background=dark

" limelight
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = '#282828'
let g:limelight_conceal_ctermfg = 235

" Color name (:help gui-colors) or RGB color
" let g:limelight_conceal_guifg = 'bg'
" let g:limelight_conceal_guifg = '#282828'

" Default: 0.5
let g:limelight_default_coefficient = 0.7

" Number of preceding/following paragraphs to include (default: 0)
let g:limelight_paragraph_span = 2

" Beginning/end of paragraph
"   When there's no empty line between the paragraphs
"   and each paragraph starts with indentation
let g:limelight_bop = '^\s'
let g:limelight_eop = '\ze\n^\s'

" Highlighting priority (default: 10)
" Set it to -1 not to overrule hlsearch
let g:limelight_priority = -1

" goyo
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

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" show whitespace
highlight RedundantSpaces ctermbg=red guibg=red
match RedundantSpaces /\s\+$/

" mermaid
" autocmd BufNewFile,BufReadPost *.mmd,*.mermaid set filetype=mermaid
" au BufReadPost *.mmd set syntax=yaml

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=2
" when indenting with '>', use 4 spaces width
set shiftwidth=2
" On pressing tab, insert 4 spaces
set expandtab

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

" cursor
set guicursor=i:ver100-iCursor

syntax on
noswapfile

function! CheckBackSpace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" buffer nav
nnoremap <leader>bp :bprevious<CR>

" explorer
lua << EOF
require'nvim-tree'.setup {
    -- Your configuration here
    -- auto_close = true,  -- Automatically close the tree when it's the last window
    filters = {
      dotfiles = true,
    }
}
EOF
nnoremap <C-t> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>

" copilot
lua << EOF
require("CopilotChat").setup {
  debug = true, -- Enable debugging
  -- See Configuration section for rest
}
EOF
nnoremap <C-c> :CopilotChatToggle<CR>
nnoremap <C-r> :CopilotChatReset<CR>
nnoremap <leader>e :CopilotChat /explain<CR>
imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

set termguicolors
