
"////////////////////////global///////////////////////////////

set nocompatible " be iMproved, required

function! OSX()
    return has('macunix')
endfunction

function! LINUX()
    return has('unix') && !has('macunix') && !has('win32unix')
endfunction

function! WINDOWS()
    return  (has('win16') || has('win32') || has('win64'))
endfunction


" language
set encoding=utf-8

"set helplang=cn

if WINDOWS()
    silent exec 'language english'
    if has('multi_byte')
        set termencoding=cp850
        setglobal fileencoding=utf-8
        set fileencodings=ucs-bom,utf-8,utf-16le,cp1252,iso-8859-15
    endif

elseif OSX()
    silent exec 'language en_US'
    set termencoding=utf-8

else
    silent exec 'language en_US.UTF-8'
    set termencoding=iso10646-1 "utf-8
endif

" vundle#begin
filetype off " required

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin() " required
call vundle#rc('~/.vim/bundle/')
" load .vimrc.plugins & .vimrc.plugins.local
let vimrc_plugins_path = '~/.vimrc.plugins'
if filereadable(expand(vimrc_plugins_path))
    exec 'source ' . fnameescape(vimrc_plugins_path)
endif
call vundle#end()         " required

" vundle#end
filetype plugin indent on " required
syntax on " required

" Default colorscheme setup
set background=dark
colorscheme solarized
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

"/////////////////////////////////////////////////////////////////////////////
" General
"/////////////////////////////////////////////////////////////////////////////

" Redefine the shell redirection operator to receive both the stderr messages and stdout messages
set shellredir=>%s\ 2>&1
set history=30 " keep 30 lines of command line history
set autoread " auto read same-file change ( better for vc/vim change )
behave xterm  " set mouse behavior as xterm
set matchtime=0 " 0 second to show the matching paren ( much faster )
set showmatch " show matching paren
set nu " show line number
" only supoort in 7.3 or higher
if v:version >= 703
    set noacd " no autochchdir
endif
set viewoptions=folds,options,cursor,unix,slash
set wildmenu " turn on wild menu, try typing :h and press <Tab>
set wildignore+=*.so,*.o,*.a,*.obj,*.swp,*.zip,*.pyc,*.pyo,*.class,.DS_Store  " MacOSX/Linux
"set whichwrap=b,s,h,l,<,>,[,]
set whichwrap=b,s,[,]
set list
set listchars=tab:>-,trail:.
set showcmd " display incomplete commands
set ruler " show the cursor position all the time
set hidden " allow to change buffer without saving
set shortmess=aoOtTI " shortens messages to avoid 'press a key' prompt
set lazyredraw " do not redraw while executing macros (much faster)
set ttyfast
set display+=lastline " for easy browse last line with wrap text
set laststatus=2 " always have status-line
set titlestring=%F\ (%{expand(\"%:p:.:h\")}/)
set showfulltag " show tag with function protype.
set statusline=%F\ %y%r%m\ %{&ff}%=[Hex:0x%B][Dec:%b]\ %4l/%L\ %02p%%
"set cc=81
set diffopt+=vertical
set cursorline
set cursorcolumn
set autoindent " autoindent
set smartindent " smartindent
set backspace=indent,eol,start " allow backspacing over everything in insert mode
" indent options
" see help cinoptions-values for more details
set cinoptions=>s,e0,n0,f0,{0,}0,^0,:0,=s,l0,b0,g0,hs,ps,ts,is,+s,c3,C0,0,(0,us,U0,w0,W0,m0,j0,)20,*30
" default '0{,0},0),:,0#,!^F,o,O,e' disable 0# for not ident preprocess
" set cinkeys=0{,0},0),:,!^F,o,O,e
set cindent shiftwidth=4 " set cindent on to autoinent when editing c/c++ file, with 4 shift width
set tabstop=4 " set tabstop to 4 characters
set expandtab " set expandtab on, the tab will be change to space automaticaly
set ve=block " in visual block mode, cursor can be positioned where there is no actual character

set incsearch " do incremental searching
set hlsearch " highlight search terms
set ignorecase " set search/replace pattern to ignore case
set smartcase " set smartcase mode on, If there is upper case character in the search patern, the 'ignorecase' option will be override.
set nojoinspaces
set nowrapscan
" set this to use id-utils for global search
set grepprg=lid\ -Rgrep\ -s
set grepformat=%f:%l:%m

if has('clipboard')
    if has('unnamedplus') " When possible use + register for copy-paste
        set clipboard=unnamed,unnamedplus
    else " On mac and Windows, use * register for copy-paste
        set clipboard=unnamed
    endif
endif

if has('autocmd')
    augroup ex
        autocmd!
        " when editing a file, always jump to the last known cursor position.
        " don't do it when the position is invalid or when inside an event handler
        " (happens when dropping a file on gvim).
        autocmd BufReadPost *
                    \ if line("'\"") > 0 && line("'\"") <= line("$") |
                    \   exe "normal g`\"" |
                    \ endif
        autocmd FileType text setlocal textwidth=80 " for all text files set 'textwidth' to 78 characters.
        autocmd FileType c,cpp,java,javascript set comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,f://
        autocmd FileType javascript,html,htmldjango,xhtml,haml,css setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
        autocmd FileType vim set comments=sO:\"\ -,mO:\"\ \ ,eO:\"\",f:\"
    augroup END
endif

set cscopequickfix=s-,c-,d-,i-,t-,e-
if has("cscope")
    set csto=1
    set cst
    set cspc=3
    "add any database in current dir
    if filereadable("cscope.out")
        cs add cscope.out
    "else search cscope.out elsewhere
    else
        let cscope_file=findfile("cscope.out", ".;")
        let cscope_pre=matchstr(cscope_file, ".*/")
        "echo cscope_file
        if !empty(cscope_file) && filereadable(cscope_file)
            set nocscopeverbose " suppress 'duplicate connection' error
            exe "cs add" cscope_file cscope_pre
            set cscopeverbose
        endif
     endif
endif

" let mapleader = "," " default "\"
" copy - paste
noremap <Leader>p "+p
vmap <C-c> "+y

nmap <Leader>q :q<CR>
nmap <Leader>w :w<CR>
nmap <Leader>pa %

noremap <C-h> <C-W>h
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-l> <C-W>l

nnoremap g^ gUiW
nnoremap gv guiW

"change current direcotry
cmap cwd lcd %:p:h

noremap k gk
noremap j gj
nnoremap [c :cp <CR>
nnoremap ]c :cn <CR>
nnoremap <F10> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ -L cscope.files && cscope -bkq  -i cscope.files <CR>
" enhance '<' '>' , do not need to reselect the block after shift it.
vnoremap < <gv
vnoremap > >gv
