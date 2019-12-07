#!/bin/bash
declare -r apt="/usr/bin/apt"
declare -r sudo="/usr/bin/sudo"

$sudo $apt remove jq libxml2-utils -y