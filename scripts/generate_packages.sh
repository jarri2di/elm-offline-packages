#!/usr/bin/env bash

# Set current working directory
cd "${0%/*}" || exit

# Set vars
packages=$(<elm-packages.txt)
elm_dir=~/.elm
success=1

function cleanup() {
    if [[ -d "elm-stuff" ]] ; then
        rm -rf elm-stuff
    fi

    if [[ -d "src" ]] ; then
        rm -rf src
    fi

    if [[ -f "elm.json" ]] ; then
        rm elm.json
    fi
}

function init() {
    # Start clean
    if [[ -d "$elm_dir" ]] ; then
        echo -e "Deleting pre-existing $elm_dir.\n"
        rm -rf "$elm_dir"
    fi

    cleanup

    echo -e "Now attempting to install packages.\n"
    sleep 2
}

function install_packages() {
    # Re-init to avoid any package dependency issues / hangs
    for package in ${packages}; do
        success=0
        yes | elm init
        yes | elm install "$package"
        cleanup
    done

    if [[ ${success} -eq 0 ]] ; then
        echo -e "Successfully installed elm packages.\n"
        cleanup
    else
        echo -e "Something seems to have gone wrong. No packages were installed.\n"
    fi
}

# Main execution
init
install_packages
