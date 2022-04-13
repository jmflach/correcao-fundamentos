#!/bin/bash

function check-ex-testes
{
  FNAME=$1
  check-have-n ";;.*\(${FNAME}.*\).*" 2 "EXEMPLOS"
  check-have-n ".*check-expect.*\(${FNAME}.*\).*" 2 "TESTES"
}

function check-contrato
{
  ATT='\e[1;30;45m'
  OK='\033[1;32m'
  NC='\033[0m'

  file="$QUESTION_FILE"
  FUNC_NAME="$1"
  IN="$2"
  OUT="$3"

  #r=$(grep -i -A 1000 "$BEGIN" $file | grep -i -m 1 -B 1000 "$END" | grep "$MIDDLE")

  #grep -i --color -E "$BEGIN" $file

  #espaco="[ :>-]*"
  #fim="${espaco}$"
  espaco="[ ]*"
  fim="${espaco}$"
  arrow="${espaco}[-|=]*>${espaco}"
  dots="${espaco}:${espaco}"

  RIGHT="$FUNC_NAME: $IN -> $OUT"
  STR="${FUNC_NAME}${dots}${IN}${arrow}${OUT}${fim}"

  #echo "Checando contrato da função $FUNC_NAME"

  r=$(grep -i -E "${STR}" $file)

  #cat $file
  #echo "$STR"
  #echo "$r"

  echo "$r" > tmp.rkt

  if [ -z "$r" ]
  then
      echo -e "${ATT}ERRO: Contrato "$FUNC_NAME"${NC}"
      echo -e "${ATT}Correto: "$RIGHT"${NC}"
  else
      echo -e "${OK}OK${NC}"
      echo -e "${OK}************************************************************************************************${NC}"
      pygmentize -l racket tmp.rkt
      echo -e "${OK}************************************************************************************************${NC}"
  fi
}

function check-have-n
{
  ATT='\e[1;30;45m'
  OK='\033[1;32m'
  NC='\033[0m'

  file="$QUESTION_FILE"
  HAVE="$1"
  QTDE=$2
  MSG=$3

  r=$(grep -i -E "$HAVE" $file | wc -l)

  #echo "$HAVE"
  #cat $file

  #echo "TEM $r de $HAVE"

  if [ $r -ge $QTDE ]
  then
      echo -e "${OK}TEM $r ${MSG} ${NC}"
  else
      echo -e "${ATT}NÃO TEM $QTDE ${MSG} TEM APENAS $r ${NC}"
  fi
}

function check-have
{
  ATT='\e[1;30;45m'
  OK='\033[1;32m'
  NC='\033[0m'

  file="$QUESTION_FILE"
  HAVE="$1"


  r=$(grep -i -E "$HAVE" $file)

  echo "$r" > tmp.rkt

  if [ -z "$r" ]
  then
      echo -e "${ATT}ERRO: Não tem "$HAVE"${NC}"
  else
      echo -e "${OK}TEM${NC}"
      echo -e "${OK}************************************************************************************************${NC}"
      pygmentize -l racket tmp.rkt
      echo -e "${OK}************************************************************************************************${NC}"
  fi
}
