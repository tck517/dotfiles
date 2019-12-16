set nocompatible
" filetype off

call plug#begin("~/.config/nvim/bundle")
" markdown previewers
 Plug 'FuDesign2008/mermaidViewer.vim'
 Plug 'shime/vim-livedown'
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
 " test runner
 Plug 'janko/vim-test'
 " bookmarks
 Plug 'MattesGroeger/vim-bookmarks'
 " git
 Plug 'tpope/vim-fugitive'
 " rails and ruby
 Plug 'tpope/vim-rails'
 " tags
 Plug 'craigemery/vim-autotag'
 Plug 'majutsushi/tagbar'
 Plug 'ludovicchabant/vim-gutentags'
 " file management
 Plug 'shougo/unite.vim'
 Plug 'shougo/vimfiler.vim'
 " formatting
 Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
 " Plug 'sbdchd/neoformat'
 " file templates
 Plug 'tibabit/vim-templates'
 " fuzzy finder
 Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
 Plug 'junegunn/fzf.vim'
 " typescript formatting
 Plug 'Quramy/tsuquyomi'
 Plug 'HerringtonDarkholme/yats.vim'
 Plug 'leafgarland/typescript-vim'
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

" fold
set foldmethod=indent
set nofoldenable

let test#strategy = "neovim"

" tabs
nnoremap <C-t> :tabclose<CR>

" test runner
nnoremap t<C-n> :TestNearest<CR>
nnoremap t<C-f> :TestFile<CR>
nnoremap t<C-s> :TestSuite<CR>
nnoremap t<C-l> :TestLast<CR>
nnoremap t<C-g> :TestVisit<CR>

" Plugin key-mappings.
imap <C-j> <Plug>(neosnippet_expand_or_jump)
smap <C-j> <Plug>(neosnippet_expand_or_jump)
xmap <C-j> <Plug>(neosnippet_expand_target)

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

" window zooming
nnoremap Zz <c-w>_ \| <c-w>\|
nnoremap Zo <c-w>=

" deoplete
let g:deoplete#enable_at_startup = 1

" mapleader
let mapleader = "_"

" tag search
" set tags=./tags

" open tag in another window
" nnoremap <C-]> <Esc>:exe "ptjump " . expand("<cword>")<Esc>

" open tag in vertical split
" map <C-\> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" option-t open tagbar
nnoremap <C-t> :TagbarToggle<CR>

" unite file explorer
nnoremap <C-e> :VimFiler<CR>
nnoremap <C-x> :VimFilerExplorer<CR>

" highlight search
nnoremap <C-h> :set hlsearch!<CR>

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

" ultisnips
" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<c-b>"
" let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" Tagbar settings
" let g:Tlist_Ctags_Cmd='/usr/local/Cellar/ctags/5.8_1/bin/ctags'
" let g:tagbar_autofocus=1
" let g:tagbar_autoclose=1

" deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#omni_patterns = {}
let g:deoplete#omni_patterns.java = '[^. *\t]\.\w*'
let g:deoplete#sources = {}
let g:deoplete#sources._ = []
let g:deoplete#file#enable_buffer_path = 1

" neoformat
 " augroup fmt
 "   autocmd!
 "  autocmd BufWritePre * undojoin | Neoformat
 " augroup END

" augroup dartfmt
"   autocmd!
"   autocmd BufWritePre *.dart DartFmt
" augroup END

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=2
" when indenting with '>', use 4 spaces width
set shiftwidth=2
" On pressing tab, insert 4 spaces
" set expandtab

" scheme
colorscheme gruvbox
set background=dark


" statusline
set statusline =
" Buffer number
set statusline +=[%n]
" File description
set statusline +=%f\ %h%m%r%w
" Filetype
set statusline +=%y
" gutentag status
set statusline +=%{gutentags#statusline()}"
" Name of the current branch (needs fugitive.vim)
set statusline +=\%{fugitive#statusline()}
" Date of the last time the file was saved
set statusline +=\%{strftime(\"[%d/%m/%y\ %T]\",getftime(expand(\"%:p\")))}
" Total number of lines in the file
set statusline +=%=%-10L
" Line, column and percentage
set statusline +=%=%-14.(%l,%c%V%)\ %P

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
let g:limelight_paragraph_span = 1

" Beginning/end of paragraph
"   When there's no empty line between the paragraphs
"   and each paragraph starts with indentation
let g:limelight_bop = '^\s'
let g:limelight_eop = '\ze\n^\s'

" Highlighting priority (default: 10)
"   Set it to -1 not to overrule hlsearch
let g:limelight_priority = -1

nnoremap <Leader>l <Plug>(Limelight)

function! s:goyo_enter()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status off
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  endif
  set noshowmode
  set noshowcmd
  set scrolloff=999
  Limelight
endfunction

function! s:goyo_leave()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status on
    silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  endif
  set showmode
  set showcmd
  set scrolloff=5
  Limelight!
endfunction

" fix deoplete match message
if has("patch-7.4.314")
  set shortmess+=c
endif

" limelight
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'

" Default: 0.5
let g:limelight_default_coefficient = 0.7

" Number of preceding/following paragraphs to include (default: 0)
let g:limelight_paragraph_span = 1

" Beginning/end of paragraph
"   When there's no empty line between the paragraphs
"   and each paragraph starts with indentation
let g:limelight_bop = '^\s'
let g:limelight_eop = '\ze\n^\s'

" Highlighting priority (default: 10)
"   Set it to -1 not to overrule hlsearch
let g:limelight_priority = -1

" goyo
autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" mermaid
" autocmd BufNewFile,BufReadPost *.mmd,*.mermaid set filetype=mermaid

" show whitespace
highlight RedundantSpaces ctermbg=red guibg=red
match RedundantSpaces /\s\+$/

let g:tagbar_type_typescript = {
  \ 'ctagsbin' : 'tstags',
  \ 'ctagsargs' : '-f-',
  \ 'kinds': [
    \ 'e:enums:0:1',
    \ 'f:function:0:1',
    \ 't:typealias:0:1',
    \ 'M:Module:0:1',
    \ 'I:import:0:1',
    \ ':interface:0:1',
    \ 'C:class:0:1',
    \ 'm:method:0:1',
    \ 'p:property:0:1',
    \ 'v:variable:0:1',
    \ 'c:const:0:1',
  \ ],
  \ 'sort' : 0
\ }

let g:prettier#autoformat = 0
autocmd BufWritePre *.ts,*.js,*.json,*.css,*.scss,*.less,*.graphql Prettier
