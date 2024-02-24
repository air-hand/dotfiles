" https://zenn.dev/link/comments/67d1f41c9a335d

set clipboard+=unnamedplus

" Note: Do not load autoload/provider/clipboard.vim before setting g:clipboard.
" As an example, just executing `has('clipboard')` will autoload clipboard.vim.

if (system('uname -a |grep -i microsoft') != '')
    let g:clipboard = {
        \   'name': 'WslClipboard',
        \   'copy': {
        \      '+': ['win32yank.exe', '-i'],
        \      '*': ['win32yank.exe', '-i'],
        \    },
        \   'paste': {
        \      '+': ['win32yank.exe', '-o'],
        \      '*': ['win32yank.exe', '-o'],
        \   },
        \   'cache_enabled': 0,
        \ }
endif

if has('clipboard') != 1
    echoerr 'Clipboard not loaded.'
endif
