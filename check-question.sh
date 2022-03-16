#!/bin/bash


ATT='\033[5;35m'
OK='\033[1;35m'
NC='\033[0m'

file=$1
TEM=$2
BEGIN="$3"
END="$4"
MIDDLE="$5"
ERROR=$6

#r=$(grep -i -A 1000 "$BEGIN" $file | grep -i -m 1 -B 1000 "$END" | grep "$MIDDLE")

#grep -i --color -E "$BEGIN" $file

r=$(grep -i -E "$BEGIN" $file)

echo "$r" > tmp.rkt


if [ "$TEM" = "nao-deve-ter" ]
then
    if [ ! -z "$r" ]
    then
        echo -e "${ATT}ERRO: "$ERROR"${NC}"
        echo -e "${ATT}************************************************************************************************${NC}"
        pygmentize -l racket tmp.rkt
        echo -e "${ATT}************************************************************************************************${NC}"
    else
        echo -e "${OK}OK${NC}"
    fi
fi

if [ "$TEM" = "deve-ter" ]
then
    if [ -z "$r" ]
    then
        echo -e "${ATT}ERRO: "$ERROR"${NC}"
    else
        echo -e "${OK}OK${NC}"
        echo -e "${OK}************************************************************************************************${NC}"
        pygmentize -l racket tmp.rkt
        echo -e "${OK}************************************************************************************************${NC}"
    fi
fi
