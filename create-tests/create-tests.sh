#!/bin/bash

# arguments:
# $1 = name of the file where the tests are
# $2 = name of the folder where files will be stored
# $3 = folder where the original files are
# $4 = file that contains the correct answers

test_file=`realpath $1`
#folder=`realpath $2`
original_files=`realpath $2`
gabarito=`realpath $3`
SCRIPT=`realpath $0`
SCRIPTPATH=`dirname "$SCRIPT"`
TMP="$original_files/../tmp"

filename=$( basename $1 )
folder=`realpath "$SCRIPTPATH"/../../testes/"${filename%.*}"`

echo "$folder"

rm -rf $folder
mkdir $folder

rm -rf $TMP
cp -r "$original_files" "$TMP"

echo $SCRIPT
echo $SCRIPTPATH


echo "Criando testes para gabarito"
"$SCRIPTPATH"/insert-tests.sh "$gabarito" "$test_file"
mv "${gabarito%%.*}"*WithTests* $folder/aaa-gabarito-aaa.rkt

for file in $TMP/*;
do
    nome="$(basename $file)"
    echo "Criando testes para $nome"
    "$SCRIPTPATH"/insert-tests.sh "$file" "$test_file"
done


for file in $TMP/*WithTests*;
do
    mv $file $folder
done
