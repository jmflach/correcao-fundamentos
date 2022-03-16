extension="${2##*.}"
testfilename="${2%.*}"
filename="${1%.*}"
newfilename="$filename-WithTests.rkt"
imgfilename="$(basename $filename)-Images.png"
/Applications/Racket\ v7.6/bin/racket  wxme_converter.rkt $1 > $newfilename

tvar="$testfilename.txt"
if [ "$extension" = "rkt" ] || [ "$extension" = "scm" ]; then
	/Applications/Racket\ v7.6/bin/racket wxme_converter.rkt $2 > $tvar
else
	tvar=$2
fi
sed -i "" '4 i\
             \;; Arquivo de imagens de saida: \ 
            ' $newfilename
sed -i "" '5 i\
             \(define $ARQUIVO "'"$imgfilename"'") \
             \ 
            ' $newfilename


sed -i "" '4 i\
             \(require racket/base) \
             \(require test-engine/racket-tests) \
             \;; Namespace para determinar se funções foram definidas: \
             \(define-namespace-anchor a) \
             \(define ns (namespace-anchor->namespace a)) \
             \ 
             ' $newfilename


first_line=$(head -1 $tvar)
case $first_line in
  (*";; The first three lines of this file were inserted by DrRacket. They record metadata"*)
     sed '1,3d' $tvar >> $newfilename
     ;;  
  (*)
     cat $tvar >> $newfilename
esac

