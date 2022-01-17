#!/usr/bin/env bash


# env
export LC_ALL=en_US.UTF-8  
export LANG=en_US.UTF-8
export LD_LIBRARY_PATH="/usr/local/instantclient"
export APACHE="/usr/local/apache"
export PHP="/usr/local/php"
export PATH="${HOME}/bin:${HOME}/.g/go/bin:$PATH:$APACHE/bin:$PHP/bin"

# bind
# bind 'set show-all-if-ambiguous on'
# bind 'TAB:menu-complete'

# hstr
hstr --show-configuration >> ~/.bashrc