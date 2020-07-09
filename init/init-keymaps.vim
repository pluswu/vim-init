"======================================================================
"
" init-keymaps.vim - 按键设置，按你喜欢更改
"
"   - 快速移动
"   - 标签切换
"   - 窗口切换
"   - 终端支持
"   - 编译运行
"   - 符号搜索
"
" Created by skywind on 2018/05/30
" Last Modified: 2018/05/30 17:59:31
"
"======================================================================
" vim: set ts=4 sw=4 tw=78 noet :


"----------------------------------------------------------------------
" INSERT 模式下使用 EMACS 键位
"----------------------------------------------------------------------
inoremap <c-a> <home>
inoremap <c-e> <end>
inoremap <c-d> <del>
inoremap <c-_> <c-k> 

"ecs
inoremap jk <ESC>
inoremap <c-[> <ESC>


"----------------------------------------------------------------------
" 设置 CTRL+HJKL 移动光标（INSERT 模式偶尔需要移动的方便些）
" 使用 SecureCRT/XShell 等终端软件需设置：Backspace sends delete
" 详见：http://www.skywind.me/blog/archives/2021
"----------------------------------------------------------------------
noremap <C-h> <left>
noremap <C-j> <down>
noremap <C-k> <up>
noremap <C-l> <right>
inoremap <C-h> <left>
inoremap <C-j> <down>
inoremap <C-k> <up>
inoremap <C-l> <right>


"----------------------------------------------------------------------
" 命令模式的快速移动
"----------------------------------------------------------------------
cnoremap <c-h> <left>
cnoremap <c-j> <down>
cnoremap <c-k> <up>
cnoremap <c-l> <right>
cnoremap <c-a> <home>
cnoremap <c-e> <end>
cnoremap <c-f> <c-d>
cnoremap <c-b> <left>
cnoremap <c-d> <del>
cnoremap <c-_> <c-k>


"----------------------------------------------------------------------
" <leader>+数字键 切换tab
"----------------------------------------------------------------------
noremap <silent><leader>1 1gt<cr>
noremap <silent><leader>2 2gt<cr>
noremap <silent><leader>3 3gt<cr>
noremap <silent><leader>4 4gt<cr>
noremap <silent><leader>5 5gt<cr>
noremap <silent><leader>6 6gt<cr>
noremap <silent><leader>7 7gt<cr>
noremap <silent><leader>8 8gt<cr>
noremap <silent><leader>9 9gt<cr>
noremap <silent><leader>0 10gt<cr>


"----------------------------------------------------------------------
" ALT+N 切换 tab
"----------------------------------------------------------------------
noremap <silent><m-1> :tabn 1<cr>
noremap <silent><m-2> :tabn 2<cr>
noremap <silent><m-3> :tabn 3<cr>
noremap <silent><m-4> :tabn 4<cr>
noremap <silent><m-5> :tabn 5<cr>
noremap <silent><m-6> :tabn 6<cr>
noremap <silent><m-7> :tabn 7<cr>
noremap <silent><m-8> :tabn 8<cr>
noremap <silent><m-9> :tabn 9<cr>
noremap <silent><m-0> :tabn 10<cr>
inoremap <silent><m-1> <ESC>:tabn 1<cr>
inoremap <silent><m-2> <ESC>:tabn 2<cr>
inoremap <silent><m-3> <ESC>:tabn 3<cr>
inoremap <silent><m-4> <ESC>:tabn 4<cr>
inoremap <silent><m-5> <ESC>:tabn 5<cr>
inoremap <silent><m-6> <ESC>:tabn 6<cr>
inoremap <silent><m-7> <ESC>:tabn 7<cr>
inoremap <silent><m-8> <ESC>:tabn 8<cr>
inoremap <silent><m-9> <ESC>:tabn 9<cr>
inoremap <silent><m-0> <ESC>:tabn 10<cr>


" MacVim 允许 CMD+数字键快速切换标签
if has("gui_macvim")
	set macmeta
	noremap <silent><d-1> :tabn 1<cr>
	noremap <silent><d-2> :tabn 2<cr>
	noremap <silent><d-3> :tabn 3<cr>
	noremap <silent><d-4> :tabn 4<cr>
	noremap <silent><d-5> :tabn 5<cr>
	noremap <silent><d-6> :tabn 6<cr>
	noremap <silent><d-7> :tabn 7<cr>
	noremap <silent><d-8> :tabn 8<cr>
	noremap <silent><d-9> :tabn 9<cr>
	noremap <silent><d-0> :tabn 10<cr>
	inoremap <silent><d-1> <ESC>:tabn 1<cr>
	inoremap <silent><d-2> <ESC>:tabn 2<cr>
	inoremap <silent><d-3> <ESC>:tabn 3<cr>
	inoremap <silent><d-4> <ESC>:tabn 4<cr>
	inoremap <silent><d-5> <ESC>:tabn 5<cr>
	inoremap <silent><d-6> <ESC>:tabn 6<cr>
	inoremap <silent><d-7> <ESC>:tabn 7<cr>
	inoremap <silent><d-8> <ESC>:tabn 8<cr>
	inoremap <silent><d-9> <ESC>:tabn 9<cr>
	inoremap <silent><d-0> <ESC>:tabn 10<cr>
endif

"退出
nmap <m-x> :q<cr>

"----------------------------------------------------------------------
" 缓存：插件 unimpaired 中定义了 [b, ]b 来切换缓存
"----------------------------------------------------------------------
noremap <silent> <leader>bn :bn<cr>
noremap <silent> <leader>bp :bp<cr>


"----------------------------------------------------------------------
" TAB：创建，关闭，上一个，下一个，左移，右移
" 其实还可以用原生的 CTRL+PageUp, CTRL+PageDown 来切换标签
"----------------------------------------------------------------------

noremap <silent> <leader>tc :tabnew<cr>
noremap <silent> <leader>tw :tab split<cr>
noremap <silent> <leader>tq :tabclose<cr>
noremap <silent> <leader>tn :tabnext<cr>
noremap <silent> <leader>to :tabonly<cr>

" 左移 tab
function! Tab_MoveLeft()
	let l:tabnr = tabpagenr() - 2
	if l:tabnr >= 0
		exec 'tabmove '.l:tabnr
	endif
endfunc

" 右移 tab
function! Tab_MoveRight()
	let l:tabnr = tabpagenr() + 1
	if l:tabnr <= tabpagenr('$')
		exec 'tabmove '.l:tabnr
	endif
endfunc

noremap <silent><leader>tl :call Tab_MoveLeft()<cr>
noremap <silent><leader>tr :call Tab_MoveRight()<cr>
noremap <silent><m-left> :call Tab_MoveLeft()<cr>
noremap <silent><m-right> :call Tab_MoveRight()<cr>

"tag
noremap <silent> <leader>n :tnext<cr>
noremap <silent> <leader>p :tprev<cr>


"----------------------------------------------------------------------
" ALT 键移动增强
"----------------------------------------------------------------------

" ALT+h/l 快速左右按单词移动（正常模式+插入模式）
noremap <m-h> b
noremap <m-l> w
inoremap <m-h> <c-left>
inoremap <m-l> <c-right>

" ALT+j/k 逻辑跳转下一行/上一行（按 wrap 逻辑换行进行跳转） 
noremap <m-j> gj
noremap <m-k> gk
inoremap <m-j> <c-\><c-o>gj
inoremap <m-k> <c-\><c-o>gk

" 命令模式下的相同快捷
cnoremap <m-h> <c-left>
cnoremap <m-l> <c-right>

" ALT+y 删除到行末
noremap <m-y> d$
inoremap <m-y> <c-\><c-o>d$


"----------------------------------------------------------------------
" 窗口切换：ALT+SHIFT+hjkl
" 传统的 CTRL+hjkl 移动窗口不适用于 vim 8.1 的终端模式，CTRL+hjkl 在
" bash/zsh 及带文本界面的程序中都是重要键位需要保留，不能 tnoremap 的
"----------------------------------------------------------------------
noremap <m-H> <c-w>h
noremap <m-L> <c-w>l
noremap <m-J> <c-w>j
noremap <m-K> <c-w>k
inoremap <m-H> <esc><c-w>h
inoremap <m-L> <esc><c-w>l
inoremap <m-J> <esc><c-w>j
inoremap <m-K> <esc><c-w>k

if has('terminal') && exists(':terminal') == 2 && has('patch-8.1.1')
	" vim 8.1 支持 termwinkey ，不需要把 terminal 切换成 normal 模式
	" 设置 termwinkey 为 CTRL 加减号（GVIM），有些终端下是 CTRL+?
	" 后面四个键位是搭配 termwinkey 的，如果 termwinkey 更改，也要改
	set termwinkey=<c-_>
	tnoremap <m-H> <c-_>h
	tnoremap <m-L> <c-_>l
	tnoremap <m-J> <c-_>j
	tnoremap <m-K> <c-_>k
	tnoremap <m-q> <c-\><c-n>
elseif has('nvim')
	" neovim 没有 termwinkey 支持，必须把 terminal 切换回 normal 模式
	tnoremap <m-H> <c-\><c-n><c-w>h
	tnoremap <m-L> <c-\><c-n><c-w>l
	tnoremap <m-J> <c-\><c-n><c-w>j
	tnoremap <m-K> <c-\><c-n><c-w>k
	tnoremap <m-q> <c-\><c-n>
endif


"----------------------------------------------------------------------
" 编译运行 C/C++ 项目
" 详细见：http://www.skywind.me/blog/archives/2084
"----------------------------------------------------------------------

let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '_darcs', 'build.xml', 'compile_commands.json']

