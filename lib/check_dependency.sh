#! bash alrc-termux.module

function check_dependency {
if ! (builtin command -V "$1" >/dev/null 2>&1); then
echo "alrc-termux: missing dependency can't find $1"  
return 127         
  fi
}                                
