#!/usr/bin/env bash


ln -s /www/bash-it/custom/aliases/available/*.bash /www/bash-it/custom/enabled/ &> /dev/null
ln -s /www/bash-it/custom/completion/available/*.bash /www/bash-it/custom/enabled/ &> /dev/null
ln -s /www/bash-it/custom/plugins/available/*.bash /www/bash-it/custom/enabled/ &> /dev/null


# plugins
bash-it enable plugin proxy docker docker-compose git autojump extract  ssh z_autoenv &> /dev/null

#alias 
bash-it enable alias docker docker-compose osx git vim curl composer systemd &> /dev/null