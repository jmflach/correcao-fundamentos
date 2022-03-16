#!/bin/bash

extension="${2##*.}"
testfilename="${2%.*}"
filename="${1%.*}"
newfilename="$filename-WithTests.rkt"
imgfilename="$(basename $filename)-Images.png"

/usr/bin/racket wxme_converter.rkt $1 > $newfilename

echo "Inserindo testes no arquivo $filename"

tvar="$testfilename.txt"
if [ "$extension" = "rkt" ] || [ "$extension" = "scm" ]; then
	/usr/bin/racket wxme_converter.rkt $2 > $tvar
else
	tvar=$2
fi

r=$(grep -i ";; The first three lines of this file were inserted by DrRacket." $newfilename)

if [ -z $r ]
then
    echo "Arquivo NOT RACKETEADO"
    sed -i '1 i\
							\;; The first three lines of this file were inserted by DrRacket. They record metadata \
							\;; about the language level of this file in a form that our tools can easily process. \
							\#reader(lib "htdp-beginner-reader.ss" "lang")((modname b) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))\
             \
             ' $newfilename
fi

sed -i '4 i\
             \;; Arquivo de imagens de saida: \
            ' $newfilename
sed -i '5 i\
             \(define $ARQUIVO "'"$imgfilename"'") \
             \
            ' $newfilename


sed -i '4 i\
             \(require racket/base) \
             \(require racket/struct) \
             \(require test-engine/racket-tests) \
             \;; Namespace para determinar se funções foram definidas: \
             \(define-namespace-anchor a) \
             \(define ns (namespace-anchor->namespace a)) \
             \
             ' $newfilename

python3 struct-transparent.py $newfilename

#python3 remove-img-tests.py $newfilename

first_line=$(head -1 $tvar)
case $first_line in
  (*";; The first three lines of this file were inserted by DrRacket. They record metadata"*)
     sed '1,3d' $tvar >> $newfilename
     ;;
  (*)
     cat $tvar >> $newfilename
esac

echo "Testes inseridos $filename"
