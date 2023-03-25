#!/usr/bin/env bash

start_ssh_agent() {
    export SSH_AUTH_SOCK=$HOME/.ssh/agent.sock

    if ! ss -a | grep -q $SSH_AUTH_SOCK; then
        rm -f $SSH_AUTH_SOCK
        (setsid socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:"npiperelay.exe -ei -s -v //./pipe/openssh-ssh-agent",nofork &) &> /dev/null
    fi
}

start_ssh_agent
