" https://gitpress.io/@mimori37/VSCode%E3%81%A7%E3%82%82normal%E7%A7%BB%E8%A1%8C%E6%99%82%E3%81%ABIME%E5%88%87%E3%82%8A%E6%9B%BF%E3%81%88%E3%81%9F%E3%81%84
" https://wonwon-eater.com/wsl2-neovim/#outline__4_2
" ime off
if executable('spzenhan.exe')
"autocmd InsertLeave * :call system('spzenhan.exe 0')
"autocmd CmdlineLeave * :call system('spzenhan.exe 0')
"autocmd InsertEnter * :call system('spzenhan.exe 0')
" Turn off IME asynchronously when entering normal mode.
autocmd ModeChanged *:n* :call jobstart(['spzenhan.exe', '0'])
endif
