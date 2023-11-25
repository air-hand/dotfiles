#!/usr/bin/env bash

NPIPERELAY=npiperelay.exe

export SSH_AUTH_SOCK=$HOME/.ssh/agent.sock

_get_ssh_agent_pid() {
    if ! test -S $SSH_AUTH_SOCK; then
        echo "Not found: agent socket." >&2
        return 1
    fi
    
    socat_pid=$(lsof -t $SSH_AUTH_SOCK)
    if test -z "${socat_pid}"; then
        echo "No socat process found for agent socket." >&2
        return 1
    fi
    echo $socat_pid
}

start_ssh_agent() {
    if ! command -v $NPIPERELAY &> /dev/null; then
        echo "WARN: not found ${NPIPERELAY}" >&2
        return
    fi

    if ! _get_ssh_agent_pid &> /dev/null; then
        # remove if normal file.
        rm -f $SSH_AUTH_SOCK
        cat << 'EOF'
Prerequisite for ssh-agent with npiperelay below
- Start-Service ssh-agent on Windows
- ssh-add key on Windows
EOF

        (setsid socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:"${NPIPERELAY} -ei -s -v //./pipe/openssh-ssh-agent",nofork &) &> /dev/null
    fi
}

stop_ssh_agent() {
    socat_pid=$(_get_ssh_agent_pid) \
        && echo "kill pid: ${socat_pid}" && kill $socat_pid
}

start_ssh_agent