" 自动打开 quickfix window ，高度为 6
let g:asyncrun_open = 6

" 任务结束时候响铃提醒
let g:asyncrun_bell = 1

" 设置 F10 打开/关闭 Quickfix 窗口
nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr>

" F9 编译 C/C++ 文件
"nnoremap <silent> <F9> :AsyncRun gcc -Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>

" F5 运行文件
"nnoremap <silent> <F5> :call ExecuteFile()<cr>

"F5 编译项目
nnoremap <silent> <F7> :AsyncRun -cwd=<root> make <cr>

" F8 运行项目
"nnoremap <silent> <F8> :AsyncRun -cwd=<root> -raw make run <cr>

"F6 rebuild
"nnoremap <silent> <F6> :AsyncRun -cwd=<root> -raw make test <cr>

" 更新 cmake
nnoremap <silent> <F7> :AsyncRun -cwd=<root> cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON .<cr>








"vim终端打开与关闭
let g:terminal_key = '<m-t>'

" vim终端切换到普通模式
tnoremap <m-q> <c-\><c-n>

" Windows 下支持直接打开新 cmd 窗口运行
if has('win32') || has('win64')
	nnoremap <silent> <F8> :AsyncRun -cwd=<root> -mode=4 make run <cr>
endif


if index(g:bundle_group, 'nerdtree') >= 0
	noremap <space>nn :NERDTreeToggle<cr>
	noremap <space>nc :NERDTree %<cr>
