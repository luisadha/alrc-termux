
function check_dependency {
# by luisadha
if ! (builtin command -V "$1" >/dev/null 2>&1); then
echo "missing dependency: can't find $1"  
return 1            
  fi
}                                          

declare -f -x check_dependency

