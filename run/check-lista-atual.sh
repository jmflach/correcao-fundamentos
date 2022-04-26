#!/bin/bash

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname "$SCRIPT"`


source "$SCRIPTPATH"/check-question.sh

QUESTION="$1"
QUESTION_FILE="$2"


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
lds="(ListaDeStrings|ListaDeString|ListaNome|ListaDeNomes|ListaDeNome|ListaNomes)"


if [ $QUESTION = 1 ]
then
  # ;; soma15: Carta Mesa -> Carta
  #echo -en "CONSTANTES:\n"
  echo "ok"

  #check-have-n "\(define.*(make-pessoa.*))" 20 "Pessoas"

  #echo -en "DEF DADOS:\n"

  #check-have-n "\(define-struct pessoa \(nome ano olhos altura pai mãe\)" 1 "definição original"
  #check-have-n ";;.*\(make-pessoa .* .* .* .* .* .*\)" 1 "make-pessoa"
  #check-have-n ";;.*:${espaco}${string}" 2 "strings"
  #check-have-n ";;.*:${espaco}${numero}" 2 "numero"
  #check-have-n ";;.*:${espaco}${pessoa}" 2 "pessoa"
  #check-have-n ";;.*:${espaco}${numero}" 1 "def numero"
  #check-have-n ";;.*:${espaco}carta" 7 "def carta"
fi

#2:
# contrato q2
if [ $QUESTION = 2 ]
then
  # ;; soma15: Carta Mesa -> Carta

  check-contrato "altura-arvore-gen" "${pessoa}" "${numero}"
  check-ex-testes "altura-arvore-gen"
fi


# contrato q2
if [ $QUESTION = 3 ]
then
  #;; lista-ancentrais-olhos: Pessoa String -> ListaDeStrings
  check-contrato "lista-ancestrais-olhos" "${pessoa} ${string}" "${lds}"
  check-ex-testes "lista-ancestrais-olhos"
  #check-have-n ";;.*\(.*lista-ancestrais-olhos" 2 "a"
fi

#3:


if [ $QUESTION = 4 ]
then
  # ;; casal-mesmos-olhos?: Pessoa -> Booleano
  check-contrato "casal-mesmos-olhos\?" "${pessoa}" "${bool}"

  check-ex-testes "casal-mesmos-olhos\?"
fi

#4:
if [ $QUESTION = 5 ]
then
  # ;; casal-mesmos-olhos: Pessoa -> String

  check-contrato "casal-mesmos-olhos" "${pessoa}" "${string}"
  check-ex-testes "casal-mesmos-olhos"
  check-have-n "casal-mesmos-olhos\?" 1 "USOU A FUNÇÃO ANTERIOR"

fi

#5:

if [ $QUESTION = 6 ]
then
  # ;; é-abp?: ABP -> Booleano

  check-contrato "é-abp\?" "ABP" "${bool}"
  check-ex-testes "é-abp\?"
fi
