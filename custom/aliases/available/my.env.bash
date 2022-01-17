#!/usr/bin/env bash

# proxy
export BASH_IT_HTTP_PROXY=http://192.168.93.1:7890
export BASH_IT_HTTPS_PROXY=http://192.168.93.1:7890
export BASH_IT_NO_PROXY=http://127.0.0.1

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