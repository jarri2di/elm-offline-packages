#!/usr/bin/env bash

packages=$(<packages.txt)

# Start clean
rm elm.json
rm -rf ~/.elm

sleep 5

# Install packages
# Re-init to avoid any package dependency issues / hangs
for package in ${packages}; do
    yes | elm init
    yes | elm install "$package"
    rm elm.json
done

# Create the package zip
cd ~/.elm && tar -czvf ~/elm-packages.tar.gz .

echo "Packages saved to ~/elm-packages.tar.gz"
