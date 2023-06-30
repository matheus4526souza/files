function error_message {
    echo $1
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