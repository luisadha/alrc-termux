
# Credits:
#

# Reference
# - https://github.com/tlatsas/bash-spinner
# - https://github.com/mayTermux/myTermux


# Autor : luisadha 


# Usage:
#   1. Source this file on your shell script
#   2. Start the animation:
#      start_ghost "[parameter1]" -> this parameter will display your message
#   3. Run your command
#   4. stop_ghost "[parameter1]" -> this parameter your command's exit status
#
# Also see: test.sh
#

addon_files="check_ip.sh"
lib="$HOME/luisadha/module/progress-bar/helper/"
# export ANIMATION_STATE="Berhasil"
# no="FAILED"
icon='.'
titik2="$2"


 [[ "$ANIMATION_MESSAGE" == "" ]] && [[ "$ANIMATION_STATE" == "" ]] && echo "'\$ANIMATION_MESSAGE' and '\$ANIMATION_STATE' not set yet!" && exit 1 

function animation() {

 case $1 in

   start )
   
# some code 
     let column=$(echo $COLUMNS)-${#2}-8
      printf "%${column}s"

# Perulangan    :
      until false; do
# Array animasi bertambah tergantung string
    while
    read
     do
       
          titik[$n]=$REPLY
           let n++
     done < <(
rows=$(echo "${2}" | wc -L);

for ((i=1; i<=rows; i++))
do
      for ((j=1; j<=i; j++))
      do
   echo -n "$icon"
  done
  echo
done )


# Animasi tetap
  jarumjamanimsi=( '' '/' '-' '\' '|' ); 
        for k in "${titik[@]}" 
do                
        for j in "${jarumjamanimsi[@]}"

 do

       echo -ne "\r${2}${j}${k}"

        echo -ne "\r$2${k}${j}"

          sleep 0.1
   
        done
      
        done
  
done


   ;;

   stop )

     if [[ -z ${3} ]]; then
       echo "Animation not running"
       exit 1
     fi

     kill ${3} > /dev/null 2>&1;
 # clear 
     echo -en "\r${COLOR_DEFAULT}${ANIMATION_MESSAGE} ["
     # | grep "start_animation" | awk '{print $3}'

     # ["

     if [[ $2 -eq 0 ]]; then

        echo -en "${ANIMATION_STATE:-"SUCCESS"}"
      
          else
        echo -en "FAILED"
        
     fi

     echo -e "${COLOR_DEFAULT}]"     
return 1
   ;;

   * )

      echo "invalid argument, try again with {start/stop}"
      exit 1

   ;;


  esac
}




function start_animation() {

  setterm -cursor off
  animation "start" "$1" &
  animation_pid=${!}
  disown

}

function stop_animation() {

  animation "stop" "$1" $animation_pid
  unset $animation_pid
  setterm -cursor on
}


 start_animation "$ANIMATION_MESSAGE"
 $@ &>/dev/null;

  if [[ $? -eq 0 ]]; then

 stop_animation $? || return 1

  else
  
   stop_animation $?
  fi

