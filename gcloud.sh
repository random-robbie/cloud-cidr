#!/bin/bash
netblocks=$(dig @8.8.8.8 txt _cloud-netblocks.googleusercontent.com +short | grep -Eo '_cloud\S+')

function get_netblock_ips {
    response=$(dig @8.8.8.8 txt +short "$1")
    for block in $(echo "$response" | grep -Eo 'include:\S+' | cut -d: -f2 ); do
        get_netblock_ips "$block"
    done

    echo "$response" | grep -Eo 'ip[46]:\S+' | cut -d: -f2-
}

{ for block in $netblocks; do get_netblock_ips "$block"; done } | sort -n | uniq
