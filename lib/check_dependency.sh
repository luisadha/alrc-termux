
function check_dependency {
# by luisadha
if ! (builtin command -V "$1" >/dev/null 2>&1); then
echo "missing dependency: can't find $1"  
return 1            
  fi
}                                          

read -a ALVAR_BASH_VERSINFO < <((alvar -xnf BASH | grep -Eo '[0-9]+' | xargs))

_alrc_bash_version=$((ALVAR_BASH_VERSINFO[0] * 10000 + ALVAR_BASH_VERSINFO[1] * 100 + ALVAR_BASH_VERSINFO[2]))

echo $_alrc_bash_version


: "
  if ((_omb_bash_version >= 40000)); then                           _omb_util_command_exists() {                                      type -t -- "$@" &>/dev/null
}                                                               _omb_util_binary_exists() {                                       type -P -- "$@" &>/dev/null
}                                                             else                                                              _omb_util_command_exists() {                                      while (($#)); do                                                  type -t -- "$1" &>/dev/null || return 1                         shift                                                         done                                                          }      
_omb_util_binary_exists() {                                       while (($#)); do                                                  type -P -- "$1" &>/dev/null || return 1                         shift                                                         done                                                          }             
fi                                                              _omb_util_function_exists() {                                     declare -F "$@" &>/dev/null 
# bash-3.2                        

}
} "
