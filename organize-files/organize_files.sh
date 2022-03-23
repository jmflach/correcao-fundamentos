#!/bin/bash

# Dado um diretório que contém os arquivos dos alunos em pastas, copia todos para o segundo diretorio
SUB_DIR=`realpath $1`

echo "****************************************"
echo "$SUB_DIR"

# Copiar todas as pastas para uma outra pasta
rm -rf "$SUB_DIR"/"envios-originais"
mkdir "$SUB_DIR"/"envios-originais"

# Descompactar o arquivo do Moodle
unzip "$SUB_DIR"/AGL06* -d "$SUB_DIR"/envios-originais

#cp *assignsubmission* envios
rm -rf "$SUB_DIR"/"envios"
mkdir "$SUB_DIR"/"envios"
#cd "envios-originais"

for dir in "$SUB_DIR"/envios_originais/*;
do
    echo $dir
    cd "$dir"
    cp * "$SUB_DIR"/"envios"
    #echo $PWD
    cd ..
done

echo $PWD

echo $PWD
find "$SUB_DIR"/"envios" -name "* *" -type f | rename 's/ /_/g'


./fix-files.sh
