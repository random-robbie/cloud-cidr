#!/bin/bash
set -e
INITIALURL="https://www.microsoft.com/en-in/download/confirmation.aspx?id=41653"
OUT=$(curl -s "${INITIALURL}" | grep -Eo '"https://[^"]*PublicIPs[^"]*"'|head -n 1|cut -d '"' -f 2)
curl -s -f "${OUT}" | sed 's|IpRange||g' | sed 's|" />||g' | sed 's|Subnet="||g' | sed 's|<||g' | sed 's| ||g' | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\/[0-9]\{1,2\}\|[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}'
