set nocompatible
" filetype off

call plug#begin("~/.config/nvim/bundle")
 Plug 'MattesGroeger/vim-bookmarks'
 Plug 'udalov/kotlin-vim'
 " Plug 'craigemery/vim-autotag'
 Plug 'tpope/vim-fugitive'
 Plug 'tpope/vim-rails'
 Plug 'tpope/vim-abolish'
 " Plug 'majutsushi/tagbar'
 Plug 'ludovicchabant/vim-gutentags'
 Plug 'shougo/unite.vim'
 Plug 'shougo/vimfiler.vim'
 Plug 'sbdchd/neoformat'
 Plug 'tibabit/vim-templates'
 Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
 Plug 'junegunn/fzf.vim'
 " typescript formatting
 Plug 'HerringtonDarkholme/yats.vim'
 Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
 " grubox theme
 Plug 'morhetz/gruvbox'
 " code completion
 if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
 else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
 endif
 Plug 'Shougo/neosnippet.vim'
 Plug 'Shougo/neosnippet-snippets'
call plug#end()

" scratch preview
set completeopt-=preview

" fold
set foldmethod=indent 
set nofoldenable

" Plugin key-mappings.
imap <C-j>     <Plug>(neosnippet_expand_or_jump)
smap <C-j>     <Plug>(neosnippet_expand_or_jump)
xmap <C-j>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB>
\ pumvisible() ? "\<C-n>" :
\ neosnippet#expandable_or_jumpable() ?
\    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

let g:neosnippet#snippets_directory = $HOME . '/.config/nvim/neosnips'

" vimfiler
let g:vimfiler_as_default_explorer = 1

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
" nnoremap <C-t> :TagbarToggle<CR>

" unite file explorer
nnoremap <C-e> :VimFiler<CR>

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
nnoremap <C-b> :Buffers<CR>

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
nnoremap <leader>rt :!rspec %<CR>
nnoremap <leader>ra :!rake spec<CR>
nnoremap <leader>tt :!rake test %<CR>

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
augroup tsfmt 
  autocmd!
 autocmd BufWritePre * Neoformat
augroup END

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


"statusline
set statusline =
" Buffer number
set statusline +=[%n]
" File description
set statusline +=%f\ %h%m%r%w
" Filetype
set statusline +=%y                                                  
" Name of the current function (needs taglist.vim)
 set statusline +=\ [Fun(%{Tlist_Get_Tagname_By_Line()})]
" Name of the current branch (needs fugitive.vim)
set statusline +=\ %{fugitive#statusline()}
" Date of the last time the file was saved
set statusline +=\ %{strftime(\"[%d/%m/%y\ %T]\",getftime(expand(\"%:p\")))} 
" Total number of lines in the file
set statusline +=%=%-10L
" Line, column and percentage
set statusline +=%=%-14.(%l,%c%V%)\ %P
