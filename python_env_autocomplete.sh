#!/usr/bin/env bash

function get_username {

    if [ "$EUID" -ne 0 ]; then
        echo $(whoami)
    else
        echo ${SUDO_USER}
    fi
}

original_user=$(get_username)
base_folder="$(getent passwd $original_user | cut -d: -f6)/python_envs"

function list_envs {
    if [[ -d "$dir" && -z "$(ls -A $dir)" ]] ; then
        echo "empty"
        return 0
    fi
    for i in $(find $base_folder -maxdepth 1 -mindepth 1)
    do
        echo $(basename $i)
    done
}

auto_complete()
{
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    envs_name=$(list_envs)
    # Provide auto-completion for the "activate" command.
    opts="activate list create remove help"
    COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
    if [[ ${prev} == "activate" ]] || [[ ${prev} == "remove" ]]; then
        opts=$envs_name
        COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
    fi

    return 0
}

complete -o nospace -F auto_complete python_env