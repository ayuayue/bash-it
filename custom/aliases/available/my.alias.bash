#!/usr/bin/env bash
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ll='ls -alh'
# alias proxy="export http_proxy=http://192.168.190.1:7890 && export https_proxy=http://192.168.190.1:7890"
# alias unproxy="unset http_proxy && unset https_proxy"
alias br='bash-it reload'
alias bt='bash-it'


# dnmp alias
alias dnginx='docker exec -it nginx /bin/sh'
alias dphp='docker exec -it php sh'
alias dphp8='docker exec -it php8 sh'
alias dphp56='docker exec -it php56 /bin/sh'
alias dphp54='docker exec -it php54 /bin/sh'
alias dmysql='docker exec -it mysql /bin/bash'
alias dredis='docker exec -it redis /bin/sh'
