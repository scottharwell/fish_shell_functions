#!/usr/bin/env fish

function restart_dns
    echo "Restarting DNS"

    # Flush cache
    sudo dscacheutil -flushcache
    
    # Restart DNS responder
    sudo killall -HUP mDNSResponder

    echo "DNS restarted"
end
