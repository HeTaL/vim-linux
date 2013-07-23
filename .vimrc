set nocompatible

"stop creating those annoying ~ files.
set nobackup
colorscheme paintbox2
set nowrap
set softtabstop=4
set shiftwidth=4
set tabstop=8
set ic
set expandtab
set shiftround
set autoindent
syntax on
"colorscheme fruity
highlight Folded guifg=darkgrey guibg=Black

" Get rid of shitty gvim toolbars
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar

nnoremap <silent> <leader>fd :call FunProto()<CR>

"Add Pathogen
call pathogen#runtime_append_all_bundles()

"Vim only defaults to 3 matches so this is the syntax for the first 2
"highlight any extra white space green
"match ExtraWhitespace /\s\+$\| \+\ze\t/   This will highlight only white
"space at the end of a tab
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$\|\t/
map <F4> :match ExtraWhitespace /\s\+$\\|\t/<cr>a
map! <F4> <Esc>:match ExtraWhitespace '\%>9000v.\+'<cr>:noh<cr>

"set diffexpr=MyDiff()
"function MyDiff()
"  let opt = '-a --binary '
"  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
"  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
"  let arg1 = v:fname_in
"  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
"  let arg2 = v:fname_new
"  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
"  let arg3 = v:fname_out
"  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
"  if &sh =~ '\<cmd'
"    silent execute '!""C:\Program Files\Vim\vim63\diff" ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . '"'
"  else
"    silent execute '!C:\Program" Files\Vim\vim63\diff" ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
"  endif
"endfunction

"F2 now toggles the show line numbers
map <F2> :set invnumber<cr>a
map! <F2> <Esc>:set invnumber<cr>

"Highlight any characters above 120 places red
2match ErrorMsg '\%>120v.\+'
map <F3> :2match ErrorMsg '\%>9000v.\+'<cr>a
map! <F3> <Esc>:2match ErrorMsg '\%>120v.\+'<cr>

"This will delete extra spaces at the end of a line and will
"change tabs to spaces
map <F6> :retab<cr>:%s/\s\+$//<cr>
map! <F6> <Esc>:retab<cr>:%s/\s\+$//<cr>a

"Easy buffer resizing
""Disable silly alt+letter bindings to toolbar menu
set wak=no
""Now map the keys correctly
map <silent> <A-h> <C-w><
map <silent> <A-j> <C-W>-
map <silent> <A-k> <C-W>+
map <silent> <A-l> <C-w>>

"Always show line numbers, but only in current window/buffer.
set number

function! ExitWin()
    setlocal nonumber
    setlocal norelativenumber
    set nocursorcolumn
endfunction

au WinEnter * :setlocal relativenumber
au WinLeave * call ExitWin()

"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=4      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use

"Change map leader to something less Carpal-Tunnels inducing
let mapleader=","

" Quick macro that increments the number in a copied line allowing quick
" debugging
nnoremap <leader>p p0<C-A>==yy
nnoremap <leader>P P0<C-A>==yy



" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
"command DiffOrig2 vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis


"The first time you press home go to the begining of the text
"The second time go to the begining of the line
function! SmartHome()
  let s:col = col(".")
  normal! ^
  if s:col == col(".")
    normal! 0
  endif
endfunction
nnoremap <silent> <Home> :call SmartHome()<CR>
inoremap <silent> <Home> <C-O>:call SmartHome()<CR>


"Allows automatic comment addition upon newline:
set formatoptions+=r
set formatoptions+=o
set formatoptions+=c


"<Leader>1 (,1) now yanks current line, then pastes it beneath it, then moves
"to the pasted line, then selects it, and replaces the whole thing with #'s.
"This is nice for creating lines in the text based on the size of your current
"lines.
nnoremap <leader>1 yypVr#

"Debugging macro for TCL
nnoremap <leader>d aputs "\n\n\n\n\n\n\n\n\n\n\n  \n\n\n\n\n\n\n\n\n\n\n"<Esc>Bhi


"Set line highlighting
set cul

