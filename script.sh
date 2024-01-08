#!/bin/bash

command_exists() {
    command -v "$1" > /dev/null 2>&1
}

download_image() {
    echo "Starting to download image."
    # Download image and save it inside 'working_dir' as 'python.png'
    # -O is an option to save downloaded file with custom name
    wget -O working_dir/python.png https://www.python.org/static/apple-touch-icon-144x144-precomposed.png
}

# Create a new directory 'working_dir'
mkdir working_dir

# Inside 'working_dir', create a file 'file.txt'
touch working_dir/file.txt

# Create a subdirectory 'sub_dir' inside 'working_dir'
mkdir working_dir/sub_dir

# Output listing of all files and directories (long format) of '/home(Users for mac)/{your_username}' to 'file.txt'
ls -l /Users/$(whoami) > working_dir/file.txt

# Copy 'working_dir/file.txt' to 'working_dir/sub_dir/file.txt'
cp working_dir/file.txt working_dir/sub_dir/file.txt

if command_exists wget; then
    echo "wget is installed."
    download_image;
else 
    echo "Started installing of wget."
    if [ "$(uname)" == "Darwin" ]; then
        # for Mac
        if command_exists brew; then
            brew install wget
        else
            echo "Failed to install wget due to package manager is not installed. Install brew or wget manually and rerun the script"
            exit 1
        fi
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then 
        # for Linux
        if command_exists apt; then
            sudo apt install -y wget
        else
            echo "Failed to install wget due to package manager is not installed. Install apt or wget manually and rerun the script"
            exit 1
        fi
    else
        echo "Failed to define system package manager. Install wget manually and rerun script"
        exit 1
    fi

    download_image;
fi

# Output the value of the system $HOME variable into 'file.txt'
echo "Value of \$HOME variable: $HOME" >> working_dir/file.txt

echo "Script execution completed successfully!"
