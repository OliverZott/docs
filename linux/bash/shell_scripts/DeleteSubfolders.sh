#!/bin/bash

# Script to search for all "obj" and "bin" folders recursively and delete them

# Usage: 
#   ./DeleteSubfolders.sh <path> [-y] [-f <folder_name>]
#   ./DeleteSubfolders.sh /path/to/folder -f venv test

# Note: Make sure to set the script as executable using the command chmod +x DeleteSubfolders.sh.

# Check if path argument is provided
if [[ -z $1 ]]; then
    echo "Path argument is missing."
    exit 1
fi

path=$1
skip_confirmation=false
folder_name=("bin" "obj")

# Check if "-y" parameter is provided
if [[ $2 == "-y" ]]; then
    skip_confirmation=true
fi

# Check if "-f" parameter is provided
if [[ $3 == "-f" ]]; then
    folder_name=("${@:4}")
fi

folders_to_delete=$(find "$path" -type d \( -name "${folder_name[0]}" $(printf -- '-o -name %s ' "${folder_name[@]:1}") \))

if [[ -z $folders_to_delete ]]; then
    echo "No folders named '${folder_name[*]}' found."
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


display_help() {
  echo "Script to search for all "obj" and "bin" folders recursively and delete them"
  echo ""
  echo "Usage: "
  echo "    ./DeleteSubfolders.sh <path> [-y] [-f <folder_name> <folder_name>]"
  echo "    ./DeleteSubfolders.sh /path/to/folder -f venv test"
  echo ""
  echo "Options:"
  echo "  -y           Skip confirmation prompt"
  echo "  -f           Specify folder name(s) to search for (default: bin, obj)"
  echo ""
  echo "Note: Make sure to set the script as executable using the command chmod +x DeleteSubfolders.sh."
  echo ""
  exit 0
}

if [[ $1 == "-h" || $1 == "--help" ]]; then
  display_help
fi