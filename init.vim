set nocompatible
" filetype off

call plug#begin("~/.config/nvim/bundle")
 " explorer
 Plug 'nvim-tree/nvim-web-devicons'
 Plug 'nvim-tree/nvim-tree.lua'
 " markdown
 Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
 " wiki
 Plug 'vimwiki/vimwiki'
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
 " completion
 Plug 'neoclide/coc.nvim'
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
 " rails and ruby
 Plug 'tpope/vim-rails'
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
nnoremap <C-b> :ls<CR>

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
autocmd BufNewFile,BufReadPost *.mmd,*.mermaid set filetype=mermaid
au BufReadPost *.mmd set syntax=yaml

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=2
" when indenting with '>', use 4 spaces width
set shiftwidth=2
" On pressing tab, insert 4 spaces
set expandtab

" coc
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent><expr> <c-space> coc#refresh()


" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType javascript,typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Prettier` command to format current buffer.
" command! -nargs=0 Format :call CocAction('format')
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Use <C-n>, <C-p>, <up> and <down> to navigate completion list: >
inoremap <silent><expr> <C-n> coc#pum#visible() ? coc#pum#next(1) : "\<C-n>"
inoremap <silent><expr> <C-p> coc#pum#visible() ? coc#pum#prev(1) : "\<C-p>"
inoremap <silent><expr> <down> coc#pum#visible() ? coc#pum#next(0) : "\<down>"
inoremap <silent><expr> <up> coc#pum#visible() ? coc#pum#prev(0) : "\<up>"

" Use <C-e> and <C-y> to cancel and confirm completion: >
inoremap <silent><expr> <C-e> coc#pum#visible() ? coc#pum#cancel() : "\<C-e>"
inoremap <silent><expr> <C-y> coc#pum#visible() ? coc#pum#confirm() : "\<C-y>"

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
nnoremap <leader>co :CocList outline<cr>
" nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
nnoremap <leader>cs :CocList -I symbols<cr>

" dbext mysql
" let g:dbext_default_prompt_for_parameters=1
" let g:dbext_default_profile_mysql_local_portal = 'type=MYSQL:user=root:passwd=:dbname=portal_development_master'
" let g:dbext_default_profile_mysql_stage_clare = 'type=MYSQL:user=clare_acct:passwd=Uaaw8fR8UVwphE7RR3bmWMT62bPL6v6CNka48ZYx:host=clare-devdb.sn-ops.com:dbname=clare_accounting'
" let g:dbext_default_profile_mysql_stage_ngin = 'type=MYSQL:user=deploy:passwd=tzGYg46EaQD9pDX8go83KTUznBH66gBRz3PhR9VXc:host=ngin-devdb.sn-ops.com:dbname=ngin'
" let g:dbext_default_profile_mysql_local_ngin = 'type=MYSQL:host=localhost:port=33306:dbname=ngin_development_master'
" let g:dbext_default_profile_mysql_stage_programs = 'type=MYSQL:user=portal_user:passwd=c473H46L69iyWaBgBoczew7L6FrvYXYTL7LiVyGw:host=portal-devdb.sn-ops.com:dbname=portal_production'

" dbext sqlite
" let g:dbext_default_profile_sqlite_for_rails = 'type=SQLITE:dbname=/Users/teddykim/projects/wingate/db/development.sqlite3'

" cursor
set guicursor=i:ver100-iCursor

syntax on
noswapfile

" inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

" coc snippets
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ CheckBackSpace() ? "\<TAB>" :
      \ coc#refresh()

function! CheckBackSpace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" example
nmap <C-s> <Plug>MarkdownPreview
nmap <M-s> <Plug>MarkdownPreviewStop
nmap <C-p> <Plug>MarkdownPreviewToggle

" buffer nav
nnoremap <leader>bp :bprevious<CR>

" explorer
lua << EOF
require'nvim-tree'.setup {
    -- Your configuration here
    -- auto_close = true,  -- Automatically close the tree when it's the last window
}
EOF
nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>
