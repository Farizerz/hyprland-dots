#!/bin/bash

# Script to find all *.sh files in a directory and make them executable

# Check if a directory is provided, default to current directory
directory="$HOME/.config/scripts/"

# Validate that the directory exists
if [ ! -d "$directory" ]; then
    echo "Error: '$directory' does not exist or is not a directory."
    exit 1
fi

# Find all *.sh files and make them executable
find "$directory" -type f -name "*.sh" -exec chmod +x {} \;

# Provide feedback
if [ $? -eq 0 ]; then
    echo "✅ All of the scripts in '$directory' are now executable."
else
    echo "Error: Failed to change permissions."
    exit 1
fi