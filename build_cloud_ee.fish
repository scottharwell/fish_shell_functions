#!/usr/bin/env fish

# Place this file in ~/.config/fish/functions/
# Then, the `arm_ttk_upgrade` functions will be available from your shell.

function build_cloud_ee
    # Run the abc function
    abc
    
    # CD into the context folder
    cd ./context
    
    # Build the container
    docker buildx build --no-cache --platform linux/arm64 -t quay.io/scottharwell/cloud-ee:local . --push
    
    # CD back to the parent folder
    cd .
end