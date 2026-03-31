#!/bin/bash   

# Trap to handle shell script errors 
trap 'error_handler' ERR
error_handler() {
    error_time=$(date '+%Y-%m-%d %H:%M:%S')
    echo -e "\n\033[0;31mWarning\033[0m: run_all.sh failed at ${error_time}. Check above for details." # display warning in terminal
    exit 1 # early exit with error code
}

# Replace with name of your project
PROJECT_NAME="battery_warranties"

# Tell user what we're doing
echo -e "Making \033[35m${PROJECT_NAME}\033[0m with shell: ${SHELL}"

# Run makefiles of each module
${SHELL} data_cleaning/make.sh
${SHELL} exploratory_figures/make.sh
${SHELL} regression_scripts/make.sh

