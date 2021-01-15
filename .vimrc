set encoding=utf-8 fileencodings=utf-8
set guifont=Sarasa\ Term\ SC:h12 
set nu

inoremap jj <Esc>
inoremap <c-d> <Esc>ddi
inoremap ( ()<LEFT>
inoremap [ []<LEFT>
inoremap { {}<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>
inoremap < <><LEFT>
noremap <C-x> <Esc>xi

noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

nnoremap <space>v :NERDTreeFind<cr>

nmap ss <Plug>(easymotion-s2)

imap <Tab> <Plug>EasyCompTabTrigger
imap <S-Tab> <Plug>EasyCompShiftTabTrigge

call plug#begin('~/.vim/plugged')
Plug 'mhinz/vim-startify'
Plug 'preservim/nerdtree'
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'vim-airline/vim-airline'
Plug 'Yggdroot/indentLine'
Plug 'w0ng/vim-hybrid'
Plug 'toddfoster/ctrlp-notes'
Plug 'altercation/solarized'
Plug 'easymotion/vim-easymotion'
Plug 'morhetz/gruvbox'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'VundleVim/Vundle.vim'
Plug 'maralla/completor.vim'
Plug 'plasticboy/vim-markdown'

call plug#end()

let g:ctrlp_map = '<c-p>'
let g:pymode_rope_goto_definition_find = '<C-]>'
let g:pmenu_scheme = 'dark'
let g:go_disable_autoinstall = 0
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_version_warning = 0
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
" Go 函数名高亮，虽然没学过这个语言我也不知道这是什么玩意
let g:go_highlight_function_calls = 1

let g:ycm_key_list_stop_completion=['<C-y>','<CR>','<Tab>']
let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/third_party/ycmd/examples/.ycm_extra_conf.py'
let g:ycm_log_level='debug'
let g:ycm_disable_for_files_larger_than_kb=100000
if has("autocmd") && exists("+omnifunc") 
autocmd Filetype * 
\ if &omnifunc == "" | 
\ setlocal omnifunc=syntaxcomplete#Complete | 
\ endif 
endif


" Use TAB to complete when typing words, else inserts TABs as usual.  Uses
" dictionary, source files, and completor to find matching words to complete.

" Note: usual completion is on <C-n> but more trouble to press all the time.
" Never type the same word twice and maybe learn a new spellings!
" Use the Linux dictionary when spelling is in doubt.
function! Tab_Or_Complete() abort
  " If completor is already open the `tab` cycles through suggested completions.
  if pumvisible()
    return "\<C-N>"
  " If completor is not open and we are in the middle of typing a word then
  " `tab` opens completor menu.
  elseif col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^[[:keyword:][:ident:]]'
    return "\<C-R>=completor#do('complete')\<CR>"
  else
    " If we aren't typing a word and we press `tab` simply do the normal `tab`
    " action.
    return "\<Tab>"
  endif
endfunction

" Use `tab` key to select completions.  Default is arrow keys.
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use tab to trigger auto completion.  Default suggests completions as you type.
let g:completor_auto_trigger = 0
inoremap <expr> <Tab> Tab_Or_Complete()
