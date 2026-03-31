#!/bin/bash

# Trap to handle shell script errors 
trap 'error_handler' ERR
error_handler() {
    error_time=$(date '+%Y-%m-%d %H:%M:%S')
    echo -e "\n\033[0;31mWarning\033[0m: setup.sh failed at ${error_time}. Check above for details." # display warning in terminal
    exit 1 # early exit with error code
}

REPO_ROOT="$(cd "$(dirname -- "$0")" && pwd -P)"

# Check if local_env.sh exists
echo "Checking if local_env.sh exists..."
echo "It is required to run the module correctly according to your local setup."
if [ ! -f "${REPO_ROOT}/local_env.sh" ]; then
    echo "The file local_env.sh was not found at the root of the repository."
    echo -e "\n\033[0;34mPlease choose:\033[0m Would you like to create local_env.sh from /lib/setup/local_env_template.sh? (y/n): "
    read -r local_env_confirm
    if [[ "$local_env_confirm" != "y" ]]; then
        echo -e "\nOK. Please create local_env.sh and re-run this script."
        exit 1
    fi

    cp "${REPO_ROOT}/lib/setup/local_env_template.sh" "${REPO_ROOT}/local_env.sh"
    echo "local_env.sh has been created from the template."
    echo "Please edit it to reflect your local executables and external file paths."
    echo -e "Press \033[0;34mEnter\033[0m to continue after editing or re-run setup.sh once you've done so."
    read
    else
        echo -e "\033[0;34mNote:\033[0m: local_env.sh already exists."
fi

# Create external symlinks
echo -e "\nNow, we will create links to external files, if there are any."
source "${REPO_ROOT}/lib/shell/make_externals.sh"

# Setup Completed
echo -e "\nSetup complete."