endif

if index(g:bundle_group, 'basic') >= 0
	" 使用 ALT+E 来选择窗口
	nmap <m-e> <Plug>(choosewin)

	noremap <silent><space>ha :RemoveErrorMarkers<cr>
endif

"----------------------------------------------------------------------
" F5 运行当前文件：根据文件类型判断方法，并且输出到 quickfix 窗口
"----------------------------------------------------------------------
function! ExecuteFile()
	let cmd = ''
	if index(['c', 'cpp', 'rs', 'go'], &ft) >= 0
		" native 语言，把当前文件名去掉扩展名后作为可执行运行
		" 写全路径名是因为后面 -cwd=? 会改变运行时的当前路径，所以写全路径
		" 加双引号是为了避免路径中包含空格
		let cmd = '"$(VIM_FILEDIR)/$(VIM_FILENOEXT)"'
	elseif &ft == 'python'
		let $PYTHONUNBUFFERED=1 " 关闭 python 缓存，实时看到输出
		let cmd = 'python "$(VIM_FILEPATH)"'
	elseif &ft == 'javascript'
		let cmd = 'node "$(VIM_FILEPATH)"'
	elseif &ft == 'perl'
		let cmd = 'perl "$(VIM_FILEPATH)"'
	elseif &ft == 'ruby'
		let cmd = 'ruby "$(VIM_FILEPATH)"'
	elseif &ft == 'php'
		let cmd = 'php "$(VIM_FILEPATH)"'
	elseif &ft == 'lua'
		let cmd = 'lua "$(VIM_FILEPATH)"'
	elseif &ft == 'zsh'
		let cmd = 'zsh "$(VIM_FILEPATH)"'
	elseif &ft == 'ps1'
		let cmd = 'powershell -file "$(VIM_FILEPATH)"'
	elseif &ft == 'vbs'
		let cmd = 'cscript -nologo "$(VIM_FILEPATH)"'
	elseif &ft == 'sh'
		let cmd = 'bash "$(VIM_FILEPATH)"'
	else
		return
	endif
	" Windows 下打开新的窗口 (-mode=4) 运行程序，其他系统在 quickfix 运行
	" -raw: 输出内容直接显示到 quickfix window 不匹配 errorformat
	" -save=2: 保存所有改动过的文件
	" -cwd=$(VIM_FILEDIR): 运行初始化目录为文件所在目录
	if has('win32') || has('win64')
		exec 'AsyncRun -cwd=$(VIM_FILEDIR) -raw -save=2 -mode=4 '. cmd
	else
		exec 'AsyncRun -cwd=$(VIM_FILEDIR) -raw -save=2 -mode=0 '. cmd
	endif
