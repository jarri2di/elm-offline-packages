#!/usr/bin/env bash

# Set current working directory
cd "${0%/*}" || exit

# Set vars
packages=$(<elm-packages.txt)
elm_dir=~.elm
elm_zip=~/elm-packages.tar.gz
success=1

function init() {
    # Start clean
    if [[ -d "$elm_dir" ]] ; then
        echo -e "Deleting pre-existing $elm_dir\n"
        rm -rf "$elm_dir"
    fi

    if [[ -d "src" ]] ; then
        rm -rf src
    fi

    if [[ -f "elm.json" ]] ; then
        rm elm.json
    fi

    echo -e "Now attempting to install packages\n"
    sleep 2
}

function cleanup() {
    echo -e "Cleaning up\n"
    rm -rf src
    rm elm.json
}

function zip_packages() {
    echo -e "Zipping up elm packages\n"
    cd ~/ && tar czvf ${elm_zip} ${elm_dir} && echo -e "Packages saved to $elm_zip\n"
}

function install_packages() {
    # Re-init to avoid any package dependency issues / hangs
    for package in ${packages}; do
        success=0
        yes | elm init
        yes | elm install "$package"
        rm -rf src
        rm elm.json
    done

    if [[ ${success} -eq 0 ]] ; then
        echo -e "Successfully installed packages...\n"
        cleanup
        zip_packages
    else
        echo -e "Something seems to have gone wrong. No packages were installed\n"
    fi
}

# Main execution
init
install_packages
