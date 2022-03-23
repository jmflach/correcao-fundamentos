#!/bin/bash

# Dado um diretório que contém os arquivos dos alunos em pastas, copia todos para o segundo diretorio
SUB_DIR=`realpath $1`
ORG_DIR="$SUB_DIR"/"envios-originais"
ENV_DIR="$SUB_DIR"/"envios"

# Copiar todas as pastas para uma outra pasta
rm -rf "$ORG_DIR"
mkdir "$ORG_DIR"

# Descompactar o arquivo do Moodle
unzip "$SUB_DIR"/*.zip -d "$SUB_DIR"/envios-originais

#cp *assignsubmission* envios
rm -rf "$ENV_DIR"
mkdir "$ENV_DIR"
#cd "envios-originais"

echo "$ORG_DIR"

for dir in "$ORG_DIR"/*;
do
    echo $dir
    cp "$dir"/* "$ENV_DIR"
done

find "$ENV_DIR" -name "* *" -type f | rename 's/ /_ESPACO_/g'


#./fix-files.sh