endfunc


"----------------------------------------------------------------------
" F2 在项目目录下 Grep 光标下单词，默认 C/C++/Py/Js ，扩展名自己扩充
" 支持 rg/grep/findstr ，其他类型可以自己扩充
" 不是在当前目录 grep，而是会去到当前文件所属的项目目录 project root
" 下面进行 grep，这样能方便的对相关项目进行搜索
"----------------------------------------------------------------------
if executable('rg')
	noremap <silent><F2> :AsyncRun! -cwd=<root> rg -n --no-heading 
				\ --color never -g *.h -g *.c* -g *.py -g *.js -g *.vim 
				\ <C-R><C-W> "<root>" <cr>
elseif has('win32') || has('win64')
	noremap <silent><F2> :AsyncRun! -cwd=<root> findstr /n /s /C:"<C-R><C-W>" 
				\ "\%CD\%\*.h" "\%CD\%\*.c*" "\%CD\%\*.py" "\%CD\%\*.js"
				\ "\%CD\%\*.vim"
				\ <cr>
else
	noremap <silent><F2> :AsyncRun! -cwd=<root> grep -n -s -R <C-R><C-W> 
				\ --include='*.h' --include='*.c*' --include='*.py' 
				\ --include='*.js' --include='*.vim'
				\ '<root>' <cr>
endif

" 保存当前文件
nmap <C-S> :w! <cr>

" 安装一个 File 目录，使用 [名称，命令] 的格式表示各个选项。
call quickui#menu#install('&File', [
            \ ["&Open File", 'call feedkeys(":tabe ")' ],
            \ ["Find File Mu\tCtrl+P", 'Leaderf file'],
            \ ["Find File Recent\t\\rf", 'Leaderf mru --regexMode'],
            \ ["Find File In Buffer\tAlt+N", 'LeaderfBuffer'],
            \ ["--", '' ],
            \ ["&Close", 'close', 'close cur file'],
            \ ["--", '' ],
            \ ["Save\tCtrl+s", 'w!', ''],
            \ ["Save &As", 'call feedkeys(":saveas ")'],
            \ ["Save All", 'wa', ''],
            \ ["--", '' ],
            \ ["Rename", 'call feedkeys(":Rename")', ''],
            \ ["Delete", 'call feedkeys(":Delete")', ''],
            \ ["--", '' ],
            \ ["E&xit\tAlt+X", 'q'],
            \ ])

