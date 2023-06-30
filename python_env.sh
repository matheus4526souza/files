#!/usr/bin/env bash
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

# makes sure to not use
# python3 cuz it's from
# linux default
function check_python {
    if [ "$1" == 3 ]; then
        error_message "python3 is not supported"
    fi
}

# checks if the provided
# python version is installed
function verify_version {
    if type -p python$1 &>/dev/null; then
        echo "creating environment with python$1"
    else
        error_message "python$1 is not installed"
    fi
}

# creates the python env
function create {
    python_version="$1"
    environment_name="$2"
    arg_cant_be_empty "$python_version"
    arg_cant_be_empty "$environment_name"
    check_python "$python_version"
    verify_version "$python_version"
    make_dir "$base_folder/$environment_name"
    python$python_version -m venv "$base_folder/$environment_name"
}

# activates the python env
# need to run like this:
# source $(python_env activate <environment name>)
function activate {
    environment_name="$1"
    arg_cant_be_empty "$environment_name"
    if check_if_exists "$base_folder/$environment_name"; then
        echo "environment activated" 1>&2
        echo $base_folder/$environment_name/bin/activate
    else
        error_message "environment does not exist"
    fi
}

# removes the python env
function remove {
    environment_name="$1"
    arg_cant_be_empty "$environment_name"
    if check_if_exists "$base_folder/$environment_name"; then
        rm -rf "$base_folder/$environment_name"
    else
        error_message "environment does not exist"
    fi
}

# lists the python envs
function list {
    check_if_exists "$base_folder"
    if [ $? -ne 0 ]; then
        error_message "no environments created"
    fi
    ls "$base_folder"
}

# checks if the user is root
function check_original_user {
    if [ "$original_user" == "root" ]; then
        error_message "can not run as root, please run the Makefile"
    fi
}

# prints the help
function help {
    echo "python_env create <python version> <environment name>"
    echo "python_env activate <environment name>"
    echo "python_env remove <environment name>"
    echo "python_env list"
    echo "python_env help for more information"
}

# checks if the user is root
if [ "$EUID" -ne 0 ]
  then original_user=$(whoami)
  else original_user=${SUDO_USER}
fi
base_folder="$(getent passwd $original_user | cut -d: -f6)/python_envs"
check_original_user


# small cli
if [ "$1" == "create" ]; then
    root_confirm "to create an environment it needs to run as root"
    check_python_version_arg "$2"
    check_env_name "$3"
    create "$2" "$3"
elif [ "$1" == "activate" ]; then
    activate "$2"
elif [ "$1" == "remove" ]; then
    root_confirm "to remove an environment it needs to run as root"
    remove "$2"
elif [ "$1" == "list" ]; then
    echo "listing environments"
    echo "base folder: $base_folder"
    echo "environments:"
    echo "----------------"
    list
    echo "----------------"
elif [ "$1" == "help" ]; then
    color_comment "python_env create <python version> <environment name>" ":creates an environment with the provided python version at $base_folder/<environment name>"
    color_comment "source \$(python_env activate <environment name>)" ":it needs to run like this to activate the environment"
    color_comment "python_env remove <environment name>" ":removes the environment"
    color_comment "python_env list" ":lists all environments"
elif [ "$1" == "" ]; then
    help
else
    error_message "command not recognized"
fi