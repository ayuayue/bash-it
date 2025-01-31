#!/usr/bin/env bash

_bash-it-comp-enable-disable()
{
  local enable_disable_args="alias completion plugin"
  COMPREPLY=( $(compgen -W "${enable_disable_args}" -- "${cur}") )
}

_bash-it-comp-list-available-not-enabled()
{
  local subdirectory="$1"

  local enabled_components all_things available_things

  all_things=( $(compgen -G "${BASH_IT}/$subdirectory/available/*.bash") ); all_things=( "${all_things[@]##*/}" )
  enabled_components=( $(command ls "${BASH_IT}"/{"$subdirectory"/,}enabled/*.bash 2>/dev/null) )
  enabled_components=( "${enabled_components[@]##*/}" ); enabled_components="${enabled_components[@]##*---}"
  available_things=( $(sort -d <(for i in ${enabled_components}
    do
      all_things=( "${all_things[@]//$i}" )
    done
    printf '%s\n' "${all_things[@]}")) ); available_things="${available_things[@]%.*.bash}"

  COMPREPLY=( $(compgen -W "all ${available_things}" -- "${cur}") )
}

_bash-it-comp-list-enabled()
{
  local subdirectory="$1"
  local suffix enabled_things

  suffix="${subdirectory/plugins/plugin}"

  enabled_things=( $(sort -d <(compgen -G "${BASH_IT}/$subdirectory/enabled/*.${suffix}.bash") <(compgen -G "${BASH_IT}/enabled/*.${suffix}.bash")) )
  enabled_things=( "${enabled_things[@]##*/}" ); enabled_things=( "${enabled_things[@]##*---}" ); enabled_things="${enabled_things[@]%.*.bash}"

  COMPREPLY=( $(compgen -W "all ${enabled_things}" -- "${cur}") )
}

_bash-it-comp-list-available()
{
  local subdirectory="$1"

  local enabled_things

  enabled_things=( $(sort -d <(compgen -G "${BASH_IT}/$subdirectory/available/*.bash")) )
  enabled_things=( "${enabled_things[@]##*/}" ); enabled_things="${enabled_things[@]%.*.bash}"

  COMPREPLY=( $(compgen -W "${enabled_things}" -- "${cur}") )
}

_bash-it-comp-list-profiles()
{
  local profiles

  profiles=$(for f in `compgen -G "${BASH_IT}/profiles/*.bash_it" | sort -d`;
    do
      basename $f | sed -e 's/.bash_it//g'
    done)

  COMPREPLY=( $(compgen -W "${profiles}" -- ${cur}) )
}

_bash-it-comp()
{
  local cur prev opts
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"
  chose_opt="${COMP_WORDS[1]}"
  file_type="${COMP_WORDS[2]}"
  opts="disable enable help migrate reload restart profile doctor search show update version"
  case "${chose_opt}" in
    show)
      local show_args="aliases completions plugins"
      COMPREPLY=( $(compgen -W "${show_args}" -- "${cur}") )
      return 0
      ;;
    help)
      if [ x"${prev}" == x"aliases" ]; then
        _bash-it-comp-list-available aliases
        return 0
      else
        local help_args="aliases completions migrate plugins update"
        COMPREPLY=( $(compgen -W "${help_args}" -- "${cur}") )
        return 0
      fi
      ;;
    profile)
      case "${file_type}" in
        load)
          if [[ "load" == "$prev" ]]; then
            _bash-it-comp-list-profiles
          fi
          return 0
          ;;
        rm)
          if [[ "rm" == "$prev" ]]; then
            _bash-it-comp-list-profiles
          fi
          return 0
          ;;
        save)
          return 0
          ;;
        list)
          return 0
          ;;
        *)
          local profile_args="load save list rm"
          COMPREPLY=( $(compgen -W "${profile_args}" -- ${cur}) )
          return 0
          ;;
      esac
      ;;
    doctor)
      local doctor_args="errors warnings all"
      COMPREPLY=( $(compgen -W "${doctor_args}" -- "${cur}") )
      return 0
      ;;
    update)
      if [[ "${cur}" == -* ]];then
        local update_args="-s --silent"
      else
        local update_args="stable dev"
      fi
      COMPREPLY=( $(compgen -W "${update_args}" -- "${cur}") )
      return 0
      ;;
    migrate | reload | restart | search | version)
      return 0
      ;;
    enable | disable)
      if [ x"${chose_opt}" == x"enable" ];then
        suffix="available-not-enabled"
      else
        suffix="enabled"
      fi
      case "${file_type}" in
        alias)
            _bash-it-comp-list-"${suffix}" aliases
            return 0
            ;;
        plugin)
            _bash-it-comp-list-"${suffix}" plugins
            return 0
            ;;
        completion)
            _bash-it-comp-list-"${suffix}" completion
            return 0
            ;;
        *)
            _bash-it-comp-enable-disable
            return 0
            ;;
      esac
      ;;
  esac

  COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )

  return 0
}

# Activate completion for bash-it and its common misspellings
complete -F _bash-it-comp bash-it
complete -F _bash-it-comp bash-ti
complete -F _bash-it-comp shit
complete -F _bash-it-comp bashit
complete -F _bash-it-comp batshit
complete -F _bash-it-comp bash_it