"设置 F10 打开/关闭 Quickfix 窗口
nmap <F10> :call asyncrun#quickfix_toggle(6)<cr>

if index(g:bundle_group, 'nerdtree') >= 0
	noremap <space>nn :NERDTreeToggle<cr>
	noremap <space>nc :NERDTree %<cr>
endif

"窗口/Buffer/Tab相关的选项
call quickui#menu#install('&View', [
            \ ["TabChoose\tAlt+E", 'ChooseWin'],
            \ ["Tab&OpenCur\t\\tw", 'tab split', 'open cur window in new tab'],
            \ ["TabGo\t\\Num\tor\tAlt+Num", 'go tab Num'],
            \ ["TabPrev\t\\tp", 'tabp'],
            \ ["TabNext\t\\tn", 'tabn'],
            \ ["TabClose\t\\tq", 'tabclose'],
            \ ["TabOnly\t\\to", 'tabonly'],
            \ ['TabMove&L', 'call Tab_MoveLeft()'],
            \ ['TabMove&R', 'call Tab_MoveRight()'],
            \ ["--", ''],
            \ ["View &Quickfix\tF10", 'call asyncrun#quickfix_toggle(6)'],
            \ ["View &NERDTreeR\tSpace+nn", 'NERDTree', 'file tree expand base project_root'],
            \ ["View NERDTreeC\tSpace+nc", 'NERDTree', 'file tree expand cwd'],
            \ ["View &BufferList\tAlt+P", 'call quickui#tools#list_buffer("e")'],
            \ ["--", ''],
            \ ["Window &Split\tsp", 'call feedkeys(":sp")'],
            \ ["Window Split&V\tvsp", 'call feedkeys(":vsp")'],
            \ ["WindowH+\tres", 'res +5'],
            \ ["WindowH-\tres", 'res -5'],
            \ ["WindowW+\tvert res", 'vertical resize +5'],
            \ ["WindowW-\tvert res", 'vertical resize -5'],
            \ ])

call quickui#menu#install('&Edit', [
			\ [ "Comment\t\\cc", '', 'Comment out the current line or text selected in visual mode'],
			\ [ "UnComment\t\\cu", '', 'Uncomments the selected line(s)'],
            \ ], 'auto')

"符号相关|查找|跳转|预览
call quickui#menu#install('&Symbol', [
			\ [ "&Grep Word(Project)\tF2", '', 'asyn grep cur symbol in cur project not quickfix windows'],
			\ [ "--", ''],
			\ [ "Preview FunctionList\t\\pf", 'call quickui#tools#list_function()'],
			\ [ "Preview TagDef\t\\pt", 'call quickui#tools#preview_tag("")'],
			\ ], 'auto')

if (index(g:bundle_group, 'Leaderf'))
	call quickui#menu#install('&Symbol', [
			\ [ "TagList(Leaderf)\tAlt+P", 'LeaderfBufTag!'],
            \ [ "Find &Tag GFuzzy(Leaderf)\tAlt+M", 'LeaderfTag', 'find tag reg fuzzy for project global'],
			\ ], 'auto')
endif

