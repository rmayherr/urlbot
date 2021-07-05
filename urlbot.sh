#!/bin/bash

# Author:		Roland Mayherr
# Date:   		28 May 2021
# Program:		urlbot.sh
# Description:	Download content of webpages from news portal
#				and cut urls of news


#URL=https://www.hirkereso.hu/top/
#URL2=https://www.hirkereso.hu/friss/
URL=$1
PRE=${URL#*.hu}
PRE=${PRE//\//''}
FILENAME=$PRE".txt"
#FILENAME=hirkereso.txt
_command_check() {
 hash curl 2> /dev/null
 if [ "$?" -ne "0" ]
  then
  printf "%s\n" "curl is not available on this system. Please install it."
 fi
}
_process() {
 curl -kLs $URL | grep '<a href="https://' > $FILENAME
 #curl -kLs $URL2 | grep '<a href="https://' >> $FILENAME
 mapfile -t _arr < $FILENAME
 for i in "${_arr[@]}"
  do 
   i=${i#*url=} # Remove trailing waste in the string
   i=${i%?utm_source*} # Clean string until "?utm_source" tag 
   i=${i/\"/' '} # Change quote to space in the string
   i=${i%target*} # Remove everything from "target" tag in the string
   printf "%s\n" "$i"
  done 
}


_command_check
_process


