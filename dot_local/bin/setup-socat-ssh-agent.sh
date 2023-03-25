#!/usr/bin/env bash

NPIPERELAY=npiperelay.exe

install_npiperelay() {
    local NPIPERELAY_ZIP=https://github.com/jstarks/npiperelay/releases/download/v0.1.0/npiperelay_windows_amd64.zip

    mkdir -p ~/.local/bin && cd ~/.local/bin
    # unzip doesnt support to read from stdin.
    curl -sL -o npiperelay.zip $NPIPERELAY_ZIP
    unzip -o npiperelay.zip $NPIPERELAY
    rm npiperelay.zip
    cd -
}

start_ssh_agent() {
    export SSH_AUTH_SOCK=$HOME/.ssh/agent.sock

    command -v $NPIPERELAY &> /dev/null || install_npiperelay

    if ! ss -a | grep -q $SSH_AUTH_SOCK; then
        rm -f $SSH_AUTH_SOCK
        # prerequisite
        # - Start-Service ssh-agent on Windows
        # - ssh-add key on Windows
        (setsid socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:"${NPIPERELAY} -ei -s -v //./pipe/openssh-ssh-agent",nofork &) &> /dev/null
    fi
}

start_ssh_agent