if (index(g:bundle_group, 'tags')) >= 0
	nmap <leader>tt :TagbarToggle<CR>

	let g:gutentags_plus_nomap = 1
	"Find symbol (reference) under cursor
	noremap <silent> <leader>gs :GscopeFind s <C-R><C-W><cr> 

	"Find symbol definition under cursor
	noremap <silent> <leader>gg :GscopeFind g <C-R><C-W><cr>  

	"Functions calling this function
	noremap <silent> <leader>gc :GscopeFind c <C-R><C-W><cr>  

	"find text string under cursor
	noremap <silent> <leader>gt :GscopeFind t <C-R><C-W><cr>  

	 "Find egrep pattern under cursor
	noremap <silent> <leader>ge :GscopeFind e <C-R><C-W><cr>

	"Find file name under cursor
	noremap <silent> <leader>gf :GscopeFind f <C-R>=expand("<cfile>")<cr><cr> 

	"Find files #including the file name under cursor
	noremap <silent> <leader>gi :GscopeFind i <C-R>=expand("<cfile>")<cr><cr> 

	"Functions called by this function  
	noremap <silent> <leader>gd :GscopeFind d <C-R><C-W><cr>   

	"Find places where current symbol is assigned
	noremap <silent> <leader>ga :GscopeFind a <C-R><C-W><cr>

	"Find current word in ctags database	
	noremap <silent> <leader>gz :GscopeFind z <C-R><C-W><cr>

	function! MenuHelp_Gscope(what)
		let p = asyncrun#get_root('%')
		let t = ''
		let m = {}
		let m["s"] = "string symbol"
		let m['g'] = 'definition'
		let m['d'] = 'functions called by this'
		let m['c'] = 'functions calling this'
		let m['t'] = 'string'
		let m['e'] = 'egrep pattern'
		let m['f'] = 'file'
		let m['i'] = 'files #including this file'
		let m['a'] = 'places where this symbol is assigned'
		let m['z'] = 'ctags database'
		if a:what == 'f' || a:what == 'i'
			" let t = expand('<cfile>')
		endif
		echohl Type
		call inputsave()
		let t = input('Find '.m[a:what].' in (' . p . '): ', t)
		call inputrestore()
		echohl None
		redraw | echo "" | redraw
		if t == ''
			return 0
		endif
		exec 'GscopeFind '. a:what. ' ' . fnameescape(t)
	endfunc

	"提供基于 TAGS 的定义预览，函数参数预览，quickfix 预览
	noremap <m-d> :PreviewScroll +1<cr>
	noremap <m-u> :PreviewScroll -1<cr>
	inoremap <m-u> <c-\><c-o>:PreviewScroll -1<cr>
	inoremap <m-d> <c-\><c-o>:PreviewScroll +1<cr>

	autocmd FileType qf nnoremap <silent><buffer> p :PreviewQuickfix<cr>
	autocmd FileType qf nnoremap <silent><buffer> P :PreviewClose<cr>

	nmap <leader>pt :call quickui#tools#preview_tag('')<cr>
	nmap <leader>pu :call quickui#preview#scroll(-5)<cr>
	nmap <leader>pd :call quickui#preview#scroll(5)<cr>

	noremap <F4> :PreviewSignature!<cr
	inoremap <F4> <c-\><c-o>:PreviewSignature!<cr>

	call quickui#menu#install('&Symbol', [
			\ [ "Preview FunctionList\t\\pf", 'LeaderfFunction!'],
			\ [ "Preview TagDef\t\\pt", 'call quickui#tools#preview_tag("")'],
            \ [ "&TagBar\t\\tt", 'TagbarToggle'],
			\ [ "--", ''],
			\ [ "PviewSignature(GNU)\tF4", 'PreviewSignature!', 'GNU Global search s definition'],
			\ [ "Find &Definition(GNU)\t\\gg", 'call MenuHelp_Gscope("g")', 'GNU Global search s definition'],
			\ [ "Find &Reference(GNU)\t\\gs", 'call MenuHelp_Gscope("s")', 'GNU Gloal search s Reference'],
			\ [ "Find &Included by(GNU)\t\\gi", 'call MenuHelp_Gscope("i")', 'GNU Global serach file include cword'],	
			\ [ "Find &Called by(GNU)\t\\gc", 'call MenuHelp_Gscope("c")', 'GNU Global search d'],
			\ ], 'auto')
endif

if index(g:bundle_group, 'ycm') >= 0
	call quickui#menu#install('&Symbol', [
			\ [ "--", ''],
			\ [ "Goto D&efinition(YCM)", 'YcmCompleter GoToDefinitionElseDeclaration'],
			\ [ "Goto &References(YCM)", 'YcmCompleter GoToReferences'],
			\ [ "Get D&oc(YCM)", 'YcmCompleter GetDoc'],
			\ [ "Get &Type(YCM)", 'YcmCompleter GetTypeImprecise'],
			\ ], 'auto', 'c,cpp')
endif

