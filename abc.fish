#!/usr/bin/env fish

# Place this file in ~/.config/fish/functions/
# Then, the `arm_ttk_upgrade` functions will be available from your shell.

function abc
    # Build a Dockerfile
    ansible-builder create --output-filename Dockerfile
    
    # Change the platform to amd64 in the dockerfile
    gsed -i 's/FROM/FROM --platform=linux\/amd64/' context/Dockerfile
end