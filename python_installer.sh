#!/usr/bin/bash
# $1 is the user link

# funtions

# get the version of the python file
function get_version {
    local version=$(dirname "$1")
    version=$(basename "$version")
    version=${version%.*}
    echo "$version"
}

function verify_version {
    echo "python$1"
    if type -p python$1 &>/dev/null; then
        error_message "python version already installed"
    else
        echo "installing provided python version"
    fi
}

function error_message {
    echo $1
    echo "exiting script"
    exit 1
}

function check_tgz {
    if [[ $1 != *.tgz ]]; then
        error_message "file provided does not end with .tgz"
    fi
}

function get {
    wget "$1" --no-check-certificate
}

function check_if_exists {
    if [ -f "$1" ]; then
        return 0
    else
        return 1
    fi
}

function make_dir {

    if check_if_exists "$1"; then
        echo "path already exists"
        echo "$1"
        return
    else
        echo "creating path"
        mkdir "$1"
        if [ $? -ne 0 ]; then
            error_message "failed to create path"
        fi
        pushd "$1"
    fi
}

function python_install {
    sudo apt-get update
    sudo apt-get install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libsqlite3-dev libreadline-dev libffi-dev curl libbz2-dev
    tar -xf $1
    python_folder=$(basename "$1" .tgz)
    $python_folder/configure --enable-optimizations
    make
    make altinstall
    rm -r "$2"
}

function root_confirm {
    if [ "$EUID" -ne 0 ]; then
    error_message "need to run as root"
    fi
}

# variables
original_user=$(logname)
base_folder="$(getent passwd $original_user | cut -d: -f6)/python_versions"
filename=$(basename "$1")

# main script

# confirms if running with sudo/root
root_confirm
# checks if file is a tgz
check_tgz "$1"
# gets the version of the python file
# is already installed
version=$(get_version "$1")
verify_version "$version"

# creates the base folder
make_dir "$base_folder"

# downloads the file
get $1

# installs the file
# and removes the file
python_install "$filename" "$base_folder"

