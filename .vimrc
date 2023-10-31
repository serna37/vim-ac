" vim:set foldmethod=marker:
let mapleader = "\<SPACE>"

" ==============================================================================
" =====================         CONTENTS         ===============================
" ============================================================================== {{{
" alse see [https://github.com/serna37/vim/]
"    CONTENTS
"
"     # BASIC VIM SETTINGS
"         ## FILE .................. | file encoding, charset, vim specific setting.
"         ## VISUALIZATION ......... | enhanced visual information.
"         ## WINDOW ................ | window forcus, resize, open terminal.
"         ## MOTION ................ | row move, scroll, mark, IDE action menu.
"         ## EDIT .................. | insert mode cursor, block move.
"         ## COMPLETION ............ | indent, word completion.
"         ## SEARCH ................ | incremental search, emotion, fzf, grep, explorer.
"         ## OTHERS ................ | fast terminal, reg engin, fold.
"
"     # FUNCTIONS
"         ## ORIGINALS ............. | original / adhoc functions.
"         ## IMITATIONS ............ | imitated plugins as functions.
"         ## PLUG MANAGE ........... | plugin manager functions.
"         ## TRAINING .............. | training default vim functions.
"
"     # PLUGINS SETTING
"         ## PLUGIN VARIABLES ...... | setting for plugins without conflict.
"         ## PLUGIN KEYMAP ......... | setting for plugins without conflict.
"
"     # STARTING
"         ## STARTING .............. | functions called when vim started.
"
" ==============================================================================
" }}}

