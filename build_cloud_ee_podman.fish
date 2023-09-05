#!/usr/bin/env fish

# Place this file in ~/.config/fish/functions/
# Then, the `arm_ttk_upgrade` functions will be available from your shell.

function build_cloud_ee_podman
    # Run the abc function
    abc
    
    # CD into the context folder
    cd ./context
    
    # Build the container
    podman buildx build --no-cache --platform linux/arm64 --progress=plain --build-arg ANSIBLE_GALAXY_SERVER_AUTOMATION_HUB_TOKEN=$ANSIBLE_GALAXY_SERVER_AUTOMATION_HUB_TOKEN -t quay.io/scottharwell/cloud-ee:local . --push 2>&1 | tee build.log
    
    # CD back to the parent folder
    cd ..
end