"版本管理相关p4/git
call quickui#menu#install('SC&M', [
			\ [ "view diff(svn/git)", 'call svnhelp#svn_diff("%")', 'show svn/git diff side by side, ]c, [c to jump between changes'],
			\ [ "show log", 'call svnhelp#svn_log("%")', 'show svn/git diff in quickfix window, F10 to close/open quickfix'],
			\ [ "file add", 'call svnhelp#svn_add("%")', 'add file to repository'],
			\ [ 'compare file', 'call svnhelp#compare_ask_file()', 'use vertical diffsplit, compare current file to another (use filename)'],
			\ [ 'compare buffer', 'call svnhelp#compare_ask_buffer()', 'use vertical diffsplit, compare current file to another (use buffer id)'],
			\ ], 'auto')

"终端
call quickui#menu#install('&Terminal', [
            \ [ '&Terminal Window\tAlt+T', 'call TerminalToggle()', '' ],
            \ [ 'Terminal Normal\tAlt+Q', ''],
            \ [ 'Drop Open\tdrop', '', 'fly file from terminal 2 vim use drop cmd' ],
            \ ], 'auto')

"其他辅助
call quickui#menu#install("T&ools", [
			\ ["Display &Messages", 'call quickui#tools#display_messages()'],
			\ ["--", ''],
			\ ['Set &Spell %{&spell? "Off":"On"}', 'set spell!'],
			\ ['Set &Cursor Line %{&cursorline? "Off":"On"}', 'set cursorline!'],
			\ ['Set &Paste %{&paste? "Off":"On"}', 'set paste!'],
			\ ["--", ''],
			\ ["Plugin Status", "PlugStatus", 'list plugins status'],
			\ ["Plugin Update", "PlugUpdate", 'update plugins'],
			\ ["Plugin Clean", "PlugClean", 'update plugins']
			\ ])

function! MenuHelp_TaskList()
	let keymaps = '123456789abcdefimopqrstuvwxyz'
	let items = asynctasks#list('')
	let rows = []
	let size = strlen(keymaps)
	let index = 0
	for item in items
		if item.name =~ '^\.'
			continue
		endif
		let cmd = strpart(item.command, 0, (&columns * 60) / 100)
		let key = (index >= size)? ' ' : strpart(keymaps, index, 1)
		let text = "[" . ((key != ' ')? ('&' . key) : ' ') . "]\t"
		let text .= item.name . "\t[" . item.scope . "]\t" . cmd
		let rows += [[text, 'AsyncTask ' . fnameescape(item.name)]]
		let index += 1
	endfor
	let opts = {}
	let opts.title = 'Task List'
	" let opts.bordercolor = 'QuickTitle'
	call quickui#tools#clever_listbox('tasks', rows, opts)
endfunc

call quickui#menu#install('&Run', [
			\ ["&Cheatsheet", 'help index', ''],
			\ ['T&ips', 'help tips', ''],
			\ ['--',''],
			\ ["&Tutorial", 'help tutor', ''],
			\ ['&Quick Reference', 'help quickref', ''],
			\ ], 'auto')
	
"命令最后可以加一个 “权重”系数，用于决定目录位置，权重越大越靠右，越小越靠左
call quickui#menu#install('Hel&p', [
			\ ["&Cheatsheet", 'help index', ''],
			\ ['T&ips', 'help tips', ''],
			\ ['--',''],
			\ ["&Tutorial", 'help tutor', ''],
			\ ['&Quick Reference', 'help quickref', ''],
			\ ['&Summary', 'help summary', ''],
			\ ['--',''],
			\ ['&Vim Script', 'help eval', ''],
			\ ['&Function List', 'help function-list', ''],
			\ ], 10000)



" 打开下面选项，允许在 vim 的下面命令行部分显示帮助信息
let g:quickui_show_tip = 1

"定义按两次空格就打开上面的目录
noremap <space><space> :call quickui#menu#open()<cr>
vmap <space><space> :call quickui#menu#open()<cr>

nnoremap <silent>K :call quickui#tools#clever_context('k', g:context_menu_k, {})<cr>
if has('gui_running') || has('nvim')
	noremap <c-f10> :call MenuHelp_TaskList()<cr>
endif
