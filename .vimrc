" VUNDLE SETUP
" =============================================================================
filetype off
set nocompatible

if has("win32")
  set rtp+=~/vimfiles/bundle/Vundle.vim/
  let path='~/vimfiles/bundle'
  call vundle#begin(path)
else
  set rtp+=~/.vim/bundle/Vundle.vim
  call vundle#begin()
endif

" PLUGINS
" =============================================================================
" Vundle
Plugin 'gmarik/Vundle.vim'

" Use the the . operator with plugin commands
Plugin 'tpope/vim-repeat'

" Wrapper for Git on Vim commandline
Plugin 'tpope/vim-fugitive'

" Add, change, and delete delimiters
Plugin 'tpope/vim-surround'

" Edit several things at once with multiple cursors
Plugin 'terryma/vim-multiple-cursors'

" Expand the current visual selection
Plugin 'terryma/vim-expand-region'

" Vastly enhanced movement controls
Plugin 'Lokaltog/vim-easymotion'

" Emmet HTML editing
Plugin 'mattn/emmet-vim'

" Use <Tab> for autocompletion
Plugin 'ervandew/supertab'

" Execute external command
Plugin 'Shougo/vimproc.vim'

" Crazy unified search interface
Plugin 'Shougo/unite.vim'

" Puppet syntax support
Plugin 'puppetlabs/puppet-syntax-vim'

" HTML5 syntax support
Plugin 'othree/html5.vim'

" Sass syntax support
Plugin 'cakebaker/scss-syntax.vim'

" CSS3 syntax support
Plugin 'JulesWang/css.vim'

" JavaScript syntax improved
Plugin 'jelera/vim-javascript-syntax'
Plugin 'othree/javascript-libraries-syntax.vim'

" PHP syntax improved
Plugin 'StanAngeloff/php.vim'
Plugin 'shawncplus/phpcomplete.vim'

" Racket syntax support
Plugin 'wlangstroth/vim-racket'

" Extra syntax
Plugin 'justinmk/vim-syntax-extra'

" Solarized color scheme
Plugin 'altercation/vim-colors-solarized'

call vundle#end()

" CONFIG
" =============================================================================

" Unite
" -----
let g:unite_force_overwrite_statusline = 0
let g:unite_source_rec_min_cache_files = 10
let g:unite_source_rec_max_cache_files = 100000

call unite#custom#profile('default', 'context', {
      \ 'prompt' : '› ',
      \ 'prompt_visible' : 1,
      \ 'auto_resize' : 1,
      \ 'start_insert' : 1,
      \ 'hide_source_names' : 1,
      \ 'sync' : 1,
      \ })
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])

nnoremap <silent> <C-K>b :Unite
      \ buffer
      \ -buffer-name=buffers
      \ <CR>

nnoremap <silent> <C-K>c :Unite
      \ command
      \ -buffer-name=commands
      \ <CR>

nnoremap <silent> <C-K>f :Unite
      \ file
      \ file_rec/git:--cached:--exclude-standard
      \ -buffer-name=files
      \ <CR>

nnoremap <silent> <C-K>g :Unite
      \ vimgrep
      \ -buffer-name=find
      \ <CR>

augroup Unite
  autocmd FileType unite call s:unite_settings()
augroup END

function! s:unite_settings()
  set statusline=%t
  nmap <buffer> <Esc>   <Plug>(unite_exit)
  imap <buffer> <Esc>   <Plug>(unite_exit)
  imap <buffer> <Tab>   <Plug>(unite_select_next_line)
  imap <buffer> <S-Tab> <Plug>(unite_select_previous_line)
  imap <buffer> <C-J>   <Plug>(unite_select_next_line)
  imap <buffer> <C-K>   <Plug>(unite_select_previous_line)
endfunction

" SuperTab
" --------
let g:SuperTabLongestHighlight = 1
let g:SuperTabLongestEnhanced = 1
let g:SuperTabCrMapping = 1
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = '<C-P>'
let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
let g:SuperTabContextDiscoverDiscovery = ["&omnifunc:<C-X><C-O>"]

augroup SuperTab
  autocmd Filetype * call UserSuperTabChain()
augroup END

function UserSuperTabChain()
  if &omnifunc != ''
    call SuperTabChain(&omnifunc, '<C-P>')
  endif
endfunction

" Vim Multiple Cursors
" --------------------
let g:multi_cursor_exit_from_visual_mode = 0
let g:multi_cursor_exit_from_insert_mode = 0
let g:multi_cursor_normal_maps = {
      \ 'd' : 1,
      \ 'c' : 1,
      \ 'r' : 1,
      \ 'x' : 1,
      \ }

