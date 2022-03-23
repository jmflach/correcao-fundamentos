#!/bin/bash

# Dado um diretório que contém os arquivos dos alunos em pastas, copia todos para o segundo diretorio

# Copiar todas as pastas para uma outra pasta
rm -rf "envios-originais"
mkdir "envios-originais"

# Descompactar o arquivo do Moodle
unzip AGL06* -d ./envios-originais

#cp *assignsubmission* envios
rm -rf "envios"
mkdir "envios"
cd "envios-originais"

for dir in *;
do
    echo $dir
    cd "$dir"
    cp * ../../envios/
    #echo $PWD
    cd ..
done

cd ..

echo $PWD

cd envios
echo $PWD
find . -name "* *" -type f | rename 's/ /_/g'

cd ..

./fix_files.sh
