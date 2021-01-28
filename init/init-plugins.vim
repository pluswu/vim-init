"======================================================================
"
" init-plugins.vim - 
"
" Created by skywind on 2018/05/31
" Last Modified: 2018/06/10 23:11
"
"======================================================================
" vim: set ts=4 sw=4 tw=78 noet :



"----------------------------------------------------------------------
" 默认情况下的分组，可以再前面覆盖之
"----------------------------------------------------------------------
if !exists('g:bundle_group')
	let g:bundle_group = ['basic', 'tags', 'enhanced', 'filetypes', 'textobj']
	let g:bundle_group += ['tags', 'airline', 'echodoc']
	let g:bundle_group += ['nerdtree']
	"let g:bundle_group += ['defex']
	"let g:bundle_group += ['ycm']
	let g:bundle_group += ['ale']
	let g:bundle_group += ['coc']
	"let g:bundle_group += ['neomake']
	let g:bundle_group += ['leaderf']
endif


"----------------------------------------------------------------------
" 计算当前 vim-init 的子路径
"----------------------------------------------------------------------
let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h:h')

function! s:path(path)
	let path = expand(s:home . '/' . a:path )
	return substitute(path, '\\', '/', 'g')
endfunc


"----------------------------------------------------------------------
" 在 ~/.vim/bundles 下安装插件
"----------------------------------------------------------------------
call plug#begin(get(g:, 'bundle_home', '~/.vim/bundles'))


"----------------------------------------------------------------------
" 默认插件 
"----------------------------------------------------------------------

" 全文快速移动，<leader><leader>f{char} 即可触发
Plug 'easymotion/vim-easymotion'

" 文件浏览器，代替 netrw
Plug 'justinmk/vim-dirvish'

" 表格对齐，使用命令 Tabularize
Plug 'godlygeek/tabular', { 'on': 'Tabularize' }

" Diff 增强，支持 histogram / patience 等更科学的 diff 算法
Plug 'chrisbra/vim-diff-enhanced'

