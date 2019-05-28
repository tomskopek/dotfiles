" TODO
" get nice search results with Ags again (see a few lines above and below)
" increase height difference in tmuxmaximizer

" This must be first, because it changes other options as a side effect.
set nocompatible

if has('nvim')
    let s:editor_root=expand("~/.config/nvim")
else
    let s:editor_root=expand("~/.vim")
endif

" source ~/.vimrc.before if it exists.
if filereadable(expand("~/.vimrc.before"))
source ~/.vimrc.before
endif

" ================ Vim-Plug ============================

"auto-install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
" Navigation
Plug 'gabesoft/vim-ags'
" Plug 'tomskopek/vim-ags', {'dir': '~/dev/personal/vim-ags'}
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'tomskopek/tslime.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'
Plug 'vim-scripts/delimitMate.vim'
" Plug 'ervandew/supertab'
Plug 'jeetsukumaran/vim-indentwise'
Plug 'terryma/vim-multiple-cursors'
Plug 'nelstrom/vim-visual-star-search'
Plug 'tpope/vim-rails'
Plug 'alvan/vim-closetag'
" Git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
" Style
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'
Plug 'sickill/vim-monokai'
Plug 'vim-ruby/vim-ruby'
Plug 'pangloss/vim-javascript'
Plug 'jparise/vim-graphql'
Plug 'mxw/vim-jsx'
Plug 'carakan/new-railscasts-theme'
Plug 'morhetz/gruvbox'
Plug 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}
Plug 'junegunn/seoul256.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'ap/vim-css-color'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }

" === deoplete ===
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1

call plug#end()

" ================ General Config ====================

set number relativenumber       "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

"turn on syntax highlighting
if !exists("g:syntax_on")
  syntax enable
endif

" Change leader to a comma because the backslash is too far away
" The mapleader has to be set before vundle starts loading all the plugins.
let mapleader=" "
set timeout timeoutlen=1500

" ================ Colour ===========================

" set t_Co=256
set background=dark

" --- Some nice colorschemes ---

" let g:solarized_termcolors = 256
" colorscheme solarized
" colorscheme monokai
" colorscheme new-railscasts
" colorscheme tomorrow-night-eighties
" colorscheme tomorrow-night-bright

" --- Gruvbox ---

let g:gruvbox_italic=1
let g:gruvbox_contrast_dark='soft'
colorscheme gruvbox
" pink search (with Gruvbox)
hi Search ctermbg=58 ctermfg=9
" change colour of linenumbers (with Gruvbox)
hi LineNr ctermfg=237
" make background completely black (with Gruvbox)
hi Normal ctermbg=none

" --- Seoul256 ---

" let g:seoul256_background = 233
" colo seoul256

" Changes vim splits (?)
hi vertsplit ctermfg=238 ctermbg=235
set fillchars=vert:\ ,stl:\ ,stlnc:\ 

" not sure if this one is useful
" hi NonText ctermbg=none

" --- Limelight/Goyo ---
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================

" Keep undo history across sessions, by storing in file.
if has('persistent_undo') && !isdirectory(expand('~').'/.vim/backups')
silent !mkdir ~/.vim/backups > /dev/null 2>&1
set undodir=~/.vim/backups
set undofile
endif

" ================ Folds ============================

set foldmethod=indent   "fold based on indent
set foldnestmax=5       "deepest fold is 5 levels
set nofoldenable        "dont fold by default

" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ Search ===========================

set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

set list listchars=tab:\ \ ,trail:·  "Display tabs and trailing spaces visually

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
autocmd Filetype javascript setlocal ts=4 sts=4 sw=4

" ================ NERDTree ===============================

nnoremap <C-f> :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>

" automatically quit NERDtree if it's the last buffer
augroup bufenter
  autocmd!
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END

let NERDTreeShowHidden=1

" ================ Commentary =======================================

" Just a note that for react jsx you should add this line:
"
" set commentstring={/*\ %s\ */}
"
" to this file:
"
" /Users/tom/.vim/plugged/vim-jsx/after/ftplugin/jsx.vim

" ================ Prettier =========================================

let g:prettier#config#semi = 'false'

" ================ Fzf with ripgrep =================================
"
" I DONT THINK THIS DOES ANYTHING BECAUSE OF THE VIM PLUGIN

" this was an old command dont know where I got it from but it's different than the below one from JuneGunn
" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
"

" command! -bang -nargs=* Find call fzf#vim#grep('rg --ignore-case'.shellescape(<q-args>), 1, {'options': '-i'}, <bang>0)


"THIS SETUP FROM THE DOCS:
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" ================ Ags/Silver Searcher (searching text) ========================

if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ags_agcontext = 4
  let g:ags_agmaxcount = 500
endif

if has('nvim')
  let g:ags_enable_async = 1
endif

command! -nargs=+ -complete=file -bar Ags silent! grep! <args>|cwindow|redraw!

" bind \ (backward slash) to grep shortcut
nnoremap \ :Ags<SPACE>
" nnoremap <C-c> :echom 'interrupt'<CR>
" nnoremap <C-c> :let g:cancel = 5<CR>
" nnoremap <C-c> :AgsCancelSearch<CR>

" ================ FZF (searching files) =================================

" Enable per-command history.
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_layout = { 'down': '~30%' }

