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

function show_question
{
  FILE=$1
  nome=$2
  n=$3

  clear

  #echo ""
  #echo -e "${RED}${nome}${NC}"
  #echo -e "\n"
  echo-middle "\\u2550" $WIDTH $RED " ${nome} "
  #echo -e "\n"
  echo ""

  # This script will store the question in a file called racket_question.rkt
  "$SCRIPTPATH"/show-racket-question.sh "$FILE" $QUESTION $UP "$QUESTION_FILE"
  pygmentize -f terminal16m -O style=friendly -l racket "$QUESTION_FILE"

  #echo -e "${HIGH}****************************************************************************************************************************************${NC}"
  echo-middle "\\u2550" $WIDTH $RED " ${nome} "

  # n é numero de chars
  # s não echo
  echo -en "${RED}"
  echo""
  status_bar $(( n+1 )) $max
  echo -en "${NC}"
  echo ""
  echo -e "${RED}                                            "$(( n+1 )) of $max" ${NC}"
  echo ""
  echo -e "${RED}                                      \\u25c0\\u2500 (z) \u2500\u2500\u2500\u2500 (x) \u2500\\u25b6 ${NC}"
  #echo ""
  #echo -e "${RED}${nome}${NC}"
}



function list-options
{
  echo -ne "${RED} (r) Run  ${NC}"
  echo -ne "${RED} (o) Open  ${NC}"
  echo -ne "${RED} (p) Open original  ${NC}"
  echo -ne "${RED} (t) Show tail original  ${NC}"
  echo -ne "${RED} (q) Quit ${NC}"
}

main() {
  CHANGED=1
  while [ $option != "q" ]
  do
      #echo ${files[$n]}
      filename=${files[$n]}
      filename="${filename%.*}"
      filename="${filename%-WithTests*}"

      nome="$(basename $filename)"
      imgfilename="$nome-Images.png"

      if [ $CHANGED -eq 1 ]; then

        show_question ${files[$n]} $nome $n

        CHANGED=0

        echo ""

        "$SCRIPTPATH"/check-lista-atual.sh "$QUESTION" "$QUESTION_FILE"

        echo ""

        list-options

        echo ""

      fi




      read -n 1 -s -r -p "" option

      # RUN CODE
      case $option in

      r)
        echo -e "${RED} Rodando o código... ${NC}"
        echo ""
        echo ${files[$n]}
        racket ${files[$n]}
        echo -e "${RED} Código Rodado ${NC}"
        #echo $imgfilename
        #xdg-open "$imgfilename"
        ;;

      o)
        drracket ${files[$n]} &
        ;;

      s)
        xdg-open "$imgfilename"
        ;;

      p)
        AUX=$( original-file $nome )
        echo $AUX
        xed $AUX
        ;;

      i)
        AUX=$( original-file $nome )
        echo $AUX

        drracket $AUX
        ;;

      t)
        AUX=$( original-file $nome )
        echo $AUX

        tail -n30 $AUX
        ;;


      x)
        n=$(( n+1 ))
        CHANGED=1
      ;;
      z)
        n=$(( n-1 ))
        CHANGED=1
      ;;
      g)
        echo -e "${RED} Ir para: ${NC}"
        read -r -p "" go
        n=$(( go-1 ))
        CHANGED=1
        ;;

      q)
        echo -e "\n\nBYE\n\n"
        ;;

      *)
        #echo -n "Comando desconhecido"
        ;;
    esac

    if [ 1 -eq 0 ]; then
      if [ $option = "r" ]
      then
          echo -e "${RED} Rodando o código... ${NC}"
          echo ""
          echo ${files[$n]}
          racket ${files[$n]}
          echo -e "${RED} Código Rodado ${NC}"
          #echo $imgfilename
          xdg-open "$imgfilename"
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
          drracket ${files[$n]} &
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

    fi
    #read -n 1 -s -r -p "" option
      if [ $n = $max ]
      then
  	     break       	  #Abandon the while loop.
      fi
      if [ $n = -1 ]
      then
  	     break       	  #Abandon the while loop.
      fi


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


  HALF=$(( ($WIDTH - $TOTAL) / 2 ))

  echo ""
  for counter in $( seq 1 $HALF ); do
    echo -ne " "
  done

  for counter in $( seq 1 $CURRENT ); do
    echo -ne \\u$FB
  done

  for counter in $( seq $CURRENT $(( TOTAL - 1 )) ); do
    echo -ne \\u2591
  done

  for counter in $( seq 1 $HALF ); do
    echo -ne " "
  done

}

main "$@"; exit