" Jump to beginning and end of code bloc using gb and gB
nnoremap gb [{
nnoremap gB ]}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" " Tab now autocompletes in insert mode, but still puts tab at the beginning of
" " a line
" function! Smart_TabComplete()
"   let line = getline('.')                         " current line
" 
"   let substr = strpart(line, -1, col('.')+1)      " from the start of the current
"                                                   " line to one character right
"                                                   " of the cursor
"   let substr = matchstr(substr, "[^ \t]*$")       " word till cursor
"   if (strlen(substr)==0)                          " nothing to match on empty string
"     return "\<tab>"
"   endif
"   let has_period = match(substr, '\.') != -1      " position of period, if any
"   let has_slash = match(substr, '\/') != -1       " position of slash, if any
"   if (!has_period && !has_slash)
"     return "\<C-X>\<C-P>"                         " existing text matching
"   elseif ( has_slash )
"     return "\<C-X>\<C-F>"                         " file matching
"   else
"     return "\<C-X>\<C-O>"                         " plugin matching
"   endif
" endfunction
" 
" " Now we map Tab to Smart_TabComplete()
" inoremap <tab> <c-r>=Smart_TabComplete()<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" This is taken from http://vim.wikia.com/wiki/Precise_Jumps_Without_Mouse
" We can now press Tab while in normal mode to jump quickly around in the
" file. After the total amount of letters are exhausted, 2 tags will be given
" to each word.
"let LABEL = ["a","b","c",
"\"d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s",
"\"t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","I",
"\"J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y",
"\"Z","1","2","3","4","5","6","7","8","9","0"]
"function! GoTo(range)
"    normal! Hmt
"    for i in range(0,a:range)
"        exe 'normal! Wr' . g:LABEL[i%len(g:LABEL)]
"    endfor
"    normal! 'tzt
"    echo "Index?"
"    redraw
"    let label=nr2char(getchar())
"    normal! u'tzt
"    for i in range(0,a:range)
"        exe 'normal! Wr' . (1+i/len(g:LABEL))
"    endfor
"    normal! 'tzt
"    echo "Number?"
"    redraw
"    let offset=getchar()
"    let offset=(49 <= offset && offset <= 57) ? offset-48 : 1
"    normal! u'tzt
"    let index=index(g:LABEL,label)
"    exe 'normal! ' . ((offset-1)*len(g:LABEL)+index+1) . 'W'
"endfu
"nnoremap <TAB> :call GoTo(500)<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" By pressing <Leader>vs we can now split open another buffer letting us view
" twice the amount of vertical space. The linked buffers also have auto
" scrolling. Taken from:
" http://vim.wikia.com/wiki/View_text_file_in_two_columns
noremap <silent> <Leader>vs :<C-u>let @z=&so<CR>:set so=0 noscb<CR>:bo vs<CR>Ljzt:setl scb<CR><C-w>p:setl scb<CR>:let &so=@z<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Open buffer in new tab
nmap t% :tabedit %<CR>
" Close tabbed buffer
nmap td :tabclose<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" SeeTab: toggles between showing tabs and using standard listchars
" Don't use with TCL. Taken from http://vim.wikia.com/wiki/See_the_tabs_in_your_file
fu! SeeTab()
  if !exists("g:SeeTabEnabled")
    let g:SeeTabEnabled = 1
    let g:SeeTab_list = &list
    let g:SeeTab_listchars = &listchars
    let regA = @a
    redir @a
    hi SpecialKey
    redir END
    let g:SeeTabSpecialKey = @a
    let @a = regA
    silent! hi SpecialKey guifg=black guibg=magenta ctermfg=black ctermbg=magenta
    set list
    set listchars=tab:\|\
  else
    let &list = g:SeeTab_list
    let &listchars = &listchars
    silent! exe "hi ".substitute(g:SeeTabSpecialKey,'xxx','','e')
    unlet g:SeeTabEnabled g:SeeTab_list g:SeeTab_listchars
  endif
endfunc
com! -nargs=0 SeeTab :call SeeTab()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Rainbow Parenthesis
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

"tagbar toggle
nnoremap <leader>l :TagbarToggle<CR>

"toggle undo tree
nnoremap <leader>u :UndotreeToggle<CR>

if has("persistent_undo")
    set undodir='~/.vim/undo/'
    set undofile
endif
