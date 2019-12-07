#!/bin/bash
declare -r apt="/usr/bin/apt"
declare -r sudo="/usr/bin/sudo"
declare -r curl="/usr/bin/curl"

$sudo $apt install apt-transport-https ca-certificates curl software-properties-common
$curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add –
$sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs)  stable"
$sudo $apt update
$sudo $apt install docker-ce docker-ce-cli containerd.io