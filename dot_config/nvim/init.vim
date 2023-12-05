set ignorecase
" set smartcase
set showmode
" v to visual block (no use visual)
nnoremap v <c-v>

" reload vim config
let mapleader = "\<space>"
" space+r: source vimrk
nnoremap <leader>r :source $MYVIMRC<cr>

" clear last searched register
nnoremap <leader>c :let @/ = ""<cr>

set tabstop=4
set shiftwidth=4
set expandtab

set statusline+=%F
set laststatus=2
set number
"set belloff=all
set visualbell

" https://zenn.dev/link/comments/67d1f41c9a335d

" set clipboard+=unnamed
" set clipboard+=unnamedplus
" set clipboard&
" set clipboard^=unnamedplus

if has('clipboard') || exists('g:vscode')
    set clipboard^=unnamed
    if has('nvim') && (system('uname -a |grep -i microsoft') != '')
        let g:clipboard = {
          \   'name': 'WslClipboard',
          \   'copy': {
          \      '+': ['uclip', '-i'],
          \      '*': ['uclip', '-i'],
          \    },
          \   'paste': {
          \      '+': ['powershell.exe', '-c', '[Console]::Out.Write($(Get-Clipboard -Raw).ToString().Replace("`r", ""))'],
          \      '*': ['powershell.exe', '-c', '[Console]::Out.Write($(Get-Clipboard -Raw).ToString().Replace("`r", ""))'],
          \   },
          \   'cache_enabled': 0,
          \ }
    endif
endif
let g:nvim_config_root = stdpath('config')
let s:config_files = [
    \ 'zenhan.vim',
    \ 'dein.vim'
    \ ]
for conf in s:config_files
    execute 'source ' . g:nvim_config_root . '/' . conf
endfor