"----------------------------------------------------------------------
" Dirvish 设置：自动排序并隐藏文件，同时定位到相关文件
" 这个排序函数可以将目录排在前面，文件排在后面，并且按照字母顺序排序
" 比默认的纯按照字母排序更友好点。
"----------------------------------------------------------------------
function! s:setup_dirvish()
	if &buftype != 'nofile' && &filetype != 'dirvish'
		return
	endif
	if has('nvim')
		return
	endif
	" 取得光标所在行的文本（当前选中的文件名）
	let text = getline('.')
	if ! get(g:, 'dirvish_hide_visible', 0)
		exec 'silent keeppatterns g@\v[\/]\.[^\/]+[\/]?$@d _'
	endif
	" 排序文件名
	exec 'sort ,^.*[\/],'
	let name = '^' . escape(text, '.*[]~\') . '[/*|@=|\\*]\=\%($\|\s\+\)'
	" 定位到之前光标处的文件
	call search(name, 'wc')
	noremap <silent><buffer> ~ :Dirvish ~<cr>
	noremap <buffer> % :e %
endfunc

augroup MyPluginSetup
	autocmd!
	autocmd FileType dirvish call s:setup_dirvish()
augroup END

"----------------------------------------------------------------------
" 基础插件
"----------------------------------------------------------------------
if index(g:bundle_group, 'basic') >= 0

	" 展示开始画面，显示最近编辑过的文件
	Plug 'mhinz/vim-startify'

	" 一次性安装一大堆 colorscheme
	Plug 'flazz/vim-colorschemes'

	" 支持库，给其他插件用的函数库
	Plug 'xolox/vim-misc'

	" 用于在侧边符号栏显示 marks （ma-mz 记录的位置）
	Plug 'kshenoy/vim-signature'

	" 用于在侧边符号栏显示 git/svn/p4 的 diff
	Plug 'mhinz/vim-signify'

	" 根据 quickfix 中匹配到的错误信息，高亮对应文件的错误行
	" 使用 :RemoveErrorMarkers 命令或者 <space>ha 清除错误
	Plug 'mh21/errormarker.vim'

	" 使用 ALT+e 会在不同窗口/标签上显示 A/B/C 等编号，然后字母直接跳转
	Plug 't9md/vim-choosewin'

	" 提供基于 TAGS 的定义预览，函数参数预览，quickfix 预览
	Plug 'skywind3000/vim-preview'

	" Git 支持
	Plug 'tpope/vim-fugitive'
	
	" 代码模板
	Plug 'SirVer/ultisnips'

if index(g:bundle_group, 'coc') >= 0
	"禁止UltilSnip的tab自动补齐 这样coc才能使用
	let g:UltiSnipsExpandTrigger = "<m_ttttt>"
endif


	"搜索高亮
	Plug 'timakro/vim-searchant'

	" 默认不显示 startify
	let g:startify_disable_at_vimenter = 1
	let g:startify_session_dir = '~/.vim/session'

	"signify 调优
	let g:signify_vcs_list = ['git', 'svn', 'p4']
	let g:signify_sign_add               = '+'
	let g:signify_sign_delete            = '_'
	let g:signify_sign_delete_first_line = '‾'
	let g:signify_sign_change            = '~'
	let g:signify_sign_changedelete      = g:signify_sign_change

	"git 仓库使用 histogram 算法进行 diff
	let g:signify_vcs_cmds = {
			\ 'git': 'git diff --no-color --diff-algorithm=histogram --no-ext-diff -U0 -- %f',
			\}

endif


"----------------------------------------------------------------------
" 增强插件
"----------------------------------------------------------------------
if index(g:bundle_group, 'enhanced') >= 0
	"删除/重命名文件
	Plug 'tpope/vim-eunuch'

	" 用 v 选中一个区域后，ALT_+/- 按分隔符扩大/缩小选区
	Plug 'terryma/vim-expand-region'

	" 快速文件搜索
	Plug 'junegunn/fzf'

	" 给不同语言提供字典补全，插入模式下 c-x c-k 触发
	Plug 'asins/vim-dict'

	" 使用 :FlyGrep 命令进行实时 grep
	Plug 'wsdjeg/FlyGrep.vim'

	" 使用 :CtrlSF 命令进行模仿 sublime 的 grep
	Plug 'dyng/ctrlsf.vim'

	" 配对括号和引号自动补全
	Plug 'Raimondi/delimitMate'

	" 提供 gist 接口
	Plug 'lambdalisue/vim-gista', { 'on': 'Gista' }
	
	" ALT_+/- 用于按分隔符扩大缩小 v 选区
	map <m-=> <Plug>(expand_region_expand)
	map <m--> <Plug>(expand_region_shrink)

	Plug 'honza/vim-snippets'
endif


"----------------------------------------------------------------------
" 自动生成 ctags/gtags，并提供自动索引功能
" 不在 git/svn 内的项目，需要在项目根目录 touch 一个空的 .root 文件
" 详细用法见：https://zhuanlan.zhihu.com/p/36279445
"----------------------------------------------------------------------
if index(g:bundle_group, 'tags') >= 0

	" 提供 ctags/gtags 后台数据库自动更新功能
	Plug 'ludovicchabant/vim-gutentags'

	"Plug 'majutsushi/tagbar'

	" 提供 GscopeFind 命令并自动处理好 gtags 数据库切换
	" 支持光标移动到符号名上：<leader>gg 查看定义，<leader>gs 查看引用
	Plug 'skywind3000/gutentags_plus'

	" 设定项目目录标志：除了 .git/.svn 外，还有 .root 文件
	let g:gutentags_project_root = ['.root', '.ccls', '.git', '.svn', 'compile_commands.json']
	let g:gutentags_ctags_tagfile = '.tags'

	" 默认生成的数据文件集中到 ~/.cache/tags 避免污染项目目录，好清理
	let g:gutentags_cache_dir = expand('~/.vimcache/tags')
	
	"只针对固定文件才生成tags 部分文件类型gungtags生成会导致crash
	let g:gutentags_enabled = 0
	augroup auto_gutentags
		au FileType python,java,shell,vim,c,c++,php,erlang,javascript,rust,go,lua,ruby,json,typescript let g:gutentags_enabled=1
	augroup end

	" 默认禁用自动生成
	let g:gutentags_modules = []
	if executable('ctags')
		let g:gutentags_modules += ['ctags']
	endif

	" 如果有 gtags 可执行就允许动态生成 gtags 数据库
	if executable('gtags') && executable('gtags-cscope')
		let g:gutentags_modules += ['gtags_cscope']
	endif

	let $GTAGSLABEL = 'native-pygments'

	"let $GTAGSLABEL = 'native'
	let $GTAGSCONF = '/data/home/pluswu/.vim/vim-init/.globalrc'

	let g:gutentags_define_advanced_commands = 1

	" 设置 ctags 的参数
	let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--c-kinds=+px', '--c++-kinds=+px']

	"for universal-ctags
	let g:gutentags_ctags_extra_args += ['--extras=+q', '--output-format=e-ctags']

	" 禁止 gutentags 自动链接 gtags 数据库
	let g:gutentags_auto_add_gtags_cscope = 0

endif

if index(g:bundle_group, 'coc') >= 0

	Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}

	" TextEdit might fail if hidden is not set.
	set hidden

	" Some servers have issues with backup files, see #649.
	set nobackup
	set nowritebackup

	" Give more space for displaying messages.
	set cmdheight=2

	" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
	" delays and poor user experience.
	set updatetime=300

	" Don't pass messages to |ins-completion-menu|.
	set shortmess+=c

	" Always show the signcolumn, otherwise it would shift the text each time
	" diagnostics appear/become resolved.
	if has("patch-8.1.1564")
		" Recently vim can merge signcolumn and number column into one
		set signcolumn=number
	else
		set signcolumn=yes
	endif

	" Use <C-l> for trigger snippet expand.
	imap <C-l> <Plug>(coc-snippets-expand)

	" Use <C-j> for select text for visual placeholder of snippet.
	vmap <C-j> <Plug>(coc-snippets-select)
	
	" " Use <C-j> for jump to next placeholder, it's default of coc.nvim
	 let g:coc_snippet_next = '<c-j>'
	
	" " Use <C-k> for jump to previous placeholder, it's default of coc.nvim
	 let g:coc_snippet_prev = '<c-k>'
	
	" Use <C-j> for both expand and jump (make expand higher priority.)
	 imap <C-j> <Plug>(coc-snippets-expand-jump)

	" Use tab for trigger completion with characters ahead and navigate.
	" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
	" other plugin before putting this into your config.
	inoremap <silent><expr> <TAB>
				\ pumvisible() ? "\<C-n>" :
				\ <SID>check_back_space() ? "\<TAB>" :
				\ coc#refresh()
	inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

	function! s:check_back_space() abort
		let col = col('.') - 1
		return !col || getline('.')[col - 1]  =~# '\s'
	endfunction

	" Use <c-space> to trigger completion.
	inoremap <silent><expr> <c-space> coc#refresh()
	

	" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
	" position. Coc only does snippet and additional edit on confirm.
	" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
	if exists('*complete_info')
		inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
	else
		inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
	endif
	

	" Use `[g` and `]g` to navigate diagnostics
	" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
	"nmap <silent> ]g <Plug>(coc-diagnostic-next)
	let g:coc_user_config = {}
	let g:coc_user_config['coc.preferences.jumpCommand'] = ':vsplit'

	" GoTo code navigation.
	nmap <silent> cd <Plug>(coc-definition)
	nmap <silent> cy <Plug>(coc-type-definition)
	nmap <silent> ci <Plug>(coc-implementation)
	nmap <silent> cr <Plug>(coc-references)

	" Use K to show documentation in preview window.
	"nnoremap <silent> K :call <SID>show_documentation()<CR>

	function! s:show_documentation()
		if (index(['vim','help'], &filetype) >= 0)
			execute 'h '.expand('<cword>')
		else
			call CocAction('doHover')
		endif
	endfunction

	"Highlight the symbol and its references when holding the cursor.
	"autocmd CursorHold * silent call CocActionAsync('highlight')

	" Symbol renaming.
	"nmap <leader>rn <Plug>(coc-rename)

	" Formatting selected code.
	"xmap <leader>f  <Plug>(coc-format-selected)
	"nmap <leader>f  <Plug>(coc-format-selected)

	augroup mygroup
		autocmd!
		" Setup formatexpr specified filetype(s).
		autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
		" Update signature help on jump placeholder.
		"autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
	augroup end

	" Applying codeAction to the selected region.
	" Example: `<leader>aap` for current paragraph
	"xmap <leader>a  <Plug>(coc-codeaction-selected)
	"nmap <leader>a  <Plug>(coc-codeaction-selected)

	" Remap keys for applying codeAction to the current buffer.
	"nmap <leader>ac  <Plug>(coc-codeaction)
	" Apply AutoFix to problem on the current line.
	"nmap <leader>qf  <Plug>(coc-fix-current)

	" Map function and class text objects
	" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
	"xmap if <Plug>(coc-funcobj-i)
	"omap if <Plug>(coc-funcobj-i)
	"xmap af <Plug>(coc-funcobj-a)
	"omap af <Plug>(coc-funcobj-a)
	"xmap ic <Plug>(coc-classobj-i)
	"omap ic <Plug>(coc-classobj-i)
	"xmap ac <Plug>(coc-classobj-a)
	"omap ac <Plug>(coc-classobj-a)

	" Use CTRL-S for selections ranges.
	" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
	"nmap <silent> <C-s> <Plug>(coc-range-select)
	"xmap <silent> <C-s> <Plug>(coc-range-select)

	" Add `:Format` command to format current buffer.
	" command! -nargs=0 Format :call CocAction('format')

	" Add `:Fold` command to fold current buffer.
	" command! -nargs=? Fold :call     CocAction('fold', <f-args>)

	" Add `:OR` command for organize imports of the current buffer.
	"command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

	" Add (Neo)Vim's native statusline support.
	" NOTE: Please see `:h coc-status` for integrations with external plugins that
	" provide custom statusline: lightline.vim, vim-airline.
	"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

	" Mappings for CoCList
	" Show all diagnostics.
	"nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
	" Manage extensions.
	"nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
	" Show commands.
	"nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
	" Find symbol of current document.
	"nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
	" Search workspace symbols.
	"nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
	" Do default action for next item.
	"nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
	" Do default action for previous item.
	"nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
	" Resume latest coc list.
	"nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
	
	 let g:coc_global_extensions = [
	              \ "coc-explorer",
	              \ "coc-lists",
	              \ "coc-vimlsp",
	              \ "coc-python",
	              \ "coc-tasks",
	              \ "coc-yank",
	              \ "coc-json",
	              \ "coc-vimtex",
	              \ "coc-html",
	              \ "coc-css",
	              \ "coc-tsserver"]
endif


"----------------------------------------------------------------------
" 文本对象：textobj 全家桶
"----------------------------------------------------------------------
if index(g:bundle_group, 'textobj') >= 0

	" 基础插件：提供让用户方便的自定义文本对象的接口
	Plug 'kana/vim-textobj-user'

	" indent 文本对象：ii/ai 表示当前缩进，vii 选中当缩进，cii 改写缩进
	Plug 'kana/vim-textobj-indent'

	" 语法文本对象：iy/ay 基于语法的文本对象
	Plug 'kana/vim-textobj-syntax'

	" 函数文本对象：if/af 支持 c/c++/vim/java
	Plug 'kana/vim-textobj-function', { 'for':['c', 'cpp', 'vim', 'java'] }

	" 参数文本对象：i,/a, 包括参数或者列表元素
	Plug 'sgur/vim-textobj-parameter'

	" 提供 python 相关文本对象，if/af 表示函数，ic/ac 表示类
	Plug 'bps/vim-textobj-python', {'for': 'python'}

	" 提供 uri/url 的文本对象，iu/au 表示
	Plug 'jceb/vim-textobj-uri'
endif

Plug 'rust-lang/rust.vim'

"----------------------------------------------------------------------
" 文件类型扩展
"----------------------------------------------------------------------
if index(g:bundle_group, 'filetypes') >= 0

	" powershell 脚本文件的语法高亮
	Plug 'pprovost/vim-ps1', { 'for': 'ps1' }

	" lua 语法高亮增强
	Plug 'tbastos/vim-lua', { 'for': 'lua' }

	" C++ 语法高亮增强，支持 11/14/17 标准
	Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['c', 'cc', 'cpp'] }

	" 额外语法文件
	Plug 'justinmk/vim-syntax-extra', { 'for': ['c', 'bison', 'flex', 'cpp'] }

	" python 语法文件增强
	Plug 'vim-python/python-syntax', { 'for': ['python'] }

	" rust 语法增强
	Plug 'rust-lang/rust.vim', { 'for': 'rust' }

	" vim org-mode 
	Plug 'jceb/vim-orgmode', { 'for': 'org' }
endif


"----------------------------------------------------------------------
" airline
"----------------------------------------------------------------------
if index(g:bundle_group, 'airline') >= 0
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	let g:airline_left_sep = ''
	let g:airline_left_alt_sep = ''
	let g:airline_right_sep = ''
	let g:airline_right_alt_sep = ''
	let g:airline_powerline_fonts = 0
	let g:airline_exclude_preview = 1
	let g:airline_section_b = '%n'
	let g:airline_theme='deus'
	let g:airline#extensions#branch#enabled = 0
	let g:airline#extensions#syntastic#enabled = 0
	let g:airline#extensions#fugitiveline#enabled = 0
	let g:airline#extensions#csv#enabled = 0
	let g:airline#extensions#vimagit#enabled = 0
endif

"----------------------------------------------------------------------
" NERDTree
"----------------------------------------------------------------------
if index(g:bundle_group, 'nerdtree') >= 0
	Plug 'preservim/nerdtree', {'on': ['NERDTree', 'NERDTreeFocus', 'NERDTreeToggle', 'NERDTreeCWD', 'NERDTreeFind'] }

	let g:NERDTreeHijackNetrw = 0
	let g:NERDTreeHijackNetrw = 0
	let g:WebDevIconsUnicodeDecorateFolderNodes = 1
	let g:DevIconsEnableFoldersOpenClose = 1
	let g:DevIconsDefaultFolderOpenSymbol='O' 
	let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol='o' 
endif

if index(g:bundle_group, 'neomake') >= 0
	Plug 'neomake/neomake'
endif

"----------------------------------------------------------------------
" YouCompleteMe 默认设置：YCM 需要你另外手动编译安装
"----------------------------------------------------------------------
"if index(g:bundle_group, 'ycm') >= 0
	"Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer',  'for': ['c', 'cpp'] }
"endif

"----------------------------------------------------------------------
" ale：动态语法检查
"----------------------------------------------------------------------
if index(g:bundle_group, 'ale') >= 0
	Plug 'w0rp/ale'

	" 设定延迟和提示信息
	let g:ale_completion_delay = 500
	let g:ale_echo_delay = 20
	let g:ale_lint_delay = 500
	let g:ale_echo_msg_format = '[%linter%] %code: %%s'

	" 设定检测的时机：normal 模式文字改变，或者离开 insert模式
	" 禁用默认 INSERT 模式下改变文字也触发的设置，太频繁外，还会让补全窗闪烁
	let g:ale_lint_on_text_changed = 'normal'
	let g:ale_lint_on_insert_leave = 1

	" 开启解析 compile_commands 的功能
	let g:ale_c_parse_compile_commands = 1
	"ale 将在工程目录下的 build 和 . 中搜索 compile_commands.json
	let g:ale_c_build_dir_names = ['build', '.']

	" 在 linux/mac 下降低语法检查程序的进程优先级（不要卡到前台进程）
	if has('win32') == 0 && has('win64') == 0 && has('win32unix') == 0
		let g:ale_command_wrapper = 'nice -n5'
	endif

	" 允许 airline 集成
	let g:airline#extensions#ale#enabled = 1

	" 编辑不同文件类型需要的语法检查器
	" ccls need g++ support feature c++14 
	" need .ccls_root for cpp project root find
	let g:ale_linters = {
				\ 'c': ['/opt/rh/devtoolset-7/root/usr/bin/gcc', 'ccls'],   
				\ 'cpp': ['/opt/rh/devtoolset-7/root/usr/bin/g++', 'ccls'], 
				\ 'python': ['flake8', 'pylint'], 
				\ 'lua': ['luac'], 
				\ 'go': ['go build', 'gofmt'],
				\ 'java': ['javac'],
				\ 'javascript': ['eslint'], 
				\ }
	let g:ale_c_ccls_init_options = {
				\ 'cache' : {'directory':'/data/home/pluswu/.ccls_cache/ccls_ale_cache'}
				\}	

	let g:ale_cpp_ccls_init_options = {
				\ 'cache' : {'directory':'/data/home/pluswu/.ccls_cache/ccls_ale_cache'}
				\}	

	" 获取 pylint, flake8 的配置文件，在 vim-init/tools/conf 下面
	function s:lintcfg(name)
		let conf = s:path('tools/conf/')
		let path1 = conf . a:name
		let path2 = expand('~/.vim/linter/'. a:name)
		if filereadable(path2)
			return path2
		endif
		return shellescape(filereadable(path2)? path2 : path1)
	endfunc

	" 设置 flake8/pylint 的参数
	let g:ale_python_flake8_options = '--conf='.s:lintcfg('flake8.conf')
	let g:ale_python_pylint_options = '--rcfile='.s:lintcfg('pylint.conf')
	let g:ale_python_pylint_options .= ' --disable=W'
	let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
	let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
	let g:ale_c_cppcheck_options = ''
	let g:ale_cpp_cppcheck_options = ''

	let g:ale_linters.text = ['textlint', 'write-good', 'languagetool']

endif


"----------------------------------------------------------------------
" echodoc：搭配 YCM/deoplete 在底部显示函数参数
"----------------------------------------------------------------------
if index(g:bundle_group, 'echodoc') >= 0
	"Plug 'Shougo/echodoc.vim'
	"set noshowmode
	"let g:echodoc#enable_at_startup = 1
endif

"----------------------------------------------------------------------
" LeaderF：CtrlP / FZF 的超级代替者，文件模糊匹配，tags/函数名 选择
"----------------------------------------------------------------------
if index(g:bundle_group, 'leaderf') >= 0
	" 如果 vim 支持 python 则启用  Leaderf
	if has('python') || has('python3')
		Plug 'Yggdroot/LeaderF'

		" CTRL+p 打开文件模糊匹配
		let g:Lf_ShortcutF = '<c-p>'

		" CTRL+n 打开最近使用的文件 MRU，进行模糊匹配
		noremap <leader>rf :Leaderf mru --regexMode<cr>

		" ALT+n 打开 buffer 模糊匹配
		let g:Lf_ShortcutB = '<m-n>'

		" CTRL+n 打开最近使用的文件 MRU，进行模糊匹配
		noremap <leader>rf :Leaderf mru --regexMode<cr>

		"noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
		"Alt+f 打开函数列表，按 i 进入模糊匹配，ESC 退出
		noremap <leader>pf :LeaderfFunction!<cr>
		" ALT+p 打开 tag 列表，i 进入模糊匹配，ESC退出
		noremap <m-p> :LeaderfBufTag!<cr>

		" ALT+m 全局 tags 模糊匹配
		noremap <m-m> :LeaderfTag<cr>

		" 最大历史文件保存 2048 个
		let g:Lf_MruMaxFilepygments_parser = 2048

		" ui 定制
		let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }

		" 如何识别项目目录，从当前文件目录向父目录递归知道碰到下面的文件/目录
		let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git', 'compile_commands.json']
		let g:Lf_WorkingDirectoryMode = 'Ac'
		let g:Lf_WindowHeight = 0.30
		let g:Lf_CacheDirectory = expand('~/.vim/leaderf_cache')

		" 显示绝对路径
		let g:Lf_ShowRelativePath = 1

		" 隐藏帮助
		let g:Lf_HideHelp = 1

		let g:Lf_UseVersionControlTool = 0
		" 模糊匹配忽略扩展名
		let g:Lf_WildIgnore = {
					\ 'dir': ['.svn','.git', '.hg', '.ccls-cache'],
					\ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]']
					\ }

		" MRU 文件忽略扩展名
		let g:Lf_MruFileExclude = ['*.so', '.o', '*.exe', '*.py[co]', '*.sw?', '~$*', '*.bak', '*.tmp', '*.dll']
		let g:Lf_StlColorscheme = 'powerline'

		let g:Lf_WindowPosition = 'popup'
		let g:Lf_PreviewInPopup = 1
		" 禁用 function/buftag 的预览功能，可以手动用 p 预览
		let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}

		" 使用 ESC 键可以直接退出 leaderf 的 normal 模式
		let g:Lf_NormalMap = {
				\ "File":   [["<ESC>", ':exec g:Lf_py "fileExplManager.quit()"<CR>']],
				\ "Buffer": [["<ESC>", ':exec g:Lf_py "bufExplManager.quit()"<cr>']],
				\ "Mru": [["<ESC>", ':exec g:Lf_py "mruExplManager.quit()"<cr>']],
				\ "Tag": [["<ESC>", ':exec g:Lf_py "tagExplManager.quit()"<cr>']],
				\ "BufTag": [["<ESC>", ':exec g:Lf_py "bufTagExplManager.quit()"<cr>']],
				\ "Function": [["<ESC>", ':exec g:Lf_py "functionExplManager.quit()"<cr>']],
				\ }

		let g:Lf_GtagsAutoGenerate = 1
		"let g:Lf_Gtagslabel = 'native'
		let g:Lf_Gtagslabel = 'native-pygments'
		let g:Lf_Gtagsconf = '/data/home/pluswu/.vim/vim-init/.globalrc'
	else
		" 不支持 python ，使用 CtrlP 代替
		Plug 'ctrlpvim/ctrlp.vim'

		" 显示函数列表的扩展插件
		Plug 'tacahiroy/ctrlp-funky'

		" 忽略默认键位
		let g:ctrlp_map = ''

		" 模糊匹配忽略
		let g:ctrlp_custom_ignore = {
		  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
		  \ 'file': '\v\.(exe|so|dll|mp3|wav|sdf|suo|mht)$',
		  \ 'link': 'some_bad_symbolic_links',
		  \ }

		" 项目标志
		let g:ctrlp_root_markers = ['.project', '.root', '.svn', '.git', '.ccls', '.project']
		let g:ctrlp_working_path = 0

		" CTRL+p 打开文件模糊匹配
		noremap <c-p> :CtrlP<cr>

		" CTRL+n 打开最近访问过的文件的匹配
		noremap <c-n> :CtrlPMRUFiles<cr>

		" ALT+p 显示当前文件的函数列表
		noremap <m-p> :CtrlPFunky<cr>

		" ALT+n 匹配 buffer
		noremap <m-n> :CtrlPBuffer<cr>
	endif
endif

Plug 'skywind3000/vim-quickui'

Plug 'skywind3000/asyncrun.vim'

Plug 'skywind3000/vim-terminal-help'

Plug 'scrooloose/nerdcommenter'

Plug 'liwangmj/vim-switchtoinc'

Plug 'luochen1990/rainbow'

"----------------------------------------------------------------------
" 结束插件安装
"----------------------------------------------------------------------
call plug#end()

"rainbow
let g:rainbow_active = 1

let g:rainbow_load_separately = [
    \ [ '*' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.tex' , [['(', ')'], ['\[', '\]']] ],
    \ [ '*.{cpp, c}' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.{html,htm}' , [['(', ')'], ['\[', '\]'], ['{', '}'], ['<\a[^>]*>', '</[^>]*>']] ],
    \ ]

let g:rainbow_guifgs = ['RoyalBlue3', 'DarkOrange3', 'DarkOrchid3', 'FireBrick']
let g:rainbow_ctermfgs = ['lightblue', 'lightgreen', 'yellow', 'red', 'magenta']

if index(g:bundle_group, 'ycm') >= 0
	" 禁用预览功能：扰乱视听
	let g:ycm_add_preview_to_completeopt = 0

	" 禁用诊断功能：我们用前面更好用的 ALE 代替
	let g:ycm_show_diagnostics_ui = 0
	let g:ycm_server_log_level = 'info'
	let g:ycm_min_num_identifier_candidate_chars = 2
	let g:ycm_collect_identifiers_from_comments_and_strings = 1
	let g:ycm_complete_in_strings=1
	let g:ycm_key_invoke_completion = '<c-z>'
	set completeopt=menu,menuone,noselect
	let g:ycm_confirm_extra_conf = 0
	"noremap <c-z> <NOP>

	" 两个字符自动触发语义补全
	let g:ycm_semantic_triggers =  {
				\ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
				\ 'cs,lua,javascript': ['re!\w{2}'],
				\ }

	"----------------------------------------------------------------------
	" Ycm 白名单（非名单内文件不启用 YCM），避免打开个 1MB 的 txt 分析半天
	"----------------------------------------------------------------------
	let g:ycm_filetype_whitelist = { 
				\ "c":1,
				\ "cpp":1, 
				\ "cc":1, 
				\ "objc":1,
				\ "objcpp":1,
				\ "python":1,
				\ "java":1,
				\ "javascript":1,
				\ "coffee":1,
				\ "vim":1, 
				\ "go":1,
				\ "cs":1,
				\ "lua":1,
				\ "perl":1,
				\ "perl6":1,
				\ "php":1,
				\ "ruby":1,
				\ "rust":1,
				\ "erlang":1,
				\ "asm":1,
				\ "nasm":1,
				\ "masm":1,
				\ "tasm":1,
				\ "asm68k":1,
				\ "asmh8300":1,
				\ "asciidoc":1,
				\ "basic":1,
				\ "vb":1,
				\ "make":1,
				\ "cmake":1,
				\ "html":1,
				\ "css":1,
				\ "less":1,
				\ "json":1,
				\ "cson":1,
				\ "typedscript":1,
				\ "haskell":1,
				\ "lhaskell":1,
				\ "lisp":1,
				\ "scheme":1,
				\ "sdl":1,
				\ "sh":1,
				\ "zsh":1,
				\ "bash":1,
				\ "man":1,
				\ "markdown":1,
				\ "matlab":1,
				\ "maxima":1,
				\ "dosini":1,
				\ "conf":1,
				\ "config":1,
				\ "zimbu":1,
				\ "ps1":1,
				\ }
endif

if index(g:bundle_group, 'neomake') >= 0
	" When writing a buffer (no delay).
	call neomake#configure#automake('w')
	" When writing a buffer (no delay), and on normal mode changes (after 750ms)
	call neomake#configure#automake('nw', 750)
	" When reading a buffer (after 1s), and when writing (no delay).
	call neomake#configure#automake('rw', 1000)
	" Full config: when writing or reading a buffer, and on changes in insert
	" normal mode (after 500ms; no delay when witing).
	call neomake#configure#automake('nrwi', 500)
endif 



