#!/bin/bash

extension="${2##*.}"
testfilename="${2%.*}"
filename="${1%.*}"
newfilename="$filename-WithTests.rkt"
imgfilename="$(basename $filename)-Images.png"

racket_path='/usr/bin/racket'

$racket_path wxme-converter.rkt $1 > $newfilename

echo "Inserindo testes no arquivo $filename"

tvar="$testfilename.txt"
if [ "$extension" = "rkt" ] || [ "$extension" = "scm" ]; then
	$racket_path wxme-converter.rkt $2 > $tvar
else
	tvar=$2
fi

config=';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Incluído pelo script insertTests.sh ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require racket/base)
(require racket/struct)
(require test-engine/racket-tests)

;; Namespace para determinar se funções foram definidas:

(define-namespace-anchor a)
(define ns (namespace-anchor->namespace a))

;; Arquivo de imagens de saida:

(define $ARQUIVO '$imgfilename')

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
'

#sed -i "1 i $config " $newfilename
echo "$config" | cat - $newfilename > temp && mv temp $newfilename


rkt_config=';; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname b) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
'

first_line=$(head -1 $newfilename)
case $first_line in
  (*";; The first three lines of this file were inserted by DrRacket. They record metadata"*)
		echo "Aquivo RKT"
     ;;
  (*)
		echo "Arquivo not RKT"
		echo -e "$rkt_config" | cat - $newfilename > temp && mv temp $newfilename
esac

python3 struct-transparent.py $newfilename

#python3 remove-img-tests.py $newfilename

tests_str=';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;                                     XXX TESTES INSERIDOS XXX                                     ;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;'

echo "$tests_str" >> $newfilename

first_line=$(head -1 $tvar)
case $first_line in
  (*";; The first three lines of this file were inserted by DrRacket. They record metadata"*)
     sed '1,3d' $tvar >> $newfilename
     ;;
  (*)
     cat $tvar >> $newfilename
esac

echo "(test)" >> $newfilename

echo "Testes inseridos $filename"
