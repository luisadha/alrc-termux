#!/system/bin/sh
# $0
#location /preferdir/thisscript
#for execute you can use this
# cd /preferdir
# ./thisscript
### PROGSCHE: v1.0.8
# Progsche are other progress bar in bash.
#//Progsche adalah Progres bar yang lain di bash.
# Created by <adharudin14@gmail.com>
# Copyright © 2018-2021 Luis Adha
# Need su to be able to run better.
#//Membutuhkan su agar berjalan dengan baik.
### Licenses #####################################
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#  You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.
#####################################
BL='\e[01;90m' > /dev/null 2>&1; # HITAM
R='\e[01;91m' > /dev/null 2>&1;  # MERAH
G='\e[01;92m' > /dev/null 2>&1;  # HIJAU
Y='\e[01;93m' > /dev/null 2>&1;  # KUNING
B='\e[01;94m' > /dev/null 2>&1;  # BIRU
P='\e[01;95m' > /dev/null 2>&1;  # UNGU
C='\e[01;96m' > /dev/null 2>&1;  # CYAN
W='\e[01;97m' > /dev/null 2>&1;  # PUTIH
N='\e[0m'     > /dev/null 2>&1;  # NULL
### COLOR #####################################
L='\e[1;38;5;228m'  > /dev/null 2>&1; #LIME
HB='\e[1;38;5;32m'  > /dev/null 2>&1; #HOLO BLUE 
D='\e[0m'           > /dev/null 2>&1; #Default
### ARRAY #####################################
VERSI_ARRAY=( '1.0.8' 'V1.0.8:PROGSCHE' '108' );
NAME_ARRAY=( "progsche" "Progsche" "PROGSCHE" "$0" `busybox basename "$0"` );
RELEASED="Mon, Dec 31";
UPDATED="Fri, Oct 15";
TIMEU="21:06:34 WIB 2021";
TIMER="21:57:03 WIB 2018";
### VARIABLE #####################################
about="
${NAME_ARRAY[1]} v${VERSI_ARRAY[0]} ($UPDATED, $TIMEU) - Copyright (C) 2018 - 2021 by Luis adha.

Description: Other than the common progress or loading bar in bash, this script can be run independently without options, By the way ;-)
Report bugs to <adharudin14@gmail.com>
 ";
help="
Usage: progsche -c CHAR INTEGER ...STRINGS
The -c option requires inputs a character or string if you want and after that it must inputs a number to timeout the animation running.

...
Display any argument input after -c CHAR INTEGER option if any, Remember after integer all inputs are considered strings however it has a limit (default: 9).

 e.g.: progsche --custom $ 150 The quick brown fox jumped over the lazy dogs.


Other options:
  -a   --about    display about script and exit
  -h   --help     display this help message and exit
  -v   --version  output version information and exit

 ";
title="[Presented by PROGSCHE]";
### FUNCTION
#####################################
tentang() {
  clear
        echo "$about";
 echo ''
exit
}




bantuan() {
  clear
      echo "$help";
 echo ''
exit
}




version() {
 clear
 echo "${VERSI_ARRAY[1]}";
exit
}




kursormoves() {
titik=( '' '.' '..' '...' '....' '.....' '......' );
  ####### L1  o2  a3   d4     i5      n6      g7   #7bytes
  #titik harus sama dengan titik2
  titik2=( ${B}'!Loading' ); #silahkan ubah ini maksimal 6huruf kurang dari itu lebih baik, jika Variable titik2 diubah maka variable titik juga harus diubah ini wajib ntar error kursor bergeraknya
}




function default_program() {


 judul="$1"
 waktuhabis=$2

until false; do
clear

  t=0

  kursormoves;

  jarumjamanimsi=( '=' '/' '-' '\' '|' );

    while [ $t -le $waktuhabis ]; do

        for k in "${titik[@]}"
              do
          #clear;
           
        for j in "${jarumjamanimsi[@]}"
              do
        echo -ne ${Y} "\r${judul}${titik2}${Y}${j}${k}" ${D};
          #sleep 0.2;
      

        echo -ne ${Y} "\r${judul}$k$j"
          sleep 0.2

     if [ $t -eq $2 ]; then
        echo -ne ${G}"$title\n"${D};
          sleep 1.5; # clear;
       exit
     fi
     
  let t++
        done

        done
    done
done
}




program="$1";
if [ -z "$program" ]; then
clear
 default_program "$" 175 # Loading(7)=175 #jika 100=4huruf maka 6huruf=150, berapakah 1huruf dalam 'waktuhabis'ny?
#Jawabanya adalaha 25 (stabil)

exit 1

elif [ "$program" == "-?" ] || [ "$program" == "--?" ]; then
clear; bantuan;

elif [ "$program" == "-h" ] || [ "$program" == "-help" ] || [ "$program" == "--help" ]; then
clear; bantuan;

elif [ "$program" == "-a" ] || [ "$program" == "--about" ]; then
clear; tentang;

elif [ "$program" == "-v" ] || [ "$program" == "--version" ]; then
clear; version;

elif [ "$program" == "-c" ] || [ "$program" == "--custom" ];
then
ERROR=${2?Error: option requires an argument -- c }
ERROR2=${3?Error: this option requires more arguments -- c }

int=`echo "$3" | grep -E ^\-?[0-9]*\.?[0-9]+$`

 if [ "$int" != '' ]; then

 judul="$2"
 waktuhabis=$3

until false; do
clear

  t=0

kursormoves;

  jarumjamanimsi=( '=' '/' '-' '\' '|' );

    while [ $t -le $waktuhabis ]; do

        for k in "${titik[@]}"
              do
          #clear;
           
        for j in "${jarumjamanimsi[@]}"
              do
        echo -ne ${Y} "\r${judul}${titik2}${Y}${j}${k}" ${D};
          #sleep 0.2;
      
        echo -ne ${Y} "\r${judul}$k$j"
          sleep 0.2

     if [ $t -eq $3 ]; then
strings="$4 $5 $6 $7 $8 $9 ${10} ${11} ${12}";

papat=$4
 if [ "$papat" != "$4" ]; then
        echo -ne ${G}"$title\n"${D};
          sleep 1.5; # clear;
       exit 0
 else
echo -ne ${G}"${strings[@]}\n"${D};
          sleep 1.5; # clear;
       exit 0
 fi
     fi
     
  let t++
        done

        done
    done
done;


echo $ERROR;
echo $EROOR2;

 else
echo -e "${NAME_ARRAY[0]}: Error: invalid number '$3' ";
  exit 1
 fi
exit 0
else
 clear
    echo -e "${NAME_ARRAY[2]} [HUMAN ERROR DETECTED]: unknown option '$program' ";
echo 'Use -help for a list of options.'
fi
