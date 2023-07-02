#!/usr/bin/env bash

if [ -e "/home/nebula/bash_scripts/lib/python_env_autocomplete.sh" ]; then
    source "/home/nebula/bash_scripts/lib/python_env_autocomplete.sh"
    else
    script_dir=$(dirname "$0")
    source "$script_dir/lib/common_functions.sh"
fi

original_user=$(get_username)
base_folder="$(getent passwd $original_user | cut -d: -f6)/python_envs"

auto_complete()
{
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    # Provide auto-completion for the "activate" command.
    opts="--help" #$(ls $base_folder)
    COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )


    return 0
}

complete -o nospace -F auto_complete python_env