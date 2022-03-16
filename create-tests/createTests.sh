#!/bin/bash

# arguments:
# $1 = name of the file where the tests are
# $2 = name of the folder where files will be stored
# $3 = folder where the original files are
# $4 = file that contains the correct answers

test_file=`realpath $1`
folder=`realpath $2`
original_files=`realpath $3`
gabarito=`realpath $4`
SCRIPT=`realpath $0`
SCRIPTPATH=`dirname "$SCRIPT"`


rm -r $folder
mkdir $folder

echo $SCRIPT
echo $SCRIPTPATH

cd $SCRIPTPATH

echo "Criando testes para gabarito"
./insertTests.sh "$gabarito" "$test_file"
mv "${gabarito%%.*}"*WithTests* $folder/aaa-gabarito-aaa.rkt

for file in $original_files/*;
do
    echo "Criando testes para $file"
    ./insertTests.sh "$file" "$test_file"
done


for file in $original_files/*WithTests*;
do
    mv $file $folder
done
