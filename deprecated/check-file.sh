#!/bin/bash


# CORES
RED='\033[1;34m'
ATT='\033[1;31m'    
NC='\033[0m' # No Color


QUESTION=$1
QUESTION_FOLDER="q$1"

cd $QUESTION_FOLDER

#echo $QUESTION_FOLDER

clear

files=(*.rkt)

n=0
direction="x"
max="${#files[@]}"
UP=0
QUESTION_FILE="racket_question.rkt"

while [ $direction != "q" ]
do
    #echo ${files[$n]}
    filename=${files[$n]}
    filename="${filename%-WithTests.*}"
    imgfilename="$filename-Images.png"

    echo ""
    echo -e "${RED}************************************** CODE ****************************************************${NC}"
    echo -e "${RED}${files[$n]}${NC}"
    echo ""

    # This script will store the question in a file called racket_question.rkt
    #../show_racket_question.sh ${files[$n]} $QUESTION $UP "$QUESTION_FILE"
    ../show_everything.sh ${files[$n]} $QUESTION $UP "$QUESTION_FILE"

    #pygmentize -l racket "$QUESTION_FILE"

    echo ""
    echo -e "${RED}************************************************************************************************${NC}"
    echo ""

    espaco="[ :>-]*"
    fim="${espaco}$"
    numero="(numero|número|number)"
    ldc="listadecartas"

    #../check-question.sh "$QUESTION_FILE" "nao-deve-ter" "carta=?" "check-expect" "empty?" "empty na carta"

    ../check-question.sh "$QUESTION_FILE" "nao-deve-ter" "equal\?" "USOU EQUAL"

    #../check-question.sh "$QUESTION_FILE" "deve-ter" "insere-carta${espaco}${ldc}${espaco}carta${espaco}${numero}${espaco}${ldc}${fim}" "." "." "contrato insere-carta"

    #../check-question.sh "$QUESTION_FILE" "deve-ter" "embaralha${espaco}${ldc}${espaco}${ldc}${fim}" "." "." "contrato principal embaralha"


    echo ""
    # n é numero de chars
    # s não echo
    echo -e "${RED}                                            "$(( n+1 )) of $max" ${NC}"
    echo ""
    echo -e "${RED}${files[$n]}${NC}"
    echo ""
    echo -e "${RED}                                       <- (z) ---- (x) -> ${NC}"

    echo -e "${RED} Rodar? (r) ${NC}"
    echo ""
    #echo "$filename"
    #echo "$imgfilename"

    read -n 1 -s -r -p "" direction

    # RUN CODE
    if [ $direction = "r" ]
    then        
        echo -e "${RED} Rodando o código... ${NC}"
        echo ""
        racket ${files[$n]}
        echo -e "${RED} Código Rodado ${NC}"
        #xdg-open "$imgfilename"
        read -n 1 -s -r -p "" direction
    fi

    if [ $direction = "s" ]
    then        
        xdg-open "$imgfilename"
        read -n 1 -s -r -p "" direction
    fi
    
    # CHANGE CODE
    if [ $direction = "c" ]
    then
        echo -e "${RED} Change LIVRE (1) or COR (2) ${NC}"
        read -n 1 -s -r -p "" changes
        if [ $changes = "1" ]
        then    
            echo -e "${RED} Alterando o código LIVRE... ${NC}"
            echo ""
            sed -i 's/(define REAL_LIVRE LIVRE)/(define REAL_LIVRE LIVRE_AUX)/g' ${files[$n]}
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
        read -n 1 -s -r -p "" direction
    fi
    
    
    #if [ $direction = "s" ]
    #then        
    #    grep -n -A 8 ";; QUESTÃO 3:" ${files[$n]}
    #    read -n 1 -s -r -p "" direction
    #fi

    # OPEN FILE
    if [ $direction = "o" ]
    then
        drracket ${files[$n]}
        read -n 1 -s -r -p "" direction
    fi

    # SHOW CODE UP
    if [ $direction = "u" ]
    then
        UP=$(( UP+10 ))
    fi

    # GO RIGHT
    if [ $direction = "x" ]
    then
        n=$(( n+1 ))
        UP=0
    fi

    # GO LEFT
    if [ $direction = "z" ]
    then        
        n=$(( n-1 ))
        UP=0
    fi

    if [ $direction = "g" ]
    then
        echo -e "${RED} Ir para: ${NC}"       
        read -r -p "" go
        n=$(( go-1 ))
        UP=0
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
