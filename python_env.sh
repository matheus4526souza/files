#!/bin/bash
# $1 python command, can not be empty
# or python3/python to secure the
# correct version of python
# installed by the other script
# $2 is the environment name
# needs to check if the environment
# already exists, if so, fail it

#script_dir=$(dirname "$0")
#source "/home/nebula/bash_scripts/lib/common_functions.sh" #"$script_dir/lib/common_functions.sh"
source "__COMMON_FUNCTIONS_SH_PATH__"

function error_message {
    echo "$1"
    echo "exiting script"
    exit 1
}

function check_if_exists {
    if [ -e "$1" ]; then
        return 0 # true
    else
        return 1 # false
    fi
}

function verify_version {
    if type -p python$1 &>/dev/null; then
        echo "python version exists, creating python$1 environment"
    else
        error_message "python version does not exist"
    fi
}

function make_dir {

    if check_if_exists "$1"; then
        error_message "$1 already exists"
    else
        echo "creating path"
        mkdir -p "$1"
        if [ $? -ne 0 ]; then
            error_message "${2:-failed to create path}"
        fi
        pushd "$1"
    fi
}

function verify_version {
    if type -p python$1 &>/dev/null; then
        error_message "${2:-python version already installed}"
    else
        echo "${3:-installing provided python version}"
    fi
}

function check_python {
    if [ "$1" == 3 ]; then
        error_message "python3 is not supported"
    fi
}

function create {
    python_version="$1"
    environment_name="$2"

    check_python "$python_version"
    verify_version "$python_version"
    make_dir "$base_folder/$environment_name"
    python$python_version -m venv "$base_folder/$environment_name"
}

function activate {
    environment_name="$1"
    if check_if_exists "$base_folder/$environment_name"; then
        echo "environment activated" 1>&2
    else
        error_message "environment does not exist"
    echo $base_folder/$environment_name/bin/activate
    fi
}

function remove {
    environment_name="$1"
    if check_if_exists "$base_folder/$environment_name"; then
        rm -r "$base_folder/$environment_name"
    else
        error_message "environment does not exist"
    fi
}

function list {
    check_if_exists "$base_folder"
    if [ $? -ne 0 ]; then
        error_message "no environments created"
    fi
    ls "$base_folder"
}

function check_original_user {
    if [ "$original_user" == "root" ]; then
        error_message "can not run as root, please run the Makefile"
    fi
}

original_user=$(whoami)
base_folder="$(getent passwd $original_user | cut -d: -f6)/python_envs"
check_original_user


if [ "$1" == "create" ]; then
    create "$2" "$3"
elif [ "$1" == "activate" ]; then
    activate "$2"
elif [ "$1" == "remove" ]; then
    remove "$2"
elif [ "$1" == "list" ]; then
    echo "listing environments"
    echo "base folder: $base_folder"
    echo "environments:"
    echo "----------------"
    list
    echo "----------------"
elif [ "$1" == "help" ]; then
    echo "create <python version> <environment name>"
    echo "activate <environment name>"
    echo "remove <environment name>"
    echo "list"
elif [ "$1" == "" ]; then
    error_message "command not provided"
elif [ "$1" == "falar" ]; then
    echo $base_folder
else
    error_message "command not recognized"
fi