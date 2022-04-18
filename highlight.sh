#!/usr/bin/env bash

PATTERNS=()
COLORS=()
STS=0
BUFFER=""

for arg in "${@}"
do
    if [[ $STS = 0 ]] 
    then
        PATTERNS+=("$arg")
        STS=$(($STS+1))
    elif [[ $STS = 1 ]] 
    then
        COLORS+=("${arg}")
        STS=0
    else   
        echo "UNKNOWN STATE: $PTR STS: $STS"
    fi
done

NC='\033[0m' # No Color

function colorize {
   case "$2" in
       "RED") 
         COLOR='\033[0;31m'
       ;;
       "BLACK")
         COLOR='\033[0;30m'
       ;;
       "GREEN")
         COLOR='\033[0;32m'
       ;;
       "ORANGE")
         COLOR='\033[0;33m'
       ;;
       "BLUE")
         COLOR='\033[0;34m'
       ;;
       "PURPLE")
         COLOR='\033[0;35m'
       ;;
       "CYAN")
         COLOR='\033[0;36m'
       ;;
       "LIGHTGRAY")
         COLOR='\033[0;37m'
       ;;
       "DARKGRAY")
         COLOR='\033[1;30m'
       ;;
       "LIGHTRED")
         COLOR='\033[1;31m'
       ;;
       "LIGHTGREEN")
         COLOR='\033[1;32m'
       ;;
       "YELLOW")
         COLOR='\033[1;33m'
       ;;
       "LIGHTBLUE")
         COLOR='\033[1;34m'
       ;;
       "LIGhtPURPLE")
         COLOR='\033[1;35m'
       ;;
       "LIGHTCYAN")
         COLOR='\033[1;36m'
       ;;
       "WHITE")
         COLOR='\033[1;37m'
       ;;
       *)
         COLOR='NO_COLOR'
       ;;
   esac
   echo -e "${COLOR}${1}${NC}"
}
function handleLine {
    LINE=$1
    colorized="0"
    for index in "${!PATTERNS[@]}"
    do
        pattern=${PATTERNS[$index]} 
        color=${COLORS[$index]}
        if [[ $line =~ $pattern ]]; then
            colorize "$line" $color
            colorized=1
            break
        fi
    done
    if [ $colorized = "0" ]
    then
        echo "$line"
    fi
}
while read line; do 
    handleLine "$line" 
done < /dev/stdin
