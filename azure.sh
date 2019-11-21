#!/bin/bash
set -e
INITIALURL="https://www.microsoft.com/en-in/download/confirmation.aspx?id=41653"
OUT=$(curl -s "${INITIALURL}" | grep -Eo '"https://[^"]*PublicIPs[^"]*"'|head -n 1|cut -d '"' -f 2)
curl -s -f "${OUT}" | sed 's/[^"]*"\([^"]*\)".*$/\1/g' | grep -Po '(\d+\.?){4}\/\d+'
