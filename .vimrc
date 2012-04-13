"============= Runtime Stuff =============

set nocompatible
"runtime! debian.vim

" use Inconsolata unless overriden
set gfn=Inconsolata\ Medium\ 12

" windows stuff (ignore on Linux)
if has('win32')
	set gfn=Consolas:h10:cANSI 					" when on Windows use Consolas
elseif has('mac')
	set gfn=Monaco\ 10 							" use the Monaco font when on Mac
endif

"============= Key Mappings ============= 

" press ; to issue commands in normal mode (no more shift holding)
nnoremap ; :

" move by screen lines, not by real lines - great for creative writing
nnoremap j gj
nnoremap k gk

" also in visual mode
vnoremap j gj
vnoremap k gk

" run ctags on current directory recursively
nnoremap <f6> :!ctags -R<cr>

" pressing \<space> clears the search highlights
nmap <silent> <leader><space> :nohlsearch<CR> 

" break a line at cursor 
nnoremap <silent> <leader><CR> i<CR><ESC>

" make a markdown heading
nnoremap <silent> <leader>h YpVr=

" insert a blank line with <leader>o and <leader>O
nnoremap <silent> <leader>o o<ESC>
nnoremap <silent> <leader>O O<ESC>


" use jj to quickly escape to normal mode while typing 
inoremap jj <ESC>

" toggle paste mode (to paste properly indented text)
nnoremap <F3> :set invpaste paste?<CR>
set pastetoggle=<F3>
set showmode

" run current PHP file through php interpreter
:autocmd FileType php noremap <leader>p :w!<CR>:!php %<CR>
" run current PHP file through php linter (syntax check) check
:autocmd FileType php noremap <leader>l :!php -l %<CR>

" use \y and \p to copy and paste from system clipboard
noremap <leader>y "+y
noremap <leader>Y "+Y
noremap <leader>p "+p

" automatically jump to last misspelled word and attempt replacing it
noremap <leader>ss [sz=
noremap <leader>aa [sz=1<cr><cr>

" use Ctrl+L in insert mode to correct last misspelled word
inoremap <C-l> <esc>[sz=

" Ctrl+Backspace deletes last word
inoremap <C-BS> <esc>bcw

" open my vimrc in a split
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" now source it
nnoremap <leader>sv :source $MYVIMRC<cr>

" surround the current word with quotes
nnoremap <leader>' ea"<esc>bi"<esc>e

" run current buffer through markdown converter
" you should have the Markdown.pl in your .vim directory for convenience
if filereadable($HOME."/.vim/Markdown.pl")
	" make this binding active only in html and markdown files
	" note that you only need the exe because $HOME does not properly expand
	" on windows.
	autocmd FileType html,htm,mkd,markdown nnoremap <leader>md :exe "%! ".$HOME."/.vim/Markdown.pl --html4tags"<cr>
else
	echom "Warning: Markdown.pl not found - <leader>md not set for HTML and MKD files."
endif

" use regular regex syntax rather than vim regex
nnoremap / /\v
vnoremap / /\v

"============= Command Aliases =============

" for when you mess up and hold shift too long (using ! to prevent errors while 
" sourcing vimrc after it was updated)
command! W w
command! WQ wq
command! Wq wq
command! Q q

"============= Buffers =============

set hidden 	" buffers can exist in background without being in a window

"============= Spell Check =============

set spell 		"enable in-line spell check
set spelllang=en

"============= Line Numbers =============

" Line numbers (set relative in 7.3 because it's useful); 
" Fall back to absolute if 7.2 and lower
if v:version >= 730
	set rnu 	" if version 7.3 set relative line numbers
else
	set nu		" otherwise set absolute, because there is no rnu
endif

set cul		" highlight cursor line 
set paste	" pasting with auto-indent

" toggle between relative and absolute line numbers
function! g:ToggleNuMode()
	if(&rnu == 1)
		set nu
	else
		set rnu
	endif
endfunc

" map the above function to F5
nnoremap <f5> :call g:ToggleNuMode()<cr>

"============= Scrolling =============

" show line and column markers
set cursorline
set cursorcolumn

" highlight column 80
set colorcolumn=80

set scrolloff=3	" 3 line offset when scrolling

"============= Formatting, Indentation & Behavior =============

" enable soft word wrap
set formatoptions=l
set lbr

" use hard tabs for indentation
set shiftwidth=4
set tabstop=4
set noexpandtab 	" don't expand tabs to spaces (cause fuck that)

au FocusLost * silent! :wa	" save when switching focus 

"============= Search & Matching =============

set showcmd			" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching

set incsearch		" incremental search
set hlsearch		" highlights searches

set noerrorbells 	" suppress audible bell
set novisualbell 	" suppress bell blink

"============= History =============

" save more in undo history
set history=1000
set undolevels=1000


if v:version >= 730
	set undofile        " keep a persistent backup file
endif


"============= Misc =============

set autowrite		" Automatically save before commands like :next and :make
set mouse=a			" Enable mouse usage (all modes) in terminals

" sudo save file with w!
cmap w!! w !sudo tee % >/dev/null

"=========== Syntax Highlighting & Indents ==============
syntax on
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on

set autoindent 		" always indent
set copyindent 		" copy previous indent on autoindenting
set smartindent

set backspace=indent,eol,start 	" backspace over everything in insert mode

" ============== Status Line ==============

set ls=2 			" Always show status line
set laststatus=2

"============== Folding ==============

set nofoldenable 	" screw folding

"set foldmethod=indent
"set foldnestmax=3
"set foldenable

"============== Completion ==============

set wildmenu
set wildmode=list:longest
set wildignore=*.swp,*.bak,*.pyc,*.class,*.o,*.obj,*~

" longer more descriptive auto-complete prompts
set completeopt=longest,menuone
set ofu=syntaxcomplete#Complete

"============== Swap Files ==============

set noswapfile 		" suppress creation of swap files
set nobackup 		" suppress creation of backup files
set nowb 			" suppress creation of ~ files

"============== Misc ==============

" force txt files to be highlighted as html
au BufRead,BufNewFile *.txt setfiletype html

" force php files to be treated as php/html - necessary for snipmate to work
au BufRead,BufNewFile *.php set filetype=php.html

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

"============== Pathogen ==============

call pathogen#infect()


"============== Plugin Specific Settings ==============

" This is necessary to make Gdiff work
let g:miniBufExplorerMoreThanOne=3

" Solarized color scheme setup
if has('gui_running')
	" use the light (yellowish background) scheme in GUI
	set background=light
else
	" change to dark color scheme on terminal
	set background=dark

	" if running on windows, degrade to 256 colors because the windows
	" terminal sucks very, very much and vim in GitBash looks awful
	if has('win32')
		let g:solarized_termcolors
	endif

endif

" enable solarized color scheme
colorscheme solarized

" change the color of the column 80
" this needs to be called after solarized
highlight ColorColumn guibg=lightyellow


" bind NERDTree to F1 (we don't need help)
nnoremap <f1> :NERDTreeToggle<cr>

" TagList shortcut
nnoremap <f2> :TlistToggle<cr>

" force snipmate accept custom defined snippets on windows
if has('win32')
	let g:snippets_dir="c:/Users/luke/.vim/bundle/snipmate/snippets/,c:/Users/luke/.vim/bundle/snipmate-custom-snippets/snippets"
endif


" MiniBufExpl Plugin Settings
let g:miniBufExplMapCTabSwitchBufs = 1 

" phpDocumentor shortcut
nnoremap <leader>d :call PhpDoc()<cr>

" key binding for the Gundo (undo preview) plugin
nnoremap <F7> :GundoToggle<CR>
