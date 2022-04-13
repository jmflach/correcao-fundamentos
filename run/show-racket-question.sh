#!/bin/bash

ATUAL=$2
PROX=$(($ATUAL + 1))

#if [ $ATUAL -eq 6 ]
#then
#  ATUAL="EXTRA"
#fi

file=$1

BLUE='\033[1;31m'
NC='\033[0m' # No Color

UP=$(( $3 + 1 ))
FILE2SAVE=$4

#echo ""
#echo -e "${BLUE}************************************************************************************************${NC}"
#echo -e "${BLUE}$file${NC}"
#echo ""


INICIO=("QUEST.O $ATUAL" "${ATUAL}${ATUAL}${ATUAL}${ATUAL}${ATUAL}")
FIM=("QUEST.O $PROX" "${PROX}${PROX}${PROX}${PROX}${PROX}" ";; FUN..ES PARA VISUALIZA..O DE .RVORES" "XXX TESTES INSERIDOS XXX")

s=""

for inicio in "${INICIO[@]}"; do   # The quotes are necessary here
      for fim in "${FIM[@]}"; do   # The quotes are necessary here
        if [ -z "$s" ]
        then
          #echo "$inicio $fim"
          s=$(grep -i -A 1000 -B $UP "$inicio" $file | grep -i -m 1 -A 1 -B 1000 "$fim")
        fi
      done
done

r=$(grep -i -A 1000 -B $UP "QUEST.O $ATUAL" $file | grep -i -m 1 -A 1 -B 1000 "QUEST.O $PROX")


#if [ -z "$r" ]
#then
#    r=$(grep -i -A 1000 -B $UP "EXERC.CIO $ATUAL" $file | grep -i -m 1  -B 1000 "EXERC.CIO $PROX")
#fi

#if [ -z "$r" ]
#then
#    r=$(grep -i -A 1000 -B $UP ";;.* $ATUAL .*" $file | grep -i -m 1 -B 1000 ";;.* $PROX .*")
#fi

#if [ -z "$r" ]
#then
#    r=$(grep -i -A 1000 -B $UP ";;.*$ATUAL $ATUAL $ATUAL" $file | grep -i -m 1  -B 1000 ";;.*$PROX $PROX $PROX")
#fi


### WHEN THE ATUAL IS THE LAST ###





if [ -z "$r" ]
then
    r=$(grep -i -A 1000 "QUEST.O $ATUAL" $file | grep -i -m 1 -A 1 -B 1000 ";; DEFINIÇÃO DE FUNÇÕES PARA DESENHAR UMA CARTA")
fi

#if [ -z "$r" ]
#then
#    r=$(grep -i -A 1000 "QUEST.O $ATUAL" $file | grep -i -m 1 -A 1 -B 1000 "QUEST.O EXTRA")
#fi

if [ -z "$r" ]
then
    r=$(grep -i -A 1000 "QUEST.O $ATUAL" $file | grep -i -m 1 -A 1 -B 1000 "XXX TESTES INSERIDOS XXX")
fi
#if [ -z "$r" ]
#then
#    r=$(grep -i -A 1000 "EXERC.CIO $ATUAL" $file | grep -i -m 1  -B 1000 "TESTES TESTES TESTES")
#fi

#if [ -z "$r" ]
#then
#    r=$(grep -i -A 1000 ";;.* $ATUAL .*" $file | grep -i -m 1 -B 1000 "TESTES TESTES TESTES")
#fi

#if [ -z "$r" ]
#then
#    r=$(grep -i -A 1000 ";;.*$ATUAL $ATUAL $ATUAL" $file | grep -i -m 1  -B 1000 "TESTES TESTES TESTES")
#fi

###################################


#re=$(echo "$r" | grep ";;.*conta-cartas.*:.*")

#if [ -z "$re" ]
#then
#    echo "$r" > tmp.rkt
#else
#    echo "$re" > tmp.rkt
#fi

#r=$(echo "$r" | grep -i -m 1  -A 40 ";;")
#echo "$s"
echo "$s" > "$FILE2SAVE"

#pygmentize -l racket  tmp.rkt

#echo ""
#echo -e "${BLUE}************************************************************************************************${NC}"
#echo ""
#echo ""
