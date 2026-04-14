" VSCode integrated terminal workaround (Neovim + JIS)
if has('nvim') && $TERM_PROGRAM ==# 'vscode'
    inoremap <S-1> !
    " char-34 means '"'. ignore vimscript's comment.
    inoremap <S-2> <char-34>
    inoremap <S-3> #
    inoremap <S-4> $
    inoremap <S-5> %
    inoremap <S-6> &
    inoremap <S-7> '
    inoremap <S-8> (
    inoremap <S-9> )

    cnoremap <S-1> !
    " char-34 means '"'. ignore vimscript's comment.
    cnoremap <S-2> <char-34>
    cnoremap <S-3> #
    cnoremap <S-4> $
    cnoremap <S-5> %
    cnoremap <S-6> &
    cnoremap <S-7> '
    cnoremap <S-8> (
    cnoremap <S-9> )
endif
