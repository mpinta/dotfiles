#!/bin/bash
declare -r apt="/usr/bin/apt"
declare -r sudo="/usr/bin/sudo"

$sudo $apt update && sudo apt upgrade -y