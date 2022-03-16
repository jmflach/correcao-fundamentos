#!/bin/bash


# CORES
RED='\033[1;31m'
NC='\033[0m' # No Color


cd q5

clear

QUESTION=$1

files=(*.rkt)

n=0
direction="x"
max="${#files[@]}"


while [ $direction != "q" ]
do
    #echo ${files[$n]}

    echo ""
    echo -e "${RED}************************************************************************************************${NC}"
    echo -e "${RED}${files[$n]}${NC}"
    echo ""

    ../show_racket_question.sh ${files[$n]} $QUESTION


    echo ""
    echo -e "${RED}************************************************************************************************${NC}"
    echo ""

    # n é numero de chars
    # s não echo
    echo -e "${RED}                                            "$(( n+1 )) of $max" ${NC}"
    echo ""
    echo -e "${RED}                                       <- (z) ---- (x) -> ${NC}"
    read -n 1 -s -r -p "" direction


    # OPEN FILE
    if [ $direction = "o" ]
    then
        drracket ${files[$n]}
        read -n 1 -s -r -p "" direction
    fi


    if [ $direction = "x" ]
    then
        n=$(( n+1 ))
    fi
    if [ $direction = "z" ]
    then        
        n=$(( n-1 ))
    fi

    if [ $n = $max ]
    then
	  break       	  #Abandon the while lopp.
    fi
    if [ $n = -1 ]
    then
	  break       	  #Abandon the while lopp.
    fi

    clear
done