" #############################################################
" ###############      BASIC VIM SETTINGS       ###############
" #############################################################
" {{{
" ##################          FILE          ################### {{{
" file
set fileformat=unix " LF
set fileencoding=utf8 " charset
" vim specific
set noswapfile " no create swap file
set nobackup " no create backup file
set noundofile " no create undo file
set hidden " enable go other buffer without save
set autoread " re read file when changed outside vim
set clipboard+=unnamed " copy yanked fot clipboard
" reopen, go row
aug reopenGoRow
    au!
    au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") | exe "norm g`\"" | endif
aug END
" }}}

" ##################     VISUALIZATION      ################### {{{
" enable syntax highlight
syntax on
" window
set background=dark " basic color
set title " show filename on terminal title
set showcmd " show enterd command on right bottom
" visible
set list " show invisible char
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:% " custom invisible char
" row number + relativenumber
set number relativenumber
" always show sign column width
set signcolumn=yes
" cursor
set scrolloff=5 " page top bottom offset view row
set cursorline cursorcolumn " show cursor line/column
set ruler " show row/col position number at right bottom
" show status, tabline
set laststatus=2 showtabline=2
" }}}

" ##################         WINDOW        ################### {{{
" simeji/winresizer
" window forcus move
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j
set termwinkey=<C-k>
tnoremap <C-h> <C-k>h
tnoremap <C-l> <C-k>l
tnoremap <C-k> <C-k>k
tnoremap <C-j> <C-k>j
set splitright
" window resize
nnoremap <Left> 4<C-w><
nnoremap <Right> 4<C-w>>
nnoremap <Up> 4<C-w>-
nnoremap <Down> 4<C-w>+
" move buffer
nmap <C-n> <Plug>(buf-prev)
nmap <C-p> <Plug>(buf-next)
" terminal
" TODO popup terminal Esc, arrow keys and so on
" terminal read only mode (i to return terminal mode)
tnoremap <C-w> <Esc><BS>
" zen
nmap <Leader>z <Plug>(zen-mode)
" }}}

" ##################         MOTION         ################### {{{
" row move
nnoremap j gj
nnoremap k gk
vnoremap <Tab> 5gj
vnoremap <S-Tab> 5gk
nmap <Tab> 5j<Plug>(anchor)
nmap <S-Tab> 5k<Plug>(anchor)
nmap H H<Plug>(anchor)
nmap M M<Plug>(anchor)
nmap L L<Plug>(anchor)
" comfortable scroll
nmap <C-u> <Plug>(scroll-u)
nmap <C-d> <Plug>(scroll-d)
nmap <C-b> <Plug>(scroll-b)
nmap <C-f> <Plug>(scroll-f)
" f-scope toggle
nmap <Leader>w <Plug>(f-scope)
" IDE action menu
nmap <Leader>v <Plug>(ide-menu)
" }}}

" ##################         EDIT           ################### {{{
" basic
set virtualedit=all " virtual cursor movement
set whichwrap=b,s,h,l,<,>,[,],~ " motion over row
set backspace=indent,eol,start " backspace attitude on insert mode
" parentheses
set showmatch " jump pair of parentheses when write
set matchtime=3 " jump term sec
" move cursor at insert mode
inoremap <C-h> <C-o>h
inoremap <C-l> <C-o>l
inoremap <C-k> <C-o>k
inoremap <C-j> <C-o>j
" d = delete(no clipboard)
nnoremap d "_d
vnoremap d "_d
" x = cut(yank register)
nnoremap x "+x
vnoremap x "+x
" p P = paste(from yank register)
nnoremap p "+p
nnoremap P "+P
vnoremap p "+p
vnoremap P "+P
" block move at visual mode
vnoremap <C-j> "zx"zp`[V`]
vnoremap <C-k> "zx<Up>"zP`[V`]
" }}}

" ##################       COMPLETION       ################### {{{
" indent
set autoindent " uses the indent from the previous line
set smartindent " more smart indent than autoindent
set smarttab " use shiftwidth
set shiftwidth=4 " auto indent width
set tabstop=4 " view width of Tab
set expandtab " Tab to Space
" word
set wildmenu " command mode completion enable
set wildchar=<Tab> " command mode comletion key
set wildmode=full " command mode completion match mode
set complete=.,w,b,u,U,k,kspell,s,i,d,t " insert mode completion resource
set completeopt=menuone,noinsert,preview,popup " insert mode completion window
" completion with Tab
inoremap <expr><CR> pumvisible() ? '<C-y>' : '<CR>'
inoremap <expr><Tab> pumvisible() ? '<C-n>' : '<C-t>'
inoremap <expr><S-Tab> pumvisible() ? '<C-p>' : '<S-Tab>'
" }}}

" ##################         SEARCH         ################### {{{
" search
set incsearch " incremental search
set hlsearch " highlight match words
set ignorecase " ignore case search
set smartcase " don't ignore case when enterd UPPER CASE"
set shortmess-=S " show hit word's number at right bottom
" no move search word with multi highlight
nmap # *N<Plug>(qikhl-toggle)
nmap <silent><Leader>q <Plug>(qikhl-clear):noh<CR>
nmap s <Plug>(emotion)
" }}}

" ##################         OTHERS         ################### {{{
" basic
scriptencoding utf-8 " this file's charset
set ttyfast " fast terminal connection
set regexpengine=0 " chose regexp engin
" }}}
" }}}

" #############################################################
" ##################       FUNCTIONS        ###################
" #############################################################
" {{{
" ##################       ORIGINALS        ################### {{{

" popup terminal {{{
fu! s:popup_terminal() abort
    cal popup_create(term_start([&shell],#{hidden:1,term_finish:'close'}),#{border:[],minwidth:&columns*3/4,minheight:&lines*3/4})
    tnoremap <buffer><Esc> <C-w>N
endf

" TODO refactor
nnoremap <Leader>t :cal <SID>popup_terminal()<CR>

" TODO WIP
" grep を IDE menuに
" gキーをgitに
" all push いらないか？

" for lazygit
" }}}


" color echo/echon, input {{{
fu! s:echo_n(hi, flg, msg) abort
    exe 'echohl '.a:hi
    exe printf('echo%s "%s"', a:flg, a:msg)
    echohl None
endf

let s:echoE = { msg, ... -> s:echo_n('DarkRed', a:0 ? 'n' : '', msg) }
let s:echoW = { msg, ... -> s:echo_n('DarkOrange', a:0 ? 'n' : '', msg) }
let s:echoI = { msg, ... -> s:echo_n('DarkBlue', a:0 ? 'n' : '', msg) }

fu! s:_input(hi, msg, arr)abort
    exe 'echohl '.a:hi
    if len(a:arr)->empty()
        let w = input(a:msg)
    elseif len(a:arr) == 1
        let w = input(a:msg, a:arr[0])
    elseif len(a:arr) == 2
        let w = input(a:msg, a:arr[0], a:arr[1])
    endif
    echohl None
    retu w
endf

let s:inputE = { msg, ... -> s:_input('DarkRed', msg, a:000) }
let s:inputW = { msg, ... -> s:_input('DarkOrange', msg, a:000) }
let s:inputI = { msg, ... -> s:_input('DarkBlue', msg, a:000) }

aug logging_char_color
    au!
    au ColorScheme * hi DarkRed ctermfg=204
    au ColorScheme * hi DarkOrange ctermfg=180
    au ColorScheme * hi DarkBlue ctermfg=39
aug END
" }}}


" Tab 5row Anchor {{{
sign define anch text=➤ texthl=DarkRed
let s:anchor = #{tid: 0,
    \ getlines: { l -> l-5 > 0 ? [l-5, l, l+5] : [l, l+5] },
    \ put: { f, l -> sign_place(0, 'anchor', 'anch', f, #{lnum: l}) },
    \ rm: { tid -> sign_unplace('anchor') },
    \ }

fu! s:anchor.set() abort
    cal timer_stop(self.tid)
    cal self.rm(0)
    cal self.getlines(line('.'))->map({ _,v -> self.put(bufname('%'), v) })
    let self.tid = timer_start(2000, self.rm)
endf

fu! s:anchor() abort
    cal s:anchor.set()
endf

noremap <silent><Plug>(anchor) :<C-u>cal <SID>anchor()<CR>
" }}}


" IDE menu {{{
let s:idemenu = #{
    \ menuid: 0, mttl: ' IDE MENU (j / k) Enter choose | * require plugin ',
    \ menu: [
        \ '[⚙︎Test]          test by oj cmd',
        \ '[Format]         applay format for this file',
        \ '[ReName]         rename current word recursively',
        \ '[⚖︎ContestCode]   checkout contest code',
        \ '[Snippet]        edit snippets',
        \ '[✔︎All Cut]       copy all and delete',
    \ ],
    \ cheatid: 0, cheattitle: ' LSP KeyMaps ',
    \ cheat: [
        \ ' (Space d) [Definition]     Go to Definition ',
        \ ' (Space r) [Reference]      Reference ',
        \ ' (Space o) [Outline]        view outline on popup ',
        \ ' (Space ?) [Document]       show document on popup scroll C-f/b ',
        \ ' (Space ,) [Next Diagnosis] jump next diagnosis ',
        \ ' (Space .) [Prev Diagnosis] jump prev diagnosis ',
    \ ],
    \ }

fu! s:idemenu.open() abort
    let self.menuid = popup_menu(self.menu, #{title: self.mttl, border: [], borderchars: ['─','│','─','│','╭','╮','╯','╰'],
        \ callback: 'Idemenu_exe'})
    cal setwinvar(self.menuid, '&wincolor', 'User_greenfg_blackbg')
    cal matchadd('DarkRed', '\[.*\]', 16, -1, #{window: self.menuid})
    let self.cheatid = popup_create(self.cheat, #{title: self.cheattitle, line: &lines-5})
    cal setwinvar(self.cheatid, '&wincolor', 'User_greenfg_blackbg')
    cal matchadd('DarkRed', '\[.*\]', 16, -1, #{window: self.cheatid})
    cal matchadd('DarkBlue', '(.*)', 16, -1, #{window: self.cheatid})
endf

fu! Idemenu_exe(_, idx) abort
    if a:idx == 1
        " ❯ python3 -m pip install online-judge-tools
        let w = s:inputI('which test (lower case like a):')
        let pre = 'cd ~/work/ac_js && rm -rf test && cat contest_setting.txt | xargs -I {} oj d https://atcoder.jp/contests/{}/tasks/{}_'.w
        cal system(pre)
        let cmd = 'cd ~/work/ac_js && oj t -c "node main.js"'
        sil! exe 'vne ac_test'
        setl buftype=nofile bufhidden=wipe modifiable
        setl nonumber norelativenumber nocursorline nocursorcolumn signcolumn=no
        setl filetype=log
        cal matchadd('DarkBlue', 'SUCCESS')
        sil! exe 'r!'.cmd
    elseif a:idx == 2
        " TODO ide menu format 選択部分のみをしたい
        if exists(':Coc')
            cal CocActionAsync('format')
        else
            execute('norm gg=G'.line('.').'G')
        endif
    elseif a:idx == 3
        if exists(':Coc')
            cal CocActionAsync('rename')
        else
            cal s:echoE('Sorry, [ReName*] needs coc.nvim.')
            cal popup_close(s:idemenu.cheatid)
            retu 1
        endif

    elseif a:idx == 4
        let w = readfile('contest_setting.txt')[0]
        let code = s:inputI('AtCode Contest Code :', w)
        cal writefile([code], 'contest_setting.txt')
        cal popup_close(s:idemenu.cheatid)
        retu 1
    elseif a:idx == 5
        if exists(':CocCommand')
            exe 'CocCommand snippets.editSnippets'
        else
            cal s:echoE('Sorry, [Snippet*] needs coc.nvim.')
            cal popup_close(s:idemenu.cheatid)
            retu 1
        endif
    elseif a:idx == 6
        exe '%d'
        cal popup_close(s:idemenu.cheatid)
        retu 1
    endif
    cal popup_close(s:idemenu.cheatid)
    retu 0
endf

fu! s:idemenu() abort
    cal s:idemenu.open()
endf
noremap <silent><Plug>(ide-menu) :<C-u>cal <SID>idemenu()<CR>
" }}}



" }}}

" ##################       IMITATIONS       ################### {{{


" ===================================================================
" vim-airline/vim-airline
" ===================================================================
" {{{
let g:right_arrow = ''
let g:left_arrow = ''

let g:modes = {
    \ 'i': ['#User_blackfg_bluebg_bold#', '#User_bluefg_blackbg#', 'INSERT'],
    \ 'n': ['#User_blackfg_greenbg_bold#', '#User_greenfg_blackbg#', 'NORMAL'],
    \ 'R': ['#User_blackfg_redbg_bold#', '#User_redfg_blackbg#', 'REPLACE'],
    \ 'c': ['#User_blackfg_greenbg_bold#', '#User_greenfg_blackbg#', 'COMMAND'],
    \ 't': ['#User_blackfg_redbg_bold#', '#User_redfg_blackbg#', 'TERMIAL'],
    \ 'v': ['#User_blackfg_pinkbg_bold#', '#User_pinkfg_blackbg#', 'VISUAL'],
    \ 'V': ['#User_blackfg_pinkbg_bold#', '#User_pinkfg_blackbg#', 'VISUAL'],
    \ "\<C-v>": ['#User_blackfg_pinkbg_bold#', '#User_pinkfg_blackbg#', 'VISUAL'],
    \ }

let g:ff_table = {'dos' : 'CRLF', 'unix' : 'LF', 'mac' : 'CR'}

let g:gitinf = 'AtCoder '
fu! g:SetStatusLine() abort
    let mode = get(g:modes, mode(), ['#User_blackfg_redbg_bold#', '#User_redfg_blackbg#', 'SP'])
    " start menu BTR
    if &filetype == 'AtCoder'
        let mode = ['#User_blackfg_greenbg_bold#', '#User_greenfg_blackbg#', 'AtCoder']
    endif
    retu '%'.mode[0].' '.mode[2].' '.'%'.mode[1].g:right_arrow.'%#User_blackfg_graybg#'.g:right_arrow
        \ .'%#User_greenfg_graybg# %<%f%m%r%h%w %#User_grayfg_blackbg#'.g:right_arrow
        \ .'%#User_greenfg_blackbg# %{g:gitinf}%*'.g:right_arrow
        \ .'%* %='
        \ .'%*'.g:left_arrow.'%#User_greenfg_blackbg# %{&filetype}'
        \ .' %#User_grayfg_blackbg#'.g:left_arrow.'%#User_greenfg_graybg# %p%% %l/%L %02v%#User_blackfg_graybg#'.g:left_arrow
        \ .'%'.mode[1].g:left_arrow.'%'.mode[0].' [%{&fenc!=""?&fenc:&enc}][%{g:ff_table[&ff]}] %*'
endf
set stl=%!g:SetStatusLine()

" tabline
fu! s:buffers_label() abort
    " airline TODO リファクタ
    let b = ''
    for v in split(execute('ls'), '\n')->map({ _,v -> split(v, ' ')})
        let x = copy(v)->filter({ _,v -> !empty(v) })
        if stridx(x[1], 'F') == -1 && stridx(x[1], 'R') == -1
            let hi = stridx(x[1], '%') != -1 ? '%#User_blackfg_greenbg#' : '%#User_greenfg_graybg#'
            let hiar = stridx(x[1], '%') != -1 ? '%#User_greenfg_blackbg#' : '%#User_grayfg_blackbg#'
            let hiarb = stridx(x[1], '%') != -1 ? '%#User_blackfg_greenbg#' : '%#User_blackfg_graybg#'
            if x[2] == '+'
                let hi = '%#User_blackfg_bluebg#'
                let hiar = '%#User_bluefg_blackbg#'
                let hiarb = '%#User_blackfg_bluebg#'
            endif
"[^/]*$
            let f = x[2] == '+' ? '✗'.matchstr(join(split(x[3],'"'),''),'[^/]*$') : matchstr(join(split(x[2],'"'),''),'[^/]*$')
            let b = b.'%'.x[0].'T'.hiarb.g:right_arrow.hi.f.hiar.g:right_arrow
        endif
    endfor
    retu b
endf
fu! s:tabpage_label(n) abort
    let hi = a:n is tabpagenr() ? '%#User_blackfg_greenbg#' : '%#User_greenfg_graybg#'
    let bufnrs = tabpagebuflist(a:n)
    let no = len(bufnrs)
    if no is 1
        let no = ''
    endif
    let mod = len(filter(copy(bufnrs), 'getbufvar(v:val, "&modified")')) ? '✗' : ''
    let fname = pathshorten(bufname(bufnrs[tabpagewinnr(a:n) - 1]))
    retu '%'.a:n.'T'.hi.no.mod.fname.' ⁍|'.'%T%#TabLineFill#'
endf
fu! g:SetTabLine() abort
    if tabpagenr('$') == 1
        retu s:buffers_label()
    endif
    retu range(1,tabpagenr('$'))->map('s:tabpage_label(v:val)')->join(' ').' %#TabLineFill#%T'
endf
set tabline=%!g:SetTabLine()

fu! s:moveBuf(flg) abort
    let current_id = ''
    let buf_arr = []
    for v in split(execute('ls'), '\n')->map({ _,v -> split(v, ' ')})
        let x = copy(v)->filter({ _,v -> !empty(v) })
        if stridx(x[1], 'F') == -1 && stridx(x[1], 'R') == -1
            cal add(buf_arr, x[0])
            if stridx(x[1], '%') != -1
                let current_id = x[0]
            endif
        endif
    endfor
    let buf_idx = a:flg == 'next' ? match(buf_arr, current_id) + 1 : match(buf_arr, current_id) - 1
    let buf_id = buf_idx == len(buf_arr) ? buf_arr[0] : buf_arr[buf_idx]
    exe 'b '.buf_id
endf

aug user_onedark
    au!
    au ColorScheme * hi User_greenfg_blackbg ctermfg=114 ctermbg=235
    au ColorScheme * hi User_greenfg_graybg ctermfg=114 ctermbg=238
    au ColorScheme * hi User_bluefg_blackbg ctermfg=39 ctermbg=235
    au ColorScheme * hi User_pinkfg_blackbg ctermfg=169 ctermbg=235
    au ColorScheme * hi User_redfg_blackbg ctermfg=203 ctermbg=235
    au ColorScheme * hi User_grayfg_blackbg ctermfg=238 ctermbg=235
    au ColorScheme * hi User_blackfg_graybg ctermfg=235 ctermbg=238
    au ColorScheme * hi User_blackfg_greenbg ctermfg=235 ctermbg=114
    au ColorScheme * hi User_blackfg_greenbg_bold cterm=bold ctermfg=234 ctermbg=114
    au ColorScheme * hi User_blackfg_bluebg ctermfg=235 ctermbg=39
    au ColorScheme * hi User_blackfg_bluebg_bold cterm=bold ctermfg=234 ctermbg=39
    au ColorScheme * hi User_blackfg_pinkbg_bold cterm=bold ctermfg=234 ctermbg=170
    au ColorScheme * hi User_blackfg_redbg_bold cterm=bold ctermfg=234 ctermbg=204
aug END

noremap <silent><Plug>(buf-prev) :<C-u>cal <SID>moveBuf('prev')<CR>
noremap <silent><Plug>(buf-next) :<C-u>cal <SID>moveBuf('next')<CR>
" }}}




" ===================================================================
" yuttie/comfortable-motion.vim
" ===================================================================
" {{{
" while scroll, deactivate f-scope
let s:scroll = #{tid: 0, curL: '', curC: '', till: 600}

" TODO scroll sometimes so heavy. mainly C-f timer wrong?
fu! s:scroll.exe(vector, delta) abort
    if self.tid
        retu
    endif
    cal timer_stop(self.tid)
    cal self.toggle(0)
    let vec = a:vector ? "\<C-e>" : "\<C-y>"
    let self.tid = timer_start(a:delta, { -> feedkeys(vec) }, #{repeat: -1})
    cal timer_start(self.till, self.stop)
    cal timer_start(self.till, self.toggle)
endf

fu! s:scroll.stop(_) abort
    cal timer_stop(self.tid)
    let self.tid = 0
endf

fu! s:scroll.toggle(tid) abort
    if !a:tid
        let self.curL = execute('set cursorline?')->trim()
        let self.curC = execute('set cursorcolumn?')->trim()
        set nocursorline nocursorcolumn
        cal timer_start(0, { -> s:fmode.deactivate() }) " for coc, async
        retu
    endif
    if self.curL !~'^no'
        set cursorline
    endif
    if self.curC !~'^no'
        set cursorcolumn
    endif
    cal s:fmode.takeover()
endf

fu! s:scroll(v, d) abort
    cal s:scroll.exe(a:v, a:d)
endf
noremap <silent><Plug>(scroll-d) :<C-u>cal <SID>scroll(1, 30)<CR>
noremap <silent><Plug>(scroll-u) :<C-u>cal <SID>scroll(0, 30)<CR>
noremap <silent><Plug>(scroll-f) :<C-u>cal <SID>scroll(1, 10)<CR>
noremap <silent><Plug>(scroll-b) :<C-u>cal <SID>scroll(0, 10)<CR>

fu! Scroll(vec, del) abort " for coc
    cal s:scroll(a:vec, a:del)
    retu "\<Ignore>"
endf
" }}}

" ===================================================================
" easymotion/vim-easymotion
" ===================================================================
" {{{
" m, g read some function doesn't work just as I want
let s:emotion = #{keypos: [], klen: 1, keys: ['s', 'w', 'a', 'd', 'j', 'k', 'h', 'l'], popid: 0}

fu! s:emotion.exe() abort
    " fold all open
    norm zR
    " get target chars in current window without empty line
    " [{'row': row number, 'col': [ col number, ... ]}...]
    let self.keypos = []
    let self.klen = 1
    let wininfo = []
    let tarcnt = 0
    let rn = line('w0')
    let self.cl = line('.')
    let self.cc = col('.')
    let self.sl = line('w0')
    let self.ctx = getline('w0', 'w$')
    for l in self.ctx
        " loop row without 'including MultiByte' and 'empty', get head chars
        " 日本語は1文字でマルチバイト3文字分だが、カーソル幅は2なのでめんどい、日本語を含む行は弾く
        if l !~ '^[ -~|\t]\+$'
            let rn+=1
            continue
        endif
        let chars = []
        let ofst = 0
        while ofst != -1
            let st = matchstrpos(l, '\<.', ofst)
            let ofst = matchstrpos(l, '.\>', ofst)[2]
            if st[0] != ''
                cal add(chars, st[2])
            endif
        endwhile
        if !empty(chars)
            cal add(wininfo, #{row: rn, col: chars})
        endif
        let tarcnt = tarcnt+len(chars)
        let rn+=1
    endfor
    if tarcnt==0
        retu
    endif
    " calc key stroke length, keyOrder is 'ssw' = [0,0,1]
    while tarcnt > pow(len(self.keys), self.klen)
        let self.klen+=1
    endwhile
    let keyOrder = range(1, self.klen)->map({->0})
    " sort near current line, create 'self_keypos' map like this
    " [{'row': 1000, 'col': [{'key': 'ssw', 'pos': 7}, ... ]}, ... ]
    for r in sort(deepcopy(wininfo), { x,y -> abs(x.row-self.cl) - abs(y.row-self.cl) })
        let tmp = []
        for col in r.col
            cal add(tmp, #{key: copy(keyOrder)->map({i,v->self.keys[v]})->join(''), pos: col})
            let keyOrder = self.incrementNOrder(len(self.keys)-1, keyOrder)
        endfor
        cal add(self.keypos, #{row: r.row, col: tmp})
    endfor
    " create preview window
    sil! e 'emotion'
    setl buftype=nofile bufhidden=wipe nobuflisted
    " fill blank
    cal setline(1, range(1, self.sl))
    cal self.previewini()
    " disable diagnostic
    if exists('*CocAction')
        cal CocAction('diagnosticToggle')
    endif
    " draw
    cal matchadd('EmotionBase', '.', 98)
    cal self.draw(self.keypos)
    cal popup_close(self.popid)
    let self.popid = popup_create('e-motion', #{line: &lines, col: &columns*-1, mapping: 0, filter: self.char_enter})
    cal setwinvar(self.popid, '&wincolor', 'DarkBlue')
    echo ''
endf

fu! s:emotion.previewini() abort
    " restore contents
    cal setline(self.sl, self.ctx)
    " restore cursor position
    cal cursor(self.sl+5, self.cc)
    norm! zt
    cal cursor(self.cl, self.cc)
endf

" function: increment N order
" 配列をN進法とみなし、1増やす. 使うキーがssf → sws と繰り上がる仕組み
fu! s:emotion.incrementNOrder(nOrder, keyOrder) abort
    if len(a:keyOrder) == 1
        retu [a:keyOrder[0]+1]
    endif
    let tmp = []
    let overflow = 0
    for idx in reverse(range(0, len(a:keyOrder)-1))
        " 1. increment last digit
        if idx == len(a:keyOrder)-1
            cal insert(tmp, a:keyOrder[idx] == a:nOrder ? 0 : a:keyOrder[idx]+1)
            if tmp[0] == 0
                let overflow = 1
            endif
            continue
        endif
        " 2. check next digit
        if overflow
            cal insert(tmp, a:keyOrder[idx] == a:nOrder ? 0 : a:keyOrder[idx]+1)
            let overflow = a:keyOrder[idx] == a:nOrder ? 1 : 0
        else
            cal insert(tmp, a:keyOrder[idx])
        endif
    endfor
    retu tmp
endf

" draw keystroke
" 日本語は1文字でマルチバイト3文字分だが、カーソル幅は2なのでめんどいから弾いてある
" posの次文字がマルチバイトだと、strokeが2回以上残ってる時、変に文字を書き換えてカラム数変わる
fu! s:emotion.draw(keypos) abort
    cal self.previewini()
    cal self.hl_del(['EmotionFin', 'EmotionWip'])
    let hlpos_wip = []
    let hlpos_fin = []
    for r in a:keypos
        let line = getline(r.row)
        for c in r.col
            let colidx = c.pos-1
            let view_keystroke = c.key[:0]
            let offset = colidx-1
            cal add(hlpos_fin, [r.row, c.pos])
            if len(c.key)>=2
                let view_keystroke = c.key[:1]
                cal add(hlpos_wip, [r.row, c.pos, 2])
            endif
            let line = colidx == 0
                \ ? view_keystroke.line[len(view_keystroke):]
                \ : line[0:offset].view_keystroke.line[colidx+len(view_keystroke):]
        endfor
        cal setline(r.row, line)
    endfor
    for t in hlpos_fin
        cal matchaddpos('EmotionFin', [t], 99)
    endfor
    for t in hlpos_wip
        cal matchaddpos('EmotionWip', [t], 100)
    endfor
endf

fu! s:emotion.char_enter(winid, key) abort
    " noop (for polyglot bug adhoc)
    if strtrans(a:key) == "<80><fd>`"
        retu 1
    endif
    " only accept defined emotion key
    if self.keys->index(a:key) == -1
        " go out e-motion
        cal popup_close(self.popid)
        let p = getpos('.')
        " close preview
        b #
        cal cursor(p[1],p[2])
        cal self.hl_del(['EmotionFin', 'EmotionWip', 'EmotionBase'])
        " restore diagnostic
        if exists('*CocAction')
            cal CocAction('diagnosticToggle')
        endif
        cal s:echoE('e-motion: go out')
        retu 1
    endif
    " upd emotion.keypos
    let tmp = self.keypos->deepcopy()->map({ _,r -> #{row: r.row,
        \ col: r.col->filter({_,v->v.key[0]==a:key})->map({_,v->#{key: v.key[1:], pos: v.pos}})} })
        \ ->filter({_,v->!empty(v.col)})
    " nomatch -> noop
    if empty(tmp)
        retu 1
    else
        let self.keypos = tmp
    endif
    " if last match -> end e-motion
    if len(self.keypos) == 1 && len(self.keypos[0].col) == 1
        cal popup_close(self.popid)
        " close previeew
        b #
        norm! zR
        cal cursor(self.keypos[0].row, self.keypos[0].col[0].pos)
        cal self.hl_del(['EmotionFin', 'EmotionWip', 'EmotionBase'])
        " restore diagnostic
        if exists('*CocAction')
            cal CocAction('diagnosticToggle')
        endif
        cal s:echoI('e-motion: finish')
        retu 1
    endif
    " redraw
    cal self.draw(self.keypos)
    retu 1
endf

" about highlight setting
fu! s:emotion.hl_del(group_name_list) abort
    cal getmatches()->filter({ _,v -> match(a:group_name_list, v.group) != -1 })->map({ _,v -> matchdelete(v.id) })
endf

aug emotion_hl
    au!
    au ColorScheme * hi EmotionBase ctermfg=59
    au ColorScheme * hi EmotionWip ctermfg=166 cterm=bold
    au ColorScheme * hi EmotionFin ctermfg=196 cterm=bold
aug END

fu! s:emotion() abort
    cal s:emotion.exe()
endf
noremap <silent><Plug>(emotion) :<C-u>cal <SID>emotion()<CR>
" }}}

" ===================================================================
" unblevable/quick-scope
" ===================================================================
" {{{
let s:fmode = #{flg: 1, posf: [], posF: []}

fu! s:fmode.set() abort
    cal getmatches()->filter({ _,v -> v.group =~ 'FScope.*' })->map('execute("cal matchdelete(v:val.id)")')
    let rn = line('.')
    let cn = col('.')
    let rtxt = getline('.')
    let tar = []
    let tar2 = []
    let bak = []
    let bak2 = []
    let self.posf  = []
    let self.posF  = []
    let offset = 0
    while offset != -1
        let start = matchstrpos(rtxt, '\<.', offset)
        let offset = matchstrpos(rtxt, '.\>', offset)[2]
        let ashiato = start[1] >= cn ? rtxt[cn:start[1]-1] : rtxt[start[2]+1:cn]
        if stridx(ashiato, start[0]) == -1 && start[0] =~ '[ -~]'
            cal add(start[1] >= cn ? tar : bak, [rn, start[2]]) " uniq char
        elseif start[2] > 0 && start[0] =~ '[ -~]'
            let next_char = rtxt[start[2]:start[2]]
            if start[1] >= cn
                cal add(stridx(ashiato, next_char) == -1 ? tar : tar2, [rn, start[2]+1]) " uniq char
            else
                cal add(stridx(ashiato, next_char) == -1 ? bak    : bak2 , [rn, start[2]+1])
            endif
        endif
    endwhile
    if !empty(tar)
        let self.posf  = self.posf + tar
        cal matchaddpos('FScopePrimary', tar, 16)
        endif
    if !empty(tar2)
        let self.posf  = self.posf + tar2
        cal matchaddpos('FScopeSecondary', tar2, 16)
    endif
    if !empty(bak)
        let self.posF  = self.posF + bak
        cal matchaddpos('FScopeBackPrimary', bak, 16)
    endif
    if !empty(bak2) 
        let self.posF  = self.posF + bak2
        cal matchaddpos('FScopeBackSecondary', bak2, 16) 
    endif
endf

fu! s:fmode.move(vec) abort
    let pos = getpos('.')
    let col = pos[2]
    if a:vec is# 'f'
        let col = map(self.posf, {_,v -> v[1]})->filter({_,v -> v > col})->min()
    elseif a:vec is# 'F'
        let col = map(self.posF, {_,v -> v[1]})->filter({_,v -> v < col})->max()
    endif
    cal cursor(pos[1], col)
endf

fu! s:fmode_move(vec) abort
    cal s:fmode.move(a:vec)
endf

fu! s:fmode.activate() abort
    aug f_scope
        au!
        au CursorMoved * cal s:fmode.set()
    aug End
    cal s:fmode.set()
    "nmap <silent>f :cal <SID>fmode_move('f')<CR>
    "nmap <silent>F :cal <SID>fmode_move('F')<CR>
endf

fu! s:fmode.deactivate() abort
    aug f_scope
        au!
    aug End
    let current_win = win_getid()
    windo cal getmatches()->filter({ _,v -> v.group =~ 'FScope.*' })->map('execute("cal matchdelete(v:val.id)")')
    cal win_gotoid(current_win)
    "unmap f
    "unmap F
endf

fu! s:fmode.toggle() abort
    if s:fmode.flg
        let s:fmode.flg = 0
        cal s:fmode.deactivate()
    else
        let s:fmode.flg = 1
        cal s:fmode.activate()
    endif
endf

fu! s:fmode.takeover() abort
    if s:fmode.flg
        cal s:fmode.activate()
    else
        cal s:fmode.deactivate()
    endif
endf

aug fmode_colors
    au!
    au ColorScheme * hi FScopePrimary ctermfg=196 cterm=underline guifg=#66D9EF guibg=#000000
    au ColorScheme * hi FScopeSecondary ctermfg=219 cterm=underline guifg=#66D9EF guibg=#000000
    au ColorScheme * hi FScopeBackPrimary ctermfg=51 cterm=underline guifg=#66D9EF guibg=#000000
    au ColorScheme * hi FScopeBackSecondary ctermfg=33 cterm=underline guifg=#66D9EF guibg=#000000
aug END

fu! s:fmodetoggle() abort
    cal s:fmode.toggle()
endf
noremap <silent><Plug>(f-scope) :<C-u>cal <SID>fmodetoggle()<CR>
" }}}

" ===================================================================
" t9md/vim-quickhl
" ===================================================================
" {{{
let s:quickhl = #{hlidx: 0, reseted: 0}
let s:quickhl.hl= [
    \ "cterm=bold ctermfg=16 ctermbg=153 gui=bold guifg=#ffffff guibg=#0a7383",
    \ "cterm=bold ctermfg=7 ctermbg=1 gui=bold guibg=#a07040 guifg=#ffffff",
    \ "cterm=bold ctermfg=7 ctermbg=2 gui=bold guibg=#4070a0 guifg=#ffffff",
    \ "cterm=bold ctermfg=7 ctermbg=3 gui=bold guibg=#40a070 guifg=#ffffff",
    \ "cterm=bold ctermfg=7 ctermbg=4 gui=bold guibg=#70a040 guifg=#ffffff",
    \ "cterm=bold ctermfg=7 ctermbg=5 gui=bold guibg=#0070e0 guifg=#ffffff",
    \ "cterm=bold ctermfg=7 ctermbg=6 gui=bold guibg=#007020 guifg=#ffffff",
    \ "cterm=bold ctermfg=7 ctermbg=21 gui=bold guibg=#d4a00d guifg=#ffffff",
    \ "cterm=bold ctermfg=7 ctermbg=22 gui=bold guibg=#06287e guifg=#ffffff",
    \ "cterm=bold ctermfg=7 ctermbg=45 gui=bold guibg=#5b3674 guifg=#ffffff",
    \ "cterm=bold ctermfg=7 ctermbg=16 gui=bold guibg=#4c8f2f guifg=#ffffff",
    \ "cterm=bold ctermfg=7 ctermbg=50 gui=bold guibg=#1060a0 guifg=#ffffff",
    \ "cterm=bold ctermfg=7 ctermbg=56 gui=bold guibg=#a0b0c0 guifg=black",
    \ ]

fu! s:quickhl.hlini() abort
    for v in s:quickhl.hl
        exe 'hi UserSearchHi'.index(s:quickhl.hl, v).' '.v
    endfor
endf

fu! s:quickhl.reset(cw) abort
    let s:quickhl.reseted = 0
    let already = getmatches()->filter({ _,v -> has_key(v, 'pattern') ? v.pattern == a:cw : 0 })
    if !empty(already)
        cal matchdelete(already[0].id)
        let s:quickhl.reseted = 1
    endif
endf

fu! s:quickhl.set() abort
    let current_win = winnr()
    let cw = expand('<cword>')
    windo cal s:quickhl.reset(cw)
    if s:quickhl.reseted
        exe current_win.'wincmd w'
        retu
    endif
    windo cal matchadd('UserSearchHi'.s:quickhl.hlidx, cw)
    let s:quickhl.hlidx = s:quickhl.hlidx >= len(s:quickhl.hl)-1 ? 0 : s:quickhl.hlidx + 1
    exe current_win.'wincmd w'
endf

fu! s:quickhl.clear() abort
    let current_win = winnr()
    windo cal getmatches()->filter({ _,v -> v.group =~ 'UserSearchHi.*' })->map('execute("cal matchdelete(v:val.id)")')
    exe current_win.'wincmd w'
endf

aug quickhl
    au!
    au ColorScheme * cal s:quickhl.hlini()
aug END

fu! s:quickhlset() abort
    cal s:quickhl.set()
endf
fu! s:quickhlclear() abort
    cal s:quickhl.clear()
endf
noremap <silent><Plug>(qikhl-toggle) :<C-u>cal <SID>quickhlset()<CR>
noremap <silent><Plug>(qikhl-clear) :<C-u>cal <SID>quickhlclear()<CR>
" }}}


" ===================================================================
" junegunn/goyo.vim
" ===================================================================
" {{{
let s:zen_mode = #{flg: 0, vert_split: []}
fu! s:zen_mode.toggle() abort
    if self.flg
        let self.flg = 0
        set number cursorline cursorcolumn laststatus=2 showtabline=2
        tabc
        exe 'hi VertSplit '.join(self.vert_split[2:], ' ')
        retu
    endif
    let self.flg = 1
    tab split
    norm zR
    set nonumber norelativenumber nocursorline nocursorcolumn laststatus=0 showtabline=0
    vert to new
    cal self.silent()
    vert bo new
    cal self.silent()
    "['NonText', 'FoldColumn', 'ColorColumn', 'VertSplit', 'StatusLine', 'StatusLineNC', 'SignColumn']
    let self.vert_split = execute('hi VertSplit')->split(' ')->filter({ _,v -> !empty(v) })
    exe 'hi VertSplit ctermfg=black ctermbg=NONE cterm=NONE'
    setl number relativenumber
endf

fu! s:zen_mode.silent() abort
    setl buftype=nofile bufhidden=wipe nomodifiable nobuflisted nonu noru winfixheight
    vert res 40
    exe winnr('#').'wincmd w'
endf

fu! s:zenModeToggle() abort
    cal s:zen_mode.toggle()
endf
noremap <silent><Plug>(zen-mode) :<C-u>cal <SID>zenModeToggle()<CR>
" }}}

" ===================================================================
" mhinz/vim-startify
" ===================================================================
" {{{
let s:start = #{}

" AtCoder{{{
let s:start.ac_logo = [
    \'                                                                           .',
    \'                                                                         .dN.',
    \'                                                                      ..d@M#J#(,',
    \'                                                                   vRMPMJNd#dbMG#(F',
    \'                                                         (O.  U6..  WJNdPMJFMdFdb#`  .JU` .Zo',
    \'                                                      .. +NM=(TB5.-^.BMDNdJbEddMd ,n.?T@3?MNm  ..',
    \'                                                     .mg@_J~/?`.a-XNxvMMW9""TWMMF.NHa._ ?_,S.Tmg|',
    \'                                                  .Js ,3,`..-XNHMT"= ...d"5Y"X+.. ?"8MNHHa.. (,b uZ..',
    \'                                                 J"17"((dNMMB"^ ..JTYGJ7"^  ?"T&JT9QJ..?"TMNNHa,?727N',
    \'                                                 .7    T"^..JT"GJv"=`             ?"4JJT9a.,?T"`  .7!',
    \'                                                         M~JY"!     ....<.Zj+,(...     .7Ta_M',
    \'                                             .JWkkWa,    d-F     .+;.ge.ga&.aa,ua+.g,     ,}#    .(Wkkkn,',
    \'                                            .W9AaeVY=-.. J;b   .XH3dHHtdHHDJHHH(HHH(WH,   J(F  ..?T4agdTH-',
    \'                                             6XkkkH=!    ,]d  .HHtdHHH.HHHbJHHH[WHHH(HHL  k.]    _7HkkkHJ:',
    \'                                             JqkP?H_      N(; TYY?YYY9(YYYD?YYYt7YYY\YY9 .Fd!     .WPjqqh',
    \'                                             .mmmH,``      d/b WHHJHH@NJHHH@dHHHFdHHHtHH#`.1#       `(dqqq]',
    \'                                            ,gmmgghJQQVb  ,bq.,YY%7YYY(YYY$?YYY^TYYY(YY^ K.]  JUQmAJmmmmg%',
    \'                                             ggggggggh,R   H,]  T#mTNNbWNN#dNN#(NN@(N@! .t#   d(Jgggggggg:',
    \'                                            .@@@@@#"_JK4,  ,bX.   ?i,1g,jge.g2+g2i,?`   K.t  .ZW&,7W@@@@@h.',
    \'                                        `..H@@@@@P   7 .H`  W/b        .^."?^(!        -1#   W, ?   T@@@@@Ma,`',
    \'                                        dH@HHHM"       U\   .N,L        ..            .$d    .B`     ."MHHH@HN.',
    \'                                   ....JMHHHHH@              ,N(p      .dH.d"77h.    .$J\              dHHHHHMU....',
    \'                                  ` WHH#,7MHHM{               ,N,h     d^.W,        .^J^               .MHHM"_d#HN.',
    \'                                   ,jH#Mo .MMW:                .W,4,  J\   Ta.-Y` .J(#                 .HMM- .M#MF!',
    \'                                     .MN/ d@?M+                  7e(h.           .3.F                  .MDd# (MML`',
    \'                                     .M4%  ?H, 7a,                .S,7a.       .Y.#^                .,"`.d=  ,PWe',
    \'                                    .! ?     dN .N,                 (N,7a.   .Y(d=                 .d! d@     4 .!',
    \'                                             .W` .!                   ?H,?GJ".d"                    ^  B',
    \'                                                                        (SJ.#=',
    \'                                                       J             ....            .M:',
    \'                                                      JUb     .   .#    (\            M~',
    \'                                                     .\.M;  .W@"` M}       .y7"m. .J"7M~ .v74e ,M7B',
    \'                                                    .F  ,N.  J]   M]       M)  JF M_  M~ d-     M`',
    \'                                                   .W,  .db, Jh.   Th...J\ /N..Y` ?N-.Ma.-M&.> .M-',
    \]
"}}}

" cheat sheet {{{
let s:start.cheat_sheet_win = [
    \'               ╭── Window ──────────────────────────────────────────╮           ╭── Motion ──────────────────────────────────────────╮',
    \'               │ C-n / p    | (buffer tab)(next / prev)             │           │ Space f          | (formatter)                     │',
    \'               │ C-w v / s  | (window split)(vertical / horizontal) │           │ Space w          | (f-scope toggle)                │',
    \'               │ ←↑↓→       | (window)(resize)                      │           │ Tab S-Tab        | (jump 5rows)                    │',
    \'               │ C-hjkl     | (window)(forcus)                      │           │ s                | (easymotion)                    │',
    \'               │ Space t    | (terminal)                            │           │ INSERT C-hjkl    | (cursor move)                   │',
    \'               │ Space z    | (Zen Mode)                            │           │ VISUAL C-jk      | (blok up / down)                │',
    \'               ╰────────────────────────────────────────────────────╯           ╰────────────────────────────────────────────────────╯',
    \'               ╭── Search ──────────────────────────────────────────╮           ╭── Command ─────────────────────────────────────────╮',
    \'               │ Space e    | (explorer)                            │           │ :PlugInstall     | (plugins install)               │',
    \'               │ Space q    | (clear search highlight)              │           │ :PlugUnInstall   | (plugins uninstall)             │',
    \'               ╰────────────────────────────────────────────────────╯           ╰────────────────────────────────────────────────────╯',
    \]
" }}}

fu! s:start.exe() abort
    let fopen = execute('ls')->split('\n')->map({_,v -> split(v, '"')[1]})
            \ ->filter({_,v -> v != '[No Name]' && v != '[無名]'})->len()
    if fopen
        cal self.move()
        retu
    endif
    " preview window
    sil! exe 'e _cheat_cheet_'
    setl buftype=nofile bufhidden=wipe nobuflisted modifiable
    setl nonumber norelativenumber nocursorline nocursorcolumn signcolumn=no
    let &filetype = 'AtCoder'
    nmap <buffer>i \<Esc>
    nmap <buffer>I \<Esc>
    nmap <buffer>a \<Esc>
    nmap <buffer>A \<Esc>
    nmap <buffer>s \<Esc>

    " draw
    cal append('$', self.ac_logo)
    cal append('$', self.cheat_sheet_win)
    hi ACLogo ctermfg=45
    cal matchaddpos('ACLogo', range(2,9)->map({_,v->[v]}), 999)
    cal matchaddpos('ACLogo', range(10,17)->map({_,v->[v]}), 999)
    cal matchaddpos('ACLogo', range(18,25)->map({_,v->[v]}), 999)
    cal matchaddpos('ACLogo', range(26,33)->map({_,v->[v]}), 999)
    cal matchaddpos('ACLogo', range(34,35)->map({_,v->[v]}), 999)
    cal matchadd('User_greenfg_blackbg', '[─│╰╯╭╮]', 20)
    cal matchadd('DarkOrange', '\(Window\|Search\|Motion\|Command\)')
    cal matchadd('DarkBlue', '│.\{-,25}|', 19)
    cal matchadd('DarkRed', '(.*)', 18)

    " fix
    setl nomodifiable nomodified
endf

fu! s:start.move() abort
    cal clearmatches()
    cal s:fmode.activate()

    " deactivate
    aug start_vim
        au!
    aug END
endf

" only first call
aug start_vim
    au!
    au VimEnter * cal s:start.exe()
    au BufReadPre * cal s:start.move()
aug END
" }}}



" }}}

" ##################      PLUG MANAGE       ################### {{{
" repo
" neoclide/coc.nvim has special args
let s:plug = #{}
let s:plug.repos = [
    \ 'sheerun/vim-polyglot'
    \ ]

" coc extentions
let s:plug.coc_extentions = [
    \ 'coc-explorer', 'coc-pairs', 'coc-fzf-preview', 'coc-snippets',
    \ 'coc-sh', 'coc-vimlsp', 'coc-json', 'coc-sql', 'coc-html', 'coc-css',
    \ 'coc-tsserver', 'coc-clangd', 'coc-go', 'coc-pyright', 'coc-java',
    \ ]

let s:plug.coc_config = ['{',
    \ '    "snippets.ultisnips.pythonPrompt": false,',
    \ '    "explorer.icon.enableNerdfont": true,',
    \ '    "explorer.file.showHiddenFiles": true,',
    \ '    "python.formatting.provider": "yapf",',
    \ '    "pyright.inlayHints.variableTypes": false',
    \ '}',
    \]

fu! s:plug.install() abort
    let cmd = "mkdir -p ~/.vim/pack/plugins/start && cd ~/.vim/pack/plugins/start && repos=('".join(self.repos,"' '")."') && for v in ${repos[@]};do git clone --depth 1 https://github.com/${v};done"
      \ ." && git clone -b release https://github.com/neoclide/coc.nvim"
    cal s:runcat.start()
    cal job_start(["/bin/zsh","-c",cmd], #{close_cb: self.coc_setup})
    cal s:echoI('colors, plugins installing...')
    cal popup_notification('colors, plugins installing...', #{zindex: 999, line: &lines, col: 5})
endf

" coc extentions
fu! s:plug.coc_setup(ch) abort
    cal s:runcat.stop()
    cal s:echoE('plugins installed. coc-extentions installing. PLEASE REBOOT VIM after this.')
    cal popup_notification('colors, plugins installed. coc-extentions installing. PLEASE REBOOT VIM after this.', #{zindex: 999, line: &lines, col: 5})
    exe 'source ~/.vim/pack/plugins/start/coc.nvim/plugin/coc.vim'
    exe 'CocInstall '.join(self.coc_extentions, ' ')
    cal writefile(self.coc_config, $HOME.'/.vim/coc-settings.json')
    "cal coc#util#install() if git clone --depth 1, need this statement
endf

" uninstall
fu! s:plug.uninstall() abort
    cal s:echoE('delete ~/.vim')
    let w = confirm('Are you sure to delete these folders ?', "&Yes\n&No\n&Cancel")
    if w != 1
        cal s:echoI('cancel')
        retu
    endif
    exe "bo terminal ++shell echo 'start' && rm -rf ~/.vim && echo 'end. PLEASE REBOOT VIM'"
endf

com! PlugInstall cal s:plug.install()
com! PlugUnInstall cal s:plug.uninstall()
" }}}


" }}}

" #############################################################
" ##################    PLUGINS SETTING     ###################
" #############################################################
" {{{
" ##################    PLUGIN VARIABLES    ################### {{{

" coc
let g:coc_snippet_next = '<Tab>'
let g:coc_snippet_prev = '<S-Tab>'

" fzf run time path(git, homebrew)
set rtp+=~/.vim/pack/plugins/start/fzf
set rtp+=/opt/homebrew/opt/fzf

" chat gpt
let g:chat_gpt_max_tokens=4000

" }}}

" ##################      PLUGIN KEYMAP     ################### {{{
" coc
if !glob('~/.vim/pack/plugins/start/coc.nvim')->empty()
    " explorer
    nnoremap <silent><Leader>e :CocCommand explorer --width 30<CR>

    " cursor highlight
    autocmd CursorHold * silent cal CocActionAsync('highlight')

    " completion @ coc
    inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
    inoremap <silent><expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
    inoremap <silent><expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

    " IDE
    nmap <Leader>d <Plug>(coc-definition)
    nnoremap <Leader>r :CocCommand fzf-preview.CocReferences<CR>
    nnoremap <Leader>o :CocCommand fzf-preview.CocOutline<CR>
    nnoremap <Leader>? :cal CocAction('doHover')<CR>
    nmap <Leader>, <plug>(coc-diagnostic-next)
    nmap <Leader>. <plug>(coc-diagnostic-prev)
    nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : Scroll(1, 10)
    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : Scroll(0, 10)
endif
" }}}
" }}}

" #############################################################
" ##################        STARTING        ###################
" #############################################################
" {{{

aug base_color
    au!
    au ColorScheme * hi Normal ctermbg=235
aug END
colorscheme torte
colorscheme onedark


" 設定中のコンテスト番号を表示（テスト対象で使用する）
try
    let abc = 'contest_setting : '.readfile('contest_setting.txt')[0]
    cal popup_notification(abc, #{border:[], zindex:999, line: &lines-30, col: &columns-40, time:10000})
catch
endtry

" 100分タイマー
let s:timer_sec = 0
let s:view_time = ['000:00']
let s:timer_popup_id = popup_create(s:view_time, #{
        \ zindex: 99, mapping: 0, scrollbar: 1,
        \ border: [], borderchars: ['─','│','─','│','╭','╮','╯','╰'], borderhighlight: ['DarkBlue'],
        \ line: &lines-10, col: 10,
        \ })
fu! Timer(tid) abort
    let s:timer_sec += 1
    let minutes = s:timer_sec/60
    if minutes < 10
        let minutes = '00'.minutes
    elseif minutes < 100
        let minutes = '0'.minutes
    endif
    let seconds = s:timer_sec%60
    if seconds < 10
        let seconds = '0'.seconds
    endif
    let s:view_time = [minutes.':'.seconds]
    cal setbufline(winbufnr(s:timer_popup_id), 1, s:view_time)
    if s:timer_sec > 5400
        cal matchadd('DarkRed', '[^ ]', 16, -1, #{window: s:timer_popup_id})
    endif
endf
cal timer_start(1000, function("Timer"), { "repeat" : -1 })

" }}}

" alse see [https://github.com/serna37/vim/]

