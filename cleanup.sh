#!/bin/bash

# Usage: ./cleanup.sh [-r] [folder]
# -r : recursively delete .vast files in subdirectories
# If no folder is given, it uses the current directory

RECURSIVE=false
TARGET_DIR="."

# Parse arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        -r)
            RECURSIVE=true
            shift
            ;;
        *)
            TARGET_DIR="$1"
            shift
            ;;
    esac
done

# Check if the folder exists
if [ ! -d "$TARGET_DIR" ]; then
    echo "Error: '$TARGET_DIR' is not a valid directory."
    exit 1
fi

# Delete files, ignoring template.vast
if $RECURSIVE; then
    echo "Deleting .vast files recursively in '$TARGET_DIR', ignoring template.vast..."
    find "$TARGET_DIR" -type f -name "*.vast" ! -name "template.vast" -print -exec rm -v {} \;
else
    echo "Deleting .vast files in '$TARGET_DIR' (non-recursive), ignoring template.vast..."
    find "$TARGET_DIR" -maxdepth 1 -type f -name "*.vast" ! -name "template.vast" -print -exec rm -v {} \;
fi

echo "Done."
