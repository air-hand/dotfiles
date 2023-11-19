set ignorecase
" set smartcase
set showmode
" v to visual block (no use visual)
nnoremap v <c-v>

" reload vim config
let mapleader = "\<space>"
" space+r: source vimrk
nnoremap <leader>r :source $MYVIMRC<cr>

set tabstop=4
set shiftwidth=4
set expandtab

set statusline+=%F
set laststatus=2
set number

" https://gitpress.io/@mimori37/VSCode%E3%81%A7%E3%82%82normal%E7%A7%BB%E8%A1%8C%E6%99%82%E3%81%ABIME%E5%88%87%E3%82%8A%E6%9B%BF%E3%81%88%E3%81%9F%E3%81%84
" https://wonwon-eater.com/wsl2-neovim/#outline__4_2
" ime off
if executable('spzenhan.exe')
autocmd InsertLeave * :call system('spzenhan.exe 0')
autocmd CmdlineLeave * :call system('spzenhan.exe 0')
autocmd InsertEnter * :call system('spzenhan.exe 0')
endif

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

" win32yank.exe version
"        let g:clipboard = {
"          \   'name': 'WslClipboard',
"          \   'copy': {
"          \      '+': ['win32yank.exe', '-i'],
"          \      '*': ['win32yank.exe', '-i'],
"          \    },
"          \   'paste': {
"          \      '+': ['win32yank.exe', '-o'],
"          \      '*': ['win32yank.exe', '-o'],
"          \   },
"          \   'cache_enabled': 0,
"          \ }
