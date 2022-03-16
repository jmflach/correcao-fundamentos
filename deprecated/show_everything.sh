#!/bin/bash

ATUAL=$2
PROX=$(($ATUAL + 1))


file=$1

BLUE='\033[1;31m'
NC='\033[0m' # No Color

UP=$3
FILE2SAVE=$4

#echo ""
#echo -e "${BLUE}************************************************************************************************${NC}"
#echo -e "${BLUE}$file${NC}"
#echo ""
    


###################################


#re=$(echo "$r" | grep ";;.*conta-cartas.*:.*")

#if [ -z "$re" ]
#then
#    echo "$r" > tmp.rkt
#else
#    echo "$re" > tmp.rkt
#fi

#r=$(echo "$r" | grep -i -m 1  -A 40 ";;")

cat $file > "$FILE2SAVE"

#pygmentize -l racket  tmp.rkt

#echo ""
#echo -e "${BLUE}************************************************************************************************${NC}"
#echo ""
#echo ""
