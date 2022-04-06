#!/bin/bash


# CORES
HIGH='\e[1;37;46m'
RED='\033[1;34m'
ATT='\033[1;31m'
NC='\033[0m' # No Color

TEXT_EDITOR=xed

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname "$SCRIPT"`

QUESTION=$1
QUESTION_FOLDER="$2"

WIDTH=100

#cd $QUESTION_FOLDER

#echo $QUESTION_FOLDER

clear

files=("$QUESTION_FOLDER"/*.rkt)

n=0
option="x"
max="${#files[@]}"
UP=0
QUESTION_FILE="racket_question.rkt"

main() {
  while [ $option != "q" ]
  do
      #echo ${files[$n]}
      filename=${files[$n]}
      filename="${filename%.*}"
      filename="${filename%-WithTests*}"

      nome="$(basename $filename)"
      imgfilename="$nome-Images.png"

      echo ""
      echo -e "${RED}${nome}${NC}"
      echo -e "\n"
      echo-middle "\\u2550" $WIDTH $RED " CODE "
      echo -e "\n"
      echo ""

      # This script will store the question in a file called racket_question.rkt
      "$SCRIPTPATH"/show-racket-question.sh ${files[$n]} $QUESTION $UP "$QUESTION_FILE"
      pygmentize -f terminal16m -O style=friendly -l racket "$QUESTION_FILE"

      echo -e "\n"
      #echo -e "${HIGH}****************************************************************************************************************************************${NC}"
      echo-n "\\u2550" $WIDTH $RED
      echo -e "\n"

      espaco="[ :>-]*"
      fim="${espaco}$"
      numero="(numero|número|number)"
      simbolo="(simbolo|símbolo|symbol)"
      bool="(booleano|bool|boolean)"
      imagem="(image|imagem)"
      string="string"

      # CONTRATOS:

      carta="carta${espaco}"
      mesa="mesa${espaco}"

      if [ $QUESTION = 1 ]
      then
        # ;; soma15: Carta Mesa -> Carta
        echo -e "\nCONSTANTES:\n"
        check-have-n "define.*make-carta" 4 "carta"
        check-have-n "define.*make-mão" 4 "mão"
        check-have-n "define.*make-mesa" 4 "mesa"
        check-have-n ".*define.*CARTA-NULA.*make-carta" 1 "CARTA-NULA"

        echo -e "\nDEF DADOS:\n"
        check-have-n ";;.*:${espaco}${string}" 1 "def string"
        check-have-n ";;.*:${espaco}${numero}" 1 "def numero"
        check-have-n ";;.*:${espaco}carta" 7 "def carta"


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
        # ;; soma-mesa: Mesa -> Número
        check-contrato "soma-mesa" "mesa" "${numero}"

        # ;; escova?: Carta Mesa -> Booleano
        check-contrato "escova\?" "carta mesa" "${bool}"

      fi

      #4:
      if [ $QUESTION = 4 ]
      then
        # ;; jogada-escova: Mão Mesa -> String

        check-contrato "jogada-escova" "mão mesa" "${string}"

        check-have "escova\?"

      fi

      #5:

      if [ $QUESTION = 5 ]
      then
        # ;; seleciona-carta: Mão Mesa -> Jogada

        check-contrato "seleciona-carta" "mão mesa" "jogada"
        check-have-all-file ${files[$n]} "seleciona-carta"
      fi


      #6:

      if [ $QUESTION = 6 ]
      then
        # ;; mostra-jogada: Mão Mesa -> Imagem

        check-contrato "mostra-jogada" "mão mesa" "${imagem}"
        #check-have-all-file ${files[$n]} "mostra-jogada"
      fi


      echo ""
      # n é numero de chars
      # s não echo
      echo -en "${RED}"
      status_bar $(( n+1 )) $max
      echo -en "${NC}"
      echo ""
      echo -e "${RED}                                            "$(( n+1 )) of $max" ${NC}"
      echo ""
      echo -e "${RED}                                      \\u25c0\\u2500 (z) \u2500\u2500\u2500\u2500 (x) \u2500\\u25b6 ${NC}"
      echo ""
      echo -e "${RED}${nome}${NC}"




      echo -e "${RED} Rodar? (r) ${NC}"
      echo ""
      #echo "$filename"
      #echo "$imgfilename"

      read -n 1 -s -r -p "" option

      # RUN CODE
      if [ $option = "r" ]
      then
          echo -e "${RED} Rodando o código... ${NC}"
          echo ""
          echo ${files[$n]}
          racket ${files[$n]}
          echo -e "${RED} Código Rodado ${NC}"
          #echo $imgfilename
          #xdg-open "$imgfilename"
          read -n 1 -s -r -p "" option
      fi

      if [ $option = "s" ]
      then
          xdg-open "$imgfilename"
          read -n 1 -s -r -p "" option
      fi

      # CHANGE CODE

      if [ $option = "c" ]
      then
          echo -e "${RED} ADD NULA (1) or COR (2) ${NC}"
          read -n 1 -s -r -p "" changes
          if [ $changes = "1" ]
          then
              echo -e "${RED} Inserindo CARTA-NULA... ${NC}"
              echo ""
              sed -i 's/;; (define CARTA-NULA/(define CARTA-NULA/g' ${files[$n]}
          fi
          if [ $changes = "2" ]
          then
              echo -e "${RED} Alterando o código COR... ${NC}"
              echo ""
              sed -i 's/(define cor_azul "azul")/(define cor_azul "blue")/g' ${files[$n]}
              sed -i 's/(define cor_verm "vermelho")/(define cor_verm "red")/g' ${files[$n]}
              sed -i 's/(define cor_verd "verde")/(define cor_verd "green")/g' ${files[$n]}
              sed -i 's/(define cor_amar "amarelo")/(define cor_amar "yellow")/g' ${files[$n]}
              sed -i 's/(define cor_pret "preto")/(define cor_pret "black")/g' ${files[$n]}
              sed -i 's/(define cor_bran "branco")/(define cor_bran "white")/g' ${files[$n]}
          fi
          read -n 1 -s -r -p "" option
      fi


      #if [ $direction = "s" ]
      #then
      #    grep -n -A 8 ";; QUESTÃO 3:" ${files[$n]}
      #    read -n 1 -s -r -p "" direction
      #fi

      # OPEN FILE
      if [ $option = "o" ]
      then
          drracket ${files[$n]}
          read -n 1 -s -r -p "" option
      fi

      # OPEN THE PRIME (ORIGINAL) FILE
      if [ $option = "p" ]
      then
          AUX=$( original-file $nome )
          echo $AUX

          xed $AUX
          read -n 1 -s -r -p "" option
      fi

      # OPEN THE PRIME (ORIGINAL) FILE IN RACKET
      if [ $option = "i" ]
      then
          AUX=$( original-file $nome )
          echo $AUX

          drracket $AUX
          read -n 1 -s -r -p "" option
      fi

      if [ $option = "t" ]
      then
          AUX=$( original-file $nome )
          echo $AUX

          tail -n30 $AUX
          read -n 1 -s -r -p "" option
      fi

      # SHOW CODE UP
      if [ $option = "u" ]
      then
          UP=$(( UP+10 ))
      fi

      # GO RIGHT
      if [ $option = "x" ]
      then
          n=$(( n+1 ))
          UP=0
      fi

      # GO LEFT
      if [ $option = "z" ]
      then
          n=$(( n-1 ))
          UP=0
      fi

      if [ $option = "g" ]
      then
          echo -e "${RED} Ir para: ${NC}"
          read -r -p "" go
          n=$(( go-1 ))
          UP=0
      fi


      if [ $n = $max ]
      then
  	  break       	  #Abandon the while loop.
      fi
      if [ $n = -1 ]
      then
  	  break       	  #Abandon the while loop.
      fi

      clear
  done
}



function echo-middle
{
  CHAR=$1
  N=$2
  COR=$3
  STR=$4

  SIZE=`expr length "$STR"`

  HALF=$(( ($N - $SIZE) / 2 ))

  for counter in $( seq 1 $HALF ); do
    echo -ne "${COR}$CHAR${NC}"
  done

  echo -ne "${COR}$STR${NC}"

  for counter in $( seq 1 $HALF ); do
    echo -ne "${COR}$CHAR${NC}"
  done
}

function echo-n
{
  CHAR=$1
  N=$2
  COR=$3

  for counter in $( seq 1 $N ); do
    echo -ne "${COR}$CHAR${NC}"
  done
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

  r=$(grep -i -E "$STR" $file)

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

function check-have-all-file
{
  ATT='\e[1;30;45m'
  OK='\033[1;32m'
  NC='\033[0m'

  file=$1
  HAVE="$2"

  echo "olhando em " $file
  echo "have " $HAVE

  r=$(grep -i -E -B 1000 "XXX TESTES INSERIDOS XXX" $file)

  echo "$r" > tmp.rkt

  r=$(grep -i -E "$HAVE" tmp.rkt)

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

function original-file
{
  nome=$1

  ORIGINAL_PATH=`realpath "$SCRIPTPATH/../../submissoes/envios"`
  ORIGINAL_FILE=$( echo ${nome} | sed 's/-WithTests.rkt//g' )
  #echo $ORIGINAL_PATH/$ORIGINAL_FILE
  AUX=$( find $ORIGINAL_PATH -name "${ORIGINAL_FILE}*" )

  echo "$AUX"
}

function status_bar
{
  #statements
  CURRENT=$1
  TOTAL=$2
  FB=2588

  echo ""
  echo -n "                               "

  for counter in $( seq 1 $CURRENT ); do
    echo -ne \\u$FB
  done

  for counter in $( seq $CURRENT $(( TOTAL - 1 )) ); do
    echo -ne \\u2591
  done

  echo ""
}

main "$@"; exit
