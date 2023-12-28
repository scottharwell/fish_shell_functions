#!/usr/bin/env fish

function build_server_setup_ee
    # Delete the context folder
    rm -rf ./context

    # Run the abc function
    # abc
    ansible-builder create --output-filename Dockerfile
    
    # CD into the context folder
    cd ./context
    
    # Build the container
    docker buildx build --no-cache --platform linux/arm64,linux/amd64 --progress=plain --build-arg ANSIBLE_GALAXY_SERVER_AUTOMATION_HUB_TOKEN=$ANSIBLE_GALAXY_SERVER_AUTOMATION_HUB_TOKEN -t scottharwell/server-setup-ee:latest . --push 2>&1 | tee build.log
    
    # CD back to the parent folder
    cd ..
end
