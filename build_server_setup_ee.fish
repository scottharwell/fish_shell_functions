#!/usr/bin/env fish

# Place this file in ~/.config/fish/functions/
# Then, the `arm_ttk_upgrade` functions will be available from your shell.

function build_server_setup_ee
    # Run the abc function
    abc
    
    # CD into the context folder
    cd ./context
    
    # Build the container
    docker buildx build --no-cache --platform linux/amd64,linux/arm64 -t scottharwell/server-setup-ee:latest . --push
    
    # CD back to the parent folder
    cd .
end