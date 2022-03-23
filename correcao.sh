#!/bin/bash

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname "$SCRIPT"`

PARAMS=""

INIT=false
ORG=false

while (( "$#" )); do
  case "$1" in
    --init)
      if [ -n "$2" ] && [ ${2:0:1} != "-" ]; then
        INIT_DIR=`realpath $2`
        shift 2
      else
        echo "Erro: Estão faltando os argumentos para $1" >&2
        exit 1
      fi
      INIT=true
      shift
      ;;
    --organize-files)
      if [ -n "$2" ] && [ ${2:0:1} != "-" ]; then
        SUB_DIR=`realpath $2`
        shift 2
      else
        echo "Erro: Estão faltando os argumentos para $1" >&2
        exit 1
      fi
      ORG=true
      ;;
    --create-tests)
      if [ -n "$2" ] && [ ${2:0:1} != "-" ]; then
        MY_FLAG_ARG=$2
        shift 2
      else
        echo "Erro: Estão faltando os argumentos para $1" >&2
        exit 1
      fi
      ;;
    --run)
      if [ -n "$2" ] && [ ${2:0:1} != "-" ]; then
        MY_FLAG_ARG=$2
        shift 2
      else
        echo "Erro: Estão faltando os argumentos para $1" >&2
        exit 1
      fi
      ;;
    -*|--*=) # unsupported flags
      echo "Erro: Comando não suportado: $1" >&2
      exit 1
      ;;
    *) # preserve positional arguments
      PARAMS="$PARAMS $1"
      shift
      ;;
  esac
done

# set positional arguments in their proper place
eval set -- "$PARAMS"


if [ "$INIT" = true ]; then
  echo "Iniciando correcao em $INIT_DIR"
  mkdir "$INIT_DIR"/"submissoes"
  mkdir "$INIT_DIR"/"testes"
  mkdir "$INIT_DIR"/"gabarito"
fi;

if [ "$ORG" = true ]; then
  echo "$SCRIPTPATH"
  ls
  echo "Organizando arquivos $SUB_DIR"
  "$SCRIPTPATH"/organize-files/organize-files.sh $SUB_DIR
fi;
