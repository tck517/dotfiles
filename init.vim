set nocompatible
" filetype off

call plug#begin("~/.config/nvim/bundle")
 " tmuxnavigator
 Plug 'christoomey/vim-tmux-navigator'
 " themes
 Plug 'nightsense/seagrey'
 " completion
 Plug 'neoclide/coc.nvim'
 " surround
 Plug 'tpope/vim-surround'
 " outlining
 Plug 'lifepillar/vim-outlaw'
 " sneak
 Plug 'justinmk/vim-sneak'
 " markdown
 Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
 " vimwiki
 " Plug 'vimwiki/vimwiki'
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
 " flutter and dart
 Plug 'dart-lang/dart-vim-plugin'
 Plug 'thosakwe/vim-flutter'
 Plug 'natebosch/vim-lsc'
 Plug 'natebosch/vim-lsc-dart' 
 " test runner
 Plug 'janko/vim-test'
 " bookmarks
 Plug 'MattesGroeger/vim-bookmarks'
 " git
 Plug 'tpope/vim-fugitive'
 " rails and ruby
 Plug 'tpope/vim-rails'
 " file management
 Plug 'shougo/unite.vim'
 Plug 'shougo/vimfiler.vim'
 " formatting
 Plug 'dense-analysis/ale'
 Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
 " Plug 'sbdchd/neoformat'
 " file templates
 Plug 'tibabit/vim-templates'
 " fuzzy finder
 Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
 Plug 'junegunn/fzf.vim'
 " typescript formatting
" Plug 'Quramy/tsuquyomi'
" Plug 'HerringtonDarkholme/yats.vim'
" Plug 'leafgarland/typescript-vim'
 " snippets
 Plug 'Shougo/neosnippet.vim'
 Plug 'Shougo/neosnippet-snippets'
call plug#end()

" flutter
nnoremap f<C-r> :FlutterRun<cr>
nnoremap f<C-q> :FlutterQuit<cr>
nnoremap f<C-h> :FlutterHotReload<cr>
nnoremap f<C-b> :FlutterHotRestart<cr>
nnoremap f<C-d> :FlutterVisualDebug<cr>

" scratch preview
set completeopt-=preview

" test runner
let test#strategy = "neovim"
nnoremap t<C-n> :TestNearest<CR>
nnoremap t<C-f> :TestFile<CR>
nnoremap t<C-s> :TestSuite<CR>
nnoremap t<C-l> :TestLast<CR>
nnoremap t<C-g> :TestVisit<CR>

" Plugin key-mappings.
" imap <C-j> <Plug>(neosnippet_expand_or_jump)
" smap <C-j> <Plug>(neosnippet_expand_or_jump)
" xmap <C-j> <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB>
\ pumvisible() ? "\<C-n>" :
\ neosnippet#expandable_or_jumpable() ?
\    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

let g:neosnippet#snippets_directory = $HOME . '/.config/nvim/neosnips'

" vimfiler
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_expand_jump_to_first_child = 1

" Enable file operation commands.
" Edit file by tabedit.
call vimfiler#custom#profile('default', 'context', {
      \ 'safe' : 0,
      \ })

" mapleader
let mapleader = "_"

" unite file explorer
nnoremap <C-e> :VimFiler<CR>
nnoremap <C-x> :VimFilerExplorer<CR>

" highlight search
nnoremap <C-n> :set hlsearch!<CR>

" buffers
nnoremap <C-b> :Unite buffer<CR>

" Move lines up and down
nnoremap <S-Up> :m-2<CR>
nnoremap <S-Down> :m+<CR>
inoremap <S-Up> <Esc>:m-2<CR>
inoremap <S-Down> <Esc>:m+<CR>

" FZF
nnoremap <C-p> :Files<CR>
" nnoremap <C-b> :Buffers<CR>

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

" rspec
" nnoremap <leader>rt :!rspec %<CR>
" nnoremap <leader>ra :!rake spec<CR>
" nnoremap <leader>tt :!rake test %<CR>

" Tagbar settings
let g:Tlist_Ctags_Cmd='/usr/local/cellar/universal-ctags/HEAD-68da03a/bin/ctags'
let g:tagbar_autofocus=1
let g:tagbar_autoclose=1

 augroup dartfmt
   autocmd!
   autocmd BufWritePre *.dart DartFmt
 augroup END

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
"   Set it to -1 not to overrule hlsearch
let g:limelight_priority = -1

nnoremap <Leader>l <Plug>(Limelight)

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

" goyo
autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" show whitespace
highlight RedundantSpaces ctermbg=red guibg=red
match RedundantSpaces /\s\+$/

"ale
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['tslint'],
\}

"mermaid
autocmd BufNewFile,BufReadPost *.mmd,*.mermaid set filetype=mermaid
au BufReadPost *.mmd set syntax=yaml

" vimwiki
let g:vimwiki_list = [{'path':'~/projects', 'syntax':'markdown', 'ext': '.md' }]
autocmd FileType vimwiki set ft=markdown

" sneak
map f <Plug>Sneak_s
map F <Plug>Sneak_S

"nnoremap <C-J> <C-W><C-J>
"nnoremap <C-K> <C-W><C-K>
"nnoremap <C-L> <C-W><C-L>
"nnoremap <C-H> <C-W><C-H>

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=2
" when indenting with '>', use 4 spaces width
set shiftwidth=2
" On pressing tab, insert 4 spaces
set expandtab

" LSC
let g:lsc_auto_map = v:true
let g:lsc_server_commands = {'dart': 'dart_language_server'}

let g:lsc_auto_map = {
    \ 'GoToDefinition': '<C-]>',
    \ 'GoToDefinitionSplit': ['<C-W>]', '<C-W><C-]>'],
    \ 'FindReferences': 'gr',
    \ 'FindImplementations': 'gI',
    \ 'FindCodeActions': 'ga',
    \ 'Rename': 'gR',
    \ 'ShowHover': v:true,
    \ 'DocumentSymbol': 'go',
    \ 'WorkspaceSymbol': 'gS',
    \ 'SignatureHelp': 'gm',
    \ 'Completion': 'completefunc',
    \}

" coc
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
"
"" Highlight the symbol and its references when holding the cursor.
"autocmd CursorHold * silent call CocActionAsync('highlight')
"
"" Symbol renaming.
"nmap <leader>rn <Plug>(coc-rename)
"
"" Formatting selected code.
"xmap <leader>f  <Plug>(coc-format-selected)
"nmap <leader>f  <Plug>(coc-format-selected)

"flutter
nnoremap <leader>fa :FlutterRun<cr>
nnoremap <leader>fq :FlutterQuit<cr>
nnoremap <leader>fr :FlutterHotReload<cr>
nnoremap <leader>fR :FlutterHotRestart<cr>
nnoremap <leader>fD :FlutterVisualDebug<cr>

"zoom
nnoremap Zz <c-w>_ \| <c-w>\|
nnoremap Zo <c-w>=

syntax on
noswapfile