" Vim Expand Region
" -----------------
let g:expand_region_text_objects = {
      \ 'i]' : 1,
      \ 'ib' : 1,
      \ 'iB' : 1,
      \ 'it' : 1,
      \ 'at' : 1,
      \ }

" Vim EasyMotion
" --------------
" Prompt
let g:EasyMotion_prompt = '→ '
" Press enter to jump to first match
let g:EasyMotion_enter_jump_first = 1
" Vertical motions attempt to stay in current column
let g:EasyMotion_startofline = 0

" Map EasyMotion prefix to <Leader>
map <Leader> <Plug>(easymotion-prefix)
" EasyMotion for downward line motion
map <Leader>j <Plug>(easymotion-j)
" EasyMotion for upward line motion
map <Leader>k <Plug>(easymotion-k)
" Two character search
nmap s <Plug>(easymotion-s2)
nmap t <Plug>(easymotion-t2)
" EasyMotion search
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
" EasyMotion next/prev
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

" SYNTAX
" =============================================================================
syntax on
filetype plugin indent on

" FILETYPES
" =============================================================================
augroup filetypes
  autocmd BufNewFile,BufReadPre *.inc set filetype=php
  autocmd BufNewFile,BufReadPre *.install set filetype=php
augroup END

" ENCODING
" =============================================================================
" Default character encoding
set encoding=utf-8
" Default file encoding
set fileencoding=utf-8
" File encoding hints
set fileencodings=utf-8,latin1,usc-bom
" Possible end of line formats
set fileformats=unix,mac,dos

" FORMATTING
" =============================================================================
" Convert tabs to spaces
set expandtab
" Tabs are equal to 2 columns
set tabstop=2
" Reindent operations use 2 columns per tab
set shiftwidth=2
" Number of columns per tab in insert mode
set softtabstop=2
" Allow backspace to remove indentation, end-of-line, and insert positions
set backspace=indent,eol,start
" Auto indentation
set autoindent
" Disable visual text wrap
set nowrap

" EDITING
" =============================================================================
" Map <Leader> to <SPACE>
map <SPACE> <Leader>
" Hide buffers instead of close them, allowing switching before saving
set hidden
" Set reasonable timout
set timeoutlen=2000
" Eliminate timeout when pressing <Esc>
set ttimeoutlen=0

" APPEARANCE
" =============================================================================
" Tell vim that the background is dark
set background=dark
" Solarized color scheme
try
  colorscheme solarized
catch
  colorscheme default
endtry

" UI
" =============================================================================
" Remove splash text
set shortmess+=I
" Line numbers
set number
" Always show command bar
set showcmd
" Always show edit mode
set showmode
" Highlight the currnet line
set cursorline
" Always show status line
set laststatus=2
" Disable the fold column to the left of line numbers
set foldcolumn=0
" Highlight matching braces
set showmatch
" Disable audible bell
set noerrorbells
" Disable visual bell
set novisualbell
" Autocomplete, match longest substring, always show menu
set completeopt=longest,menu
" Display diff filler lines, always vertical split
set diffopt=filler,vertical
" Display at least one line between cursor and horizontal window borders
set scrolloff=1
" Display unwanted characters
set list
set listchars=tab:›\ ,trail:·,nbsp:+
" Turn on wildmenu
set wildmenu
" Activate wildmenu with <TAB>
set wildchar=<TAB>
" Show wildmenu list
set wildmode=full
" Open new splits to the right
set splitright

" STATUSLINE
" =============================================================================
" Filename tail
set statusline=%t
" Filetype
set statusline+=\ %y
" Buffer number
set statusline+=\ #%n
" Separator
set statusline+=%=
" Modified
set statusline+=%3m
" Line number
set statusline+=\ %3l:
" Column number
set statusline+=%c
" Percentage of file
set statusline+=\ %P
" Total lines
set statusline+=\ (%L)

" SEARCH
" =============================================================================
" Incremental search, highlight for each character typed
set incsearch
" Assume global search by default
set gdefault
" Use <C-L> to clear last search hilight
nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
" Use very magic regular expressions for search and replace
cnoremap %s/ %smagic/

" PERFORMANCE
" =============================================================================
" Defer redraws for improved performance; with ttyfast, this buffers output
set lazyredraw
" Increase number of characters sent to terminal at once
set ttyfast

" BACKUP
" =============================================================================
" Disable annoying backup/swap files
set nobackup
set nowritebackup
set noswapfile
