"===========================================================================" 
"         Filename: vimrc
"           Author: HM
"            Email: wangbandi#gmail.com
"         Homepage: http://huangming.org
"          Created: 2012-4-25
"===========================================================================

"                      ━━━━━━━━━━━━━━━━━   
"                            常  规             
"                                  设 置        
"                      ━━━━━━━━━━━━━━━━━         

"---------------------------------------------------------------------------"
"一般设定
"-------------------------------------------------------------------
set encoding=utf-8
set fenc=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set termencoding=utf-8
language messages zh_CN.UTF-8       "解决输出乱码 
set history=100             " history文件中需要记录的行数
syntax on                   " 语法高亮
set cursorline              " 突出显示当前行
set nu!                     " 显示行号
set scrolloff=5             " 在光标接近底端或顶端时，自动下滚或上滚
set cmdheight=2             " 命令行（在状态行下）的高度，默认为1，这里是2
set report=0            " 通过使用: commands命令，告诉我们文件的哪一行被改过
"set helplang=cn             " 中文帮助
set t_Co=256
let g:solarized_termcolors=256
"set background=dark
set bsdir=buffer                " 设定文件浏览器目录为当前目录
set nocompatible            " 不要使用vi的键盘模式，而是vim自己的 
set iskeyword+=_,$,@,%,#,-      " 带有如下符号的单词不要被换行分割 
set autochdir               "设定工作目录为当前目录 
set wildmenu            " 增强模式中的命令行自动完成操作 
set clipboard+=unnamed " Yanks go on clipboard instead
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮  " Unprintable chars mapping 
set showbreak=↪
set wildignore=.svn,CVS,.git,.hg,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,.DS_Store,*.aux,*.out,*.toc
set wildmenu
"---------------------------------------------------------------------------"
"状态栏相关的设置[包括文件路径、文件类型、坐标、所占比例、时间等]
"--------------------------------------------------------------------------
set statusline=%F%m%r%h%w\ [%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %y%r%m%*%=\ [%l,%v]\ [%p%%]\ [共%L行]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
highlight StatusLine guifg=SlateBlue guibg=Yellow  " 状态行颜色
highlight StatusLineNC guifg=Gray guibg=White      " 状态行颜色
set laststatus=2     " 总是显示状态行
set ruler            " 在编辑过程中，在右下角显示光标位置的状态行
if version >= 700    " 进入插入模式时改变状态栏颜色（仅限于Vim 7）
   au InsertEnter * hi StatusLine guibg=#818D29 guifg=#FCFCFC gui=none
   au InsertLeave * hi StatusLine guibg=Yellow guifg=SlateBlue gui=none
endif

"---------------------------------------------------------------------------
" 菜单栏与工具栏
"---------------------------------------------------------------------------
if has("gui_running")
    "au GUIEnter * simalt ~x  " 窗口启动时自动最大化
    set guioptions+=m        " 不隐藏菜单栏
    set guioptions-=T        "  不隐藏工具栏
    "set guioptions-=L        " 隐藏左侧滚动条
    "set guioptions-=r        " 隐藏右侧滚动条
    "set guioptions-=b        " 隐藏底部滚动条
    set showtabline=0        " 隐藏Tab栏
endif

"---------------------------------------------------------------------------
"设置窗口的起始位置和大小
"---------------------------------------------------------------------------
winpos 350 150
"winpos 250 200
set lines=28
set columns=85

"---------------------------------------------------------------------------
"字体设置
"---------------------------------------------------------------------------
if has('gui_running')
    if has('gui_gtk')
        set guifont=Monospace\ 11
    elseif has('gui_win32')
        set guifont=Consolas:h11:cANSI
    endif
endif

"---------------------------------------------------------------------------
" 文件设置
"---------------------------------------------------------------------------
set confirm                     " 在处理未保存或只读文件的时候，弹出确认
set autoread                    " 当文件在外部被修改，自动更新该文件
"set shortmess=atI              " 启动的时候不显示那个援助索马里儿童的提示
" Set directories
set undodir=~/.vim/tmp/undo//     " undo files
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files
set backup
set noswapfile
" Automatically remove fugitive buffers
autocmd BufReadPost fugitive://* set bufhidden=delete

"---------------------------------------------------------------------------
" 文本格式和排版
"---------------------------------------------------------------------------
set nolinebreak                 " 不在单词中间断行
set textwidth=150               " 设置最大列数，超出后自动换行
set matchtime=5                 " 匹配括号高亮的时间（单位是十分之一秒）
set showmatch                   " 高亮显示匹配的括号
:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { {<CR>}<ESC>O
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
:inoremap " ""<ESC>i
:inoremap ' ''<ESC>i

function! ClosePair(char)
 if getline('.')[col('.') - 1] == a:char
     return "\<Right>"
 else
     return a:char
 endif
endfunction

"---------------------------------------------------------------------------
" 查找/替换相关的设置
"---------------------------------------------------------------------------
set hlsearch       "高亮显示搜索结果 
set incsearch      "如要查找book，当输入到/b时，会自动找到第一个b开头的单词
set gdefault       " 替换时所有的行内匹配都被替换，而不是只有第一个
set ignorecase     " 在搜索的时候忽略大小写

" clear highlight after search
noremap <silent><Leader>/ :nohls<CR>

" Use sane regexes
nnoremap / /\v
vnoremap / /\v
cnoremap s/ s/\v
nnoremap ? ?\v
vnoremap ? ?\v
cnoremap s? s?\v

" Keep search matches in the middle of the window
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap * *zzzv
nnoremap # #zzzv
nnoremap g* g*zzzv
nnoremap g# g#zzzv

"-------------------------------------------------
" => Fold Related
"-------------------------------------------------
set foldlevelstart=0 " Start with all folds closed
set foldcolumn=1 " Set fold column

" Space to toggle and create folds.
nnoremap <silent><Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

" Set foldtext
function! MyFoldText()
    let line=getline(v:foldstart)
    let nucolwidth=&foldcolumn+&number*&numberwidth
    let windowwidth=winwidth(0)-nucolwidth-3
    let foldedlinecount=v:foldend-v:foldstart+1
    let onetab=strpart('          ', 0, &tabstop)
    let line=substitute(line, '\t', onetab, 'g')
    let line=strpart(line, 0, windowwidth-2-len(foldedlinecount))
    let fillcharcount=windowwidth-len(line)-len(foldedlinecount)
    return line.'…'.repeat(" ",fillcharcount).foldedlinecount.'…'.' '
endfunction
set foldtext=MyFoldText()

"--------------------------------------------------------------------------
" 特殊文件类型
"---------------------------------------------------------------------------
au BufRead,BufNewFile {Gemfile,Rakefile,Capfile,*.rake,config.ru}     set ft=ruby
au BufRead,BufNewFile {*.md,*.mkd,*.markdown}                         set ft=markdown

" Markdown
augroup ft_markdown
    autocmd!
    " Use <localLeader>1/2/3/4/5/6 to add headings
    autocmd Filetype markdown nnoremap <buffer> <localLeader>1 I# <ESC>
    autocmd Filetype markdown nnoremap <buffer> <localLeader>2 I## <ESC>
    autocmd Filetype markdown nnoremap <buffer> <localLeader>3 I### <ESC>
    autocmd Filetype markdown nnoremap <buffer> <localLeader>4 I#### <ESC>
    autocmd Filetype markdown nnoremap <buffer> <localLeader>5 I##### <ESC>
    autocmd Filetype markdown nnoremap <buffer> <localLeader>6 I###### <ESC>
    " Use <LocalLeader>b to add blockquotes in normal and visual mode
    autocmd Filetype markdown nnoremap <buffer> <localLeader>b I> <ESC>
    autocmd Filetype markdown vnoremap <buffer> <localLeader>b :s/^/> /<CR>
    " Use <localLeader>ul and <localLeader>ol to add list symbols in visual mode
    autocmd Filetype markdown vnoremap <buffer> <localLeader>ul :s/^/* /<CR>
    autocmd Filetype markdown vnoremap <buffer> <LocalLeader>ol :s/^/\=(line(".")-line("'<")+1).'. '/<CR>
    " Use <localLeader>e1/2/3 to add emphasis symbols
    autocmd Filetype markdown nnoremap <buffer> <localLeader>e1 I*<ESC>A*<ESC>
    autocmd Filetype markdown nnoremap <buffer> <localLeader>e2 I**<ESC>A**<ESC>
    autocmd Filetype markdown nnoremap <buffer> <localLeader>e3 I***<ESC>A***<ESC>
    " Use <Leader>P to preview markdown file in browser
    autocmd Filetype markdown nnoremap <buffer> <Leader>P :MarkdownPreview<CR>
augroup END

"--------------------------------------------------------------------------
" 自定义快捷键
"---------------------------------------------------------------------------
nmap wv      <C-w>v      " 垂直分割当前窗口
nmap wc      <C-w>c      " 关闭当前窗口
nmap ws      <C-w>s      " 水平分割当前窗口

" Begining & End of line in Normal mode
noremap H ^
noremap L g_

" Redesign moving keys in insert mode
inoremap <C-K> <Up>
inoremap <C-J> <Down>
inoremap <C-H> <Left>
inoremap <C-L> <Right>

" Make j and k work the way you expect
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz

" Navigation between windows
nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
nnoremap <C-O> <C-W>o

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" Copy paste system clipboard
map <leader>y "*y
map <leader>p "*p
map <leader>P "*P

" Quit help easily
function! QuitWithQ()
  if &buftype == 'help'
    nnoremap <buffer> <silent> q :q<cr>
  endif
endfunction
autocmd FileType help exe QuitWithQ()

" Easy buffer navigation
noremap <leader>bp :bprevious<cr>
noremap <leader>bn :bnext<cr>

nnoremap <silent> <LocalLeader>rs :source ~/.vimrc<CR>

" Quick editing 
nnoremap <Leader>ev :tabedit $MYVIMRC<CR>

" When vimrc is edited, reload it
autocmd! BufWritePost .vimrc source $MYVIMRC

" better ESC
inoremap jk <Esc>
inoremap jkl <Esc>:
nmap ; :

" w!! to write a file as sudo
cmap w!! w !sudo tee % >/dev/null

"---------------------------------------------------------------------------
" F5编译和运行C程序，F6编译和运行C++程序 
" 请注意，下述代码在windows下使用会报错 
" 需要去掉./这两个字符 
"---------------------------------------------------------------------------
" C的编译和运行 
map <F6> :call CompileRunGcc()<CR> 
func! CompileRunGcc() 
exec "w" 
exec "!gcc % -o %<" 
exec "! ./%<" 
endfunc 

" C++的编译和运行 
map <F5> :call CompileRunGpp()<CR> 
func! CompileRunGpp() 
exec "w" 
exec "!g++ % -o %<" 
exec "! ./%<" 
endfunc 


"---------------------------------------------------------------------------
" Vundle
"---------------------------------------------------------------------------
set nocompatible	    " 取消兼容模式
filetype off                     " 侦测文件类型
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

 " let Vundle manage Vundle
Bundle 'gmarik/vundle'

Bundle 'minibufexpl.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'jistr/vim-nerdtree-tabs'

Bundle 'grep.vim'
Bundle 'Vimball'
if executable('ctags')
    Bundle 'majutsushi/tagbar'
endif
if executable('ack-grep') || executable('ack')
    Bundle 'mileszs/ack.vim'
endif
if executable('git')
    Bundle 'tpope/vim-fugitive'
endif

Bundle 'SuperTab'
Bundle "YankRing.vim"
Bundle "repeat.vim"
Bundle "surround.vim"
Bundle 'garbas/vim-snipmate'
Bundle 'honza/snipmate-snippets'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'

Bundle 'calendar.vim' 
Bundle 'AuthorInfo'
Bundle 'vimwiki'

Bundle "Markdown"
Bundle "jQuery"
Bundle 'TxtBrowser'

Bundle 'Color-Scheme-Explorer'
Bundle 'huangming/darker-robin'
Bundle 'sjl/badwolf'
Bundle 'altercation/vim-colors-solarized'
Bundle 'tomasr/molokai'
Bundle 'zaiste/Atom'
Bundle 'w0ng/vim-hybrid'

" non github repos

filetype plugin indent on     " required!
 "
 " Brief help
 " :BundleList          - list configured bundles
 " :BundleInstall(!)    - install(update) bundles
 " :BundleSearch(!) foo - search(or refresh cache first) for foo
 " :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
 "
 " see :h vundle for more details or wiki for FAQ
 " NOTE: comments after Bundle command are not allowed..

"---------------------------------------------------------------------- ---"
"配色方案(按照当前时间的秒数的个位数决定使用哪个方案)
"--------------------------------------------------------------------------
if has('gui_running')
    if (strftime("%S")-floor(strftime("%S")/10)*10) == 0
   	 colorscheme hybrid
    elseif   (strftime("%S")-floor(strftime("%S")/10)*10) <= 2
    	colorscheme solarized
    elseif   (strftime("%S")-floor(strftime("%S")/10)*10) <= 4
    	colorscheme badwolf
    elseif   (strftime("%S")-floor(strftime("%S")/10)*10) <= 6
 	colorscheme darker-robin
    elseif   (strftime("%S")-floor(strftime("%S")/10)*10) <= 8
  	colorscheme molokai
    elseif   (strftime("%S")-floor(strftime("%S")/10)*10) <=9
	colorscheme atom
    endif
else
    if(strftime("%S")-floor(strftime("%S")/10)*10) <= 3
    	colorscheme badwolf
    elseif   (strftime("%S")-floor(strftime("%S")/10)*10) <= 7
    	colorscheme molokai
    else
    	colorscheme solarized
    endif
endif

"---------------------------------------------------------------------------
" authorinfo.vim
"---------------------------------------------------------------------------
let g:vimrc_author='HM' 
let g:vimrc_email='wangbandi@gmail.com' 
let g:vimrc_homepage='http://huangming.org' 

"--------------------------------------------------
" => Tagbar
"--------------------------------------------------
nnoremap <Leader>ta :TagbarToggle<CR>
let g:tagbar_autofocus=1
let g:tagbar_expand=1
let g:tagbar_foldlevel=2
let g:tagbar_ironchars=['▾', '▸']
let g:tagbar_autoshowtag=1
let g:tagbar_ctags_bin = 'ctags'
let g:tagbar_width = 22

"--------------------------------------------------
" => YankRing.vim
"--------------------------------------------------
    let g:yankring_replace_n_pkey = '<leader>['
    let g:yankring_replace_n_nkey = '<leader>]'
    let g:yankring_history_dir = '~/.vim/tmp'
    nmap <leader>y :YRShow<cr>

"---------------------------------------------------------------------------
" MiniBufExplorer
"---------------------------------------------------------------------------
let g:miniBufExplMapCTabSwitchBufs = 1  "<C-Tab>向前切换,并在 当前窗口打开
let g:miniBufExplMapWindowNavVim = 1 "可用<C-h,j,k,l>切换到上下左右的窗口
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplModSelTarget = 1

"--------------------------------------------------
" => NERD_tree
"--------------------------------------------------
nnoremap <Leader>d :NERDTreeTabsToggle<CR>
nnoremap <Leader>f :NERDTreeFind<CR>
let NERDTreeChDirMode=2
let NERDTreeShowBookmarks=1
let NERDTreeShowHidden=1
let NERDTreeShowLineNumbers=1
let NERDTreeDirArrows=1
let g:nerdtree_tabs_open_on_gui_startup=0 	"(default: 1)Open NERDTree on gvim/macvim startup
let g:nerdtree_tabs_open_on_console_startup=0 	"(default: 0)Open NERDTree on console vim startup



"--------------------------------------------------
" => Splitjoin
"--------------------------------------------------
nnoremap sj :SplitjoinSplit<CR>
nnoremap sk :SplitjoinJoin<CR>
let g:splitjoin_normalize_whitespace=1
let g:splitjoin_align=1

"---------------------------------------------------------------------------
" Cscope
"---------------------------------------------------------------------------
:set cscopequickfix=s-,c-,d-,i-,t-,e-

"--------------------------------------------------
" => Ack
"--------------------------------------------------
if executable('ack-grep') || executable('ack')
    nnoremap <Leader>a :Ack!<Space>
endif
if has('unix') && executable('ack-grep')
    let g:ackprg='ack-grep -H --nocolor --nogroup --column'
endif

"--------------------------------------------------
" => fugitive
"--------------------------------------------------
if executable('git')
    nnoremap <silent> <leader>gs :Gstatus<CR>
    nnoremap <silent> <leader>gd :Gdiff<CR>
    nnoremap <silent> <leader>gc :Gcommit<CR>
    nnoremap <silent> <leader>gb :Gblame<CR>
    nnoremap <silent> <leader>gl :Glog<CR>
    nnoremap <silent> <leader>gp :Git push<CR>
endif

"--------------------------------------------------
" => snipMate
"--------------------------------------------------
let g:snips_trigger_key=',,s'
let g:snips_trigger_key_backwards=',,s'
snoremap <CR> a<BS>
snoremap <BS> a<BS>
snoremap <right> <ESC>a
snoremap <left> <ESC>bi
snoremap ' a<BS>'
snoremap ` a<BS>`
snoremap % a<BS>%
snoremap U a<BS>U
snoremap ^ a<BS>^
snoremap \ a<BS>\
snoremap <C-x> a<BS><c-x>` `' '

"---------------------------------------------------------------------------
" SuperTab
"---------------------------------------------------------------------------
let g:SuperTabDefaultCompletionType="context"  

"---------------------------------------------------------------------------
" Calendar
"---------------------------------------------------------------------------
let g:calendar_diary='/home/cactus/dev/Diary'



"---------------------------------------------------------------------------
" Txtbrows
"---------------------------------------------------------------------------
"au BufEnter *.txt setlocal ft=txt

"---------------------------------------------------------------------------
" VimWiki
"---------------------------------------------------------------------------

" 使用鼠标映射
let g:vimwiki_use_mouse = 1

" 不要将驼峰式词组作为 Wiki 词条
let g:vimwiki_camel_case = 0

" 标题带上自动编号
let g:vimwiki_html_header_numbering = 2

let g:vimwiki_html_header_numbering = '.'
  
let g:vimwiki_ext2syntax = {'.md': 'markdown',
                  \ '.mkd': 'markdown',
                  \ '.wiki': 'media'}

let g:vimwiki_valid_html_tags ='b,i,s,u,sub,sup,kbd,br,hr,div'

    let wiki_1 = {}
    let wiki_1.path = '~/dev/vimwiki/'
    let wiki_1.path_html = '~/dev/huangming.github.com/source/vimwiki/'
    let wiki_1.template_path = '~/dev/vimwiki/template/'
    let wiki_1.template_default = 'template1'
    let wiki_1.template_ext = '.html'
"    let wiki_1.syntax = 'markdown'
"    let wiki_1.ext = '.md'

    let g:vimwiki_list = [wiki_1]

"---------------------------------------------------------------------------
" Grep
"---------------------------------------------------------------------------
nnoremap <silent> <F3> :Grep<CR>


