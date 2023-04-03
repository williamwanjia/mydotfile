" Plugin settings----------------------------------------------------|

" Specify a directory for plugins
" " - For Neovim: ~/.local/share/nvim/plugged
" " - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.nvim/plugged')
"
" " Make sure you use single quotes
"
" " Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
" Plug 'junegunn/vim-easy-align'
"
" " Any valid git URL is allowed
" Plug 'https://github.com/junegunn/vim-github-dashboard.git'
"
" " Multiple Plug commands can be written in a single line using | separators
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
"
" " On-demand loading
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
"
" " Using a non-master branch
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
"
" " Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
" Plug 'fatih/vim-go', { 'tag': '*' }
"
" " Plugin options
" Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
"
" " Plugin outside ~/.vim/plugged with post-update hook
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"
" " Unmanaged plugin (manually installed and updated)
" Plug '~/my-prototype-plugin'


" For braces
Plug 'frazrepo/vim-rainbow'

" VimWIKI
Plug 'https://github.com/vimwiki/vimwiki'

" For git branch information
Plug 'https://github.com/tpope/vim-fugitive'

" Use ranger to open file
Plug 'francoiscabrol/ranger.vim'

" File explorer
Plug 'https://github.com/preservim/nerdtree'

" Auto commenter
Plug 'https://github.com/scrooloose/nerdcommenter'

" A light and configurable statusline/tabline plugin for Vim
" Plug 'https://github.com/itchyny/lightline.vim'

" reST plugin 
" Plug 'https://github.com/gu-fan/riv.vim'

" Markdown plugin
" Plug 'godlygeek/tabular'
" Plug 'plasticboy/vim-markdown'

" syntax highlight
Plug 'https://github.com/sheerun/vim-polyglot'

" for python
" Plug 'https://github.com/Valloric/YouCompleteMe'
" In 2020-04, YouCompleteMe became very slow, so tried this one
" Still slow
" Plug 'davidhalter/jedi-vim'
" Plug 'deoplete-plugins/deoplete-jedi'
" Plug 'https://github.com/ajh17/VimCompletesMe'

" Color theme

" Code check
" Plug 'https://github.com/w0rp/ale'

"rsT preview
" Plug 'https://github.com/gu-fan/InstantRst'

"Tagbar for code outline
Plug 'https://github.com/majutsushi/tagbar'

" Intellisense engine
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Auto-close braces and scopes
Plug 'jiangmiao/auto-pairs'

" A cool status bar
Plug 'vim-airline/vim-airline'
" Airline themes
Plug 'vim-airline/vim-airline-themes'
" Nord
Plug 'arcticicestudio/nord-vim'

" Testing plugins
"

"
" Initialize plugin system
call plug#end()
" END of Plugin setting---------------------------------------------|
"

" URL: http://vim.wikia.com/wiki/Example_vimrc
" Authors: http://vim.wikia.com/wiki/Vim_on_Freenode
" Description: A minimal, but feature rich, example .vimrc. If you are a
"              newbie, basing your first .vimrc on this file is a good choice.
"              If you're a more advanced user, building your own .vimrc based
"              on this file is still a good idea.
 
"------------------------------------------------------------
" Features {{{1
"
" These options and commands enable some very useful features in Vim, that
" no user should have to live without.
 
" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible
 
" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on
 
" Enable syntax highlighting
syntax on
 
 
"------------------------------------------------------------
" Must have options {{{1
"
" These are highly recommended options.
 
" Vim with default settings does not allow easy switching between multiple files
" in the same editor window. Users can use multiple split windows or multiple
" tab pages to edit multiple files, but it is still best to enable an option to
" allow easier switching between files.
"
" One such option is the 'hidden' option, which allows you to re-use the same
" window and switch from an unsaved buffer without saving it first. Also allows
" you to keep an undo history for multiple files when re-using the same window
" in this way. Note that using persistent undo also lets you undo in multiple
" files even in the same window, but is less efficient and is actually designed
" for keeping undo history after closing Vim entirely. Vim will complain if you
" try to quit without saving, and swap files will keep you safe if your computer
" crashes.
set hidden
 
" Note that not everyone likes working this way (with the hidden option).
" Alternatives include using tabs or split windows instead of re-using the same
" window as mentioned above, and/or either of the following options:
" set confirm
" set autowriteall
 
" Better command-line completion
set wildmenu
 
" Show partial commands in the last line of the screen
set showcmd
 
" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch
 
" Modelines have historically been a source of security vulnerabilities. As
" such, it may be a good idea to disable them and use the securemodelines
" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
" set nomodeline
 
 
"------------------------------------------------------------
" Usability options {{{1
"
" These are options that users frequently set in their .vimrc. Some of them
" change Vim's behaviour in ways which deviate from the true Vi way, but
" which are considered to add usability. Which, if any, of these options to
" use is very much a personal preference, but they are harmless.
 
" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase
 
" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start
 
" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent
 
" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline
 
" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler
 
" Always display the status line, even if only one window is displayed
set laststatus=2
 
" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm
 
" Use visual bell instead of beeping when doing something wrong
" set visualbell
 
" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
" set t_vb=

" The vim start to show some thing like >4;2m. Add following two lines
" solve the problem 
" let &t_TI = ""
" let &t_TE = ""


" Enable use of the mouse for all modes
set mouse=a
 
" Set the command window height to 2 lines, to avoid many cases of having to
" 'press <Enter> to continue'
set cmdheight=2
 
" Display line numbers on the left
" Using hybrid mode
set number relativenumber
 
" Quickly time out on keycodes, but never time out on mappings
" set notimeout ttimeout ttimeoutlen=200
 
" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>
 
 
"------------------------------------------------------------
" Indentation options {{{1
"
" Indentation settings according to personal preference.
 
" Indentation settings for using 4 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set shiftwidth=4
set softtabstop=4
set expandtab

autocmd FileType cpp setlocal shiftwidth=2 softtabstop=2

" Indentation settings for using hard tabs for indent. Display tabs as
" four characters wide.
"set shiftwidth=4
"set tabstop=4
 
 
"------------------------------------------------------------
" Mappings {{{1
"
" Useful mappings
 
" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$
 
" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap cl :nohl<CR><C-L>

map <S-h> :tabprevious<CR>
map <S-l> :tabnext<CR>

map <F4> :set spell<CR> :syntax spell toplevel<CR>
map <F5> :set nospell<CR>

" when your cursor moves over a parenthesis-like character, the matching one
" will be highlighted as well.
set showmatch

set spelllang=en_us


" Plugins configuration---------------------------------------------|

let g:rainbow_active = 1

" VimWIKI

let g:vimwiki_list = [{'path': '~/Documents/myrepos/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

" lightline
" function! CountBuffer()
"     return len(getbufinfo({'buflisted':1}))
" endfunction
"
" let g:lightline = {
"       \ 'colorscheme': 'wombat',
"       \ 'active': {
"       \   'left': [ [ 'mode', 'paste', 'Nbuf' ],
"       \             [ 'readonly', 'filename', 'modified' ] ]
"       \ },
"       \ 'component_function': {
"       \   'gitbranch': 'FugitiveHead',
"       \   'Nbuf': 'CountBuffer'
"       \ },
"       \ }


" autocmd vimenter * NERDTree

set spellfile=~/.vim/spell/en.utf-8.add
set cursorline

syntax spell toplevel

" Color
set background=dark
" Italics for my favorite color scheme
" let g:palenight_terminal_italics=1

colorscheme nord

set termguicolors " if you want to run vim in a terminal


nmap <F8> :TagbarToggle<CR>
let g:tagbar_sort = 0
let g:tagbar_width = 40

set foldmethod=indent

" Setting for NERD Commenter --------------------------------------------\
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following
" code indentation
let g:NERDDefaultAlign = 'left'

" Allow commenting and inverting empty lines (useful when commenting a
" region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented
" or not 
let g:NERDToggleCheckAllLines = 1

" END of setting for NERD -----------------------------------------------/ 

" Set spell check highlight
:hi SpellBad cterm=underline ctermfg=red

" setting for column wide
set colorcolumn=+1

set textwidth=79
" set formatoptions+=a
"
"


let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 30
" augroup ProjectDrawer
"  autocmd!
"  autocmd VimEnter * :Vexplore
" augroup END

nmap gb :ls<cr>:b<space>
nmap gn :bn<cr>
nmap gp :bp<cr>

nmap Bd :bn<cr>:bd #<cr>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


let mapleader = ","

nmap <Leader>ll :set tw=79<cr>
nmap <Leader>li :set tw=999<cr>
nmap <Leader>ls :set tw=72<cr>

nnoremap <C-t> :NERDTreeToggle<CR>

if &term =~ '256color'
    " disable Background Color Erase (BCE) so that color schemes
    " render properly when inside 256-color tmux and GNU screen.
    " see also http://sunaku.github.io/vim-256color-bce.html
    set t_ut=
endif

" To show all characters
" :set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
" :set list

" For Python self
match Keyword /self/

" To show a buffer line 
let g:airline#extensions#tabline#enabled = 1


" --------------------------------------------------------
" SETTINGS START

set completeopt=longest,menuone

" SETTINGS END
" --------------------------------------------------------

" --------------------------------------------------------
" COC-VIM TAB SETTINGS START

let g:coc_global_extensions = ['coc-jedi']
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"
" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction
"
" " Use <c-space> to trigger completion.
" if has('nvim')
"   inoremap <silent><expr> <c-space> coc#refresh()
" else
"   inoremap <silent><expr> <c-@> coc#refresh()
" endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
" if exists('*complete_info')
"   inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
" else
"   inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" endif

" COC-VIM TAB SETTINGS END
" --------------------------------------------------------
