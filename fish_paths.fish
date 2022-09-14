#!/usr/bin/env fish

function fish_paths
    echo $fish_user_paths | tr " " "\n" | nl
end
