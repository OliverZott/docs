#!/bin/bash

# Script to search for all "obj" and "bin" folders recursively and delete them

# Usage: ./DeleteSubfolders.sh <path> [-y]

# Note: Make sure to set the script as executable using the command chmod +x DeleteSubfolders.sh.

# Check if path argument is provided
if [[ -z $1 ]]; then
    echo "Path argument is missing."
    exit 1
fi

path=$1
skip_confirmation=false

# Check if "-y" parameter is provided
if [[ $2 == "-y" ]]; then
    skip_confirmation=true
fi

folders_to_delete=$(find "$path" -type d \( -name "obj" -o -name "bin" \))

if [[ -z $folders_to_delete ]]; then
    echo "No folders named 'bin' or 'obj' found."
else
    echo -e "The following folders will be deleted:\n"
    echo "$folders_to_delete"

    if [[ $skip_confirmation == true ]]; then
        confirmation='y'
    else
        read -p "Do you want to continue deleting? (y/n): " confirmation
    fi

    if [[ $confirmation == 'y' ]]; then
        echo "$folders_to_delete" | xargs rm -rf
        echo "Folders deleted successfully."
    else
        echo "Deletion canceled."
    fi
fi
