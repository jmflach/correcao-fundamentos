#!/bin/bash

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname "$SCRIPT"`


source "$SCRIPTPATH"/check-question.sh

QUESTION=$1
QUESTION_FILE=$2


espaco="[ :>-]*"
fim="${espaco}$"
numero="(numero|número|number)"
simbolo="(simbolo|símbolo|symbol)"
bool="(booleano|bool|boolean|booleana)"
imagem="(image|imagem)"
string="string"
carta="carta${espaco}"
mesa="mesa${espaco}"
mao="(mão|mao)"
pessoa="pessoa"


if [ $QUESTION = 1 ]
then
  # ;; soma15: Carta Mesa -> Carta
  echo -e "\nCONSTANTES:\n"
  check-have-n "\(define.*(make-pessoa.*))" 20 "Pessoas"

  echo -e "\nDEF DADOS:\n"

  check-have-n ";;.*\(make-pessoa .* .* .* .* .* .*\)" 1 "make-pessoa"
  check-have-n ";;.*:${espaco}${string}" 2 "strings"
  check-have-n ";;.*:${espaco}${numero}" 2 "numero"
  check-have-n ";;.*:${espaco}${pessoa}" 2 "pessoa"
  #check-have-n ";;.*:${espaco}${numero}" 1 "def numero"
  #check-have-n ";;.*:${espaco}carta" 7 "def carta"
fi

#2:
# contrato q2
if [ $QUESTION = 2 ]
then
  # ;; soma15: Carta Mesa -> Carta

  check-contrato "soma15\?" "carta carta" "${bool}"
  check-have-n ";;.*\(soma15\?.*\).*" 2 "EXEMPLOS"
  check-have-n ".*check-expect.*\(soma15\?.*\).*" 2 "TESTES"
fi


# contrato q2
if [ $QUESTION = 3 ]
then
  # ;; soma15: Carta Mesa -> Carta
  check-contrato "soma15" "carta mesa" "carta"
  check-have-n "soma15\?" 4 "USOU A FUNÇÃO ANTERIOR"
  check-have-n ";;.*\(soma15.*\).*" 2 "EXEMPLOS"
  check-have-n ".*check-expect.*\(soma15.*\).*" 2 "TESTES"
fi

#3:


if [ $QUESTION = 4 ]
then
  # ;; escova?: Carta Mesa -> Booleano
  check-contrato "escova\?" "carta mesa" "${bool}"

  check-ex-testes "escova\?"
fi

#4:
if [ $QUESTION = 5 ]
then
  # ;; jogada-escova: Mão Mesa -> String

  check-contrato "jogada-escova" "mão mesa" "${string}"
  check-ex-testes "jogada-escova"
  check-have "escova\?"

fi

#5:

if [ $QUESTION = 6 ]
then
  # ;; seleciona-carta: Mão Mesa -> Jogada

  check-contrato "seleciona-carta" "mão mesa" "jogada"
  check-ex-testes "seleciona-carta"
fi
