#!/bin/bash
APT_CACHE="/var/lib/apt/lists"

# Generic Ubuntu setup
packages=(
    build-essential
    checkinstall
    clang
    cmake
    coreutils
    cpanminus
    curl
    git
    htop
    iftop
    iperf
    netcat
    nmap
    ntp
    ntp-doc
    python-dev
    python-pip
    python-software-properties
    ruby
    ruby-dev
    software-properties-common
    tree
    wget
    zip
    zsh
)
js_packages=(
    nodejs
    npm
)

if [ -d "$APT_CACHE" ]; then
    echo "Removing apt cache before update" 1>&2
    sudo rm -rf "${APT_CACHE}/*"
fi

supports_ipython_six() {
    python -c 'from sys import version_info as v; assert v.major >= 3 and v.minor >= 3' &> /dev/null
}

# base packages
sudo apt-get update && sudo apt-get install -y ${packages[@]}

# sometimes js package installation fails on my 12.04 environments,
# so run them separately
sudo apt-get install -y ${js_packages[@]}

if supports_ipython_six; then
    sudo pip install -U pip ipython
else
    sudo pip install -U pip 'ipython<6'
fi
