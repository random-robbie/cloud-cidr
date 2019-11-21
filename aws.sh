#!/bin/bash
curl -s https://ip-ranges.amazonaws.com/ip-ranges.json | jq -r '.prefixes | .[].ip_prefix'
