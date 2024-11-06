" =============================================================================
" Options
" =============================================================================

" LANGUAGE
set encoding=UTF-8
" Spelling configuration abide to the ISO 639 language codes form
set spelllang=en_gb,de_de,es_es,pt_br,fr_fr,it_it

set nohlsearch      " Disable highlight on search
set nocompatible    "
set undofile        " Save undo history
set ignorecase      " Case-insensitive searching unless \C or capital in search
set smartcase       " Enable smart case
set updatetime=250  " Decrease update time
set timeoutlen=300  " Time to wait for mapped sequence to complete in ms
" set nobackup
" set nowritebackup
" set mouse=a
set completeopt=menuone,noselect " Better completion XP
set whichwrap+=<,>,[,],h,l " Allow certain keys to move to the next line
set nowrap          " Display long lines as one line
set scrolloff=8     " Keep 8 lines above/below cursor
set sidescrolloff=8 " Keeb 8 columns to the left/right of cursor

" GENERAL TEXT SETTINGS
set number          " Enable line numbers
set relativenumber  " Use relative line numbers
set signcolumn=yes  " Keep signcolumn on by default
set linebreak       " Do not break words when wrapping
set autoindent      " Enable automated indentation on new lines 
set breakindent     " Enable break indent
set smartindent     " Enable smart indentation
set numberwidth=4   " Set number of column width
set shiftwidth=2    " Spaces per indentation
set tabstop=2       " Spaces per tab
set softtabstop=2   " Spaces per tab during editing ops
set expandtab       " Convert tabs to spaces
set nocursorline    " Do not highlight the current line
set showtabline=2   " Always show tab line
set conceallevel=0  " Make `` visible in Markdown
set showmatch       " Show matching part of brackets

" TERMINAL WINDOW
set splitbelow      " Enable horizontal splits below current window
set splitright      " Enable vertical splits to the right of current window
set cmdheight=1     " Command line height
set laststatus=2    " Show status bari
set statusline=
"set statusline+=%#PmenuSel#
set statusline+=%F   " Show path to the file
"set statusline+=%#LineNr#
set statusline+=
set statusline+=%=  " Switch status to the right side
set statusline+=\ 
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\   " Set empty string
set statusline+=\[%{&fileformat}\]
set statusline+=\   " Set empty string
set statusline+=%c  " Display column position of cursor
set statusline+=\   " Set empty string
set statusline+=\|  " Pipe as line separator
set statusline+=\   " Set empty string 
set statusline+=%l  " Current line
set statusline+=/   " Set separator
set statusline+=%L  " Display total number of lines

" KEY INPUT BEHAVIOUR
set backspace=indent,eol,start " Configurable backspace behaviour

" FILE
set fileencoding=utf-8 " Set file encoding to UTF-8

" COMMANDS
set iskeyword+=-    " Treat hyphenated words as whole words

" =============================================================================
" Keymaps
" =============================================================================

" Set leader key
let mapleader = " "
let maplocalleader = " "

" Disable the spacebar key's default behaviour in Normal and Visual modes
nnoremap <Space> <Nop>
vnoremap <Space> <Nop>

" Allow moving the cursor through wrapped lines with j, k
nnoremap <expr> k v:count == 0 ? 'gk' : 'k'
nnoremap <expr> j v:count == 0 ? 'gj' : 'j'

" Clear highlights
nnoremap <Esc> :noh<CR>

" Save file
nnoremap <C-s> :w<CR>

" Save file withouth auto-formatting
nnoremap <leader>sn :noautocmd w<CR>

" Quit file
nnoremap <C-q> :q<CR>

" Delete single character without copying into register
nnoremap x "_x

" Vertical scroll and centre
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Find and centre
nnoremap n nzzzv
nnoremap N Nzzzv

" Resize with arrows
nnoremap <Up> :resize -2<CR>
nnoremap <Down> :resize +2<CR>
nnoremap <Left> :vertical resize -2<CR>
nnoremap <Right> :vertical resize +2<CR>

" Navigate buffers
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
nnoremap <leader>sb :buffers<CR>:buffer<Space>

" Increment/Decrease numbers
"nnoremap <leader>+ <C-a>
"nnoremap <leader>- <C-x>

" Window management
nnoremap <leader>v <C-w>v
nnoremap <leader>h <C-w>s
nnoremap <leader>se <C-w>=
nnoremap <leader>xs :close<CR>

" Navigate between splits
nnoremap <C-k> :wincmd k<CR>
nnoremap <C-j> :wincmd j<CR>
nnoremap <C-h> :wincmd h<CR>
nnoremap <C-l> :wincmd l<CR>

" Tabs
nnoremap <leader>to :tabnew<CR>
nnoremap <leader>tx :tabclosw<CR>
nnoremap <leader>tn :tabn<CR>
nnoremap <leader>tp :tabp<CR>

nnoremap <leader>x :bdelete<CR>
nnoremap <leader>b :enew<CR>

" Toggle line wrapping
nnoremap <leader>lw :set wrap!<CR>

" Press jk fast to exit insert mode
inoremap jk <ESC>
inoremap kj <ESC>

" Keep last yanked when pasting
vnoremap p "_dP

" Explicitly yank to system clipboard (highlighted an entire row)
noremap <leader>y "+y
noremap <leader>Y "+Y

" Open file explorer
noremap <silent> <leader>e :Lex<CR>

" =============================================================================
" Other
" =============================================================================

" Syntax highlighting
syntax on

" Colour scheme
" colorscheme industry
"colorscheme wildcharm
"set background=dark

" Sync clipboard with OS
if system('uname -s') == "Linux\n"
  set clipboard=unnamedplus "Linux
else
  set clipboard=unnamed "OSX
endif

" True colours
if !has('gui_running') && &term =~ '\%(screen\|tmux\)'
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
set termguicolors

" Use a line cursor within insert mode and a block cursor everywhere else
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" Netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

augroup netrw_setup | au!
  au FileType netrw nmap <buffer> l <CR>
augroup END