" CtrlP to browse files, -i for ignore case
nnoremap <c-p> :FZF -i<cr>

" CtrlT to browse recent files
nnoremap <c-t> :History<cr>

" CtrlB to browse Buffers
nnoremap <c-b> :Buffers<cr>

" Browse parent directory with Alt+P, -i option for ignore-case
nnoremap π :FZF -i ../<CR>

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" ================ Deoplete ==============================

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" ================ Airline ===============================

" set guifont=Inconsolata-dz_for_Powerline:h11
set laststatus=2
" set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" ================ tslime ================================

vnoremap <Leader>aa "ry :call Send_to_Tmux(@r)<CR>:call Send_to_Tmux("\n")<CR>
nnoremap <Leader>aa viw"ry :call Send_to_Tmux(@r)<CR>:call Send_to_Tmux("\n")<CR>
nnoremap <Leader>AA V"ry :call Send_to_Tmux(@r)<CR>
vnoremap <Leader>ss "ry :call Send_to_Tmux("p.context[:")<CR>:call Send_to_Tmux(@r)<CR>:call Send_to_Tmux("]\n")<CR>
nnoremap <Leader>ss viw"ry :call Send_to_Tmux("p.context[:")<CR>:call Send_to_Tmux(@r)<CR>:call Send_to_Tmux("]\n")<CR>
nmap <Leader>r <Plug>SetTmuxVars

let g:tslime_always_current_session = 1
let g:tslime_always_current_window = 1
let g:tslime_autoset_pane = 1

" ================ Buffers ===============================

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='jellybeans'

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" Note: to find out what these special characters are, you can use 'sed -n l' in the console
" alt + shift + b
nnoremap ı :b#<CR>
" alt + shift + [
nnoremap ” :bprevious<CR>
" alt + shift + ]
nnoremap ’ :bnext<CR>

" To open a new empty buffer
" This replaces :tabnew which I used to bind to this mapping
nnoremap <leader>t :enew<cr>

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nnoremap <leader>x :bp <BAR> bd #<CR>

" ================ Multi cursor ==========================

let g:multi_cursor_use_default_mapping=0
" Default mapping
let g:multi_cursor_next_key='<C-n>'
" let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

" ================ Mouse =================================

set mouse=a

" ================ Copy/Paste ============================

set clipboard=unnamed
" vnoremap <C-c> :.w !pbcopy<CR><CR>
vnoremap <silent> <C-c> :<CR>:let @a=@" \| execute "normal! vgvy" \| let res=system("pbcopy", @") \| let @"=@a<CR>

" ====== Save current view settings on a per-window, per-buffer basis. ====

function! AutoSaveWinView()
    if !exists("w:SavedBufView")
        let w:SavedBufView = {}
    endif
    let w:SavedBufView[bufnr("%")] = winsaveview()
endfunction

" Restore current view settings.
function! AutoRestoreWinView()
    let buf = bufnr("%")
    if exists("w:SavedBufView") && has_key(w:SavedBufView, buf)
        let v = winsaveview()
        let atStartOfFile = v.lnum == 1 && v.col == 0
        if atStartOfFile && !&diff
            call winrestview(w:SavedBufView[buf])
        endif
        unlet w:SavedBufView[buf]
    endif
endfunction

" When switching buffers, preserve window view.
if v:version >= 700
    autocmd BufLeave * call AutoSaveWinView()
    autocmd BufEnter * call AutoRestoreWinView()
endif

" =============== Plug 'terryma/vim-multiple-cursors' ---

function! Multiple_cursors_before()
  if exists(':delimitMateLock')==2
    exe 'delimitMateLock'
  endif
endfunction

function! Multiple_cursors_after()
  if exists(':delimitMateUnlock')==2
    exe 'delimitMateUnlock'
  endif
endfunction

" ================ Close tabs ============================

let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.js'

" ================ Other =================================

" Newline after an open parenthesis
inoremap <C-c> <CR><Esc>O

" " Insert blank lines in normal mode
" " alt + j
" nnoremap <silent>∆ :set paste<CR>m`o<Esc>``:set nopaste<CR>
" " alt + k
" nnoremap <silent>˚ :set paste<CR>m`O<Esc>``:set nopaste<CR>

" stop these from doing things when fingers slip
map q: <nop>
nnoremap Q <nop>
" shift K default is to open a man page for word under cursor
nnoremap K <nop>

" Toggle paste mode
" set pastetoggle=<leader>p


" iabbrev pry require 'pry'; binding.pry
" alt + shift + p
" inoremap ∏ binding.pry
" alt + shift + b
inoremap ı binding.pry
" alt + shift + l
inoremap Ò console.log(
iabbrev dbg debugger;
iabbrev ipdb import ipdb; ipdb.set_trace()
" nnoremap <leader>ev :e $MYVIMRC<CR>
nnoremap <leader>ev :e ~/.vimrc<CR>
nnoremap <leader>sv :source ~/.vimrc<CR>
nnoremap <leader>et :e ~/.tmux.conf<CR>
iabbrev cl. console.log(

" Pull filename into clipboard
nnoremap <silent> <Leader>yf :let @+=expand("%:p")<CR>

" Remove trailing white space
nnoremap <Leader>cw m`:%s/\s\+$//e<CR>``

" Vimscript file settings ---------------------- {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

cnoremap %% <C-R>=expand('%:h').'/'<cr>

