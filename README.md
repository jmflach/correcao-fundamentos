# correcao-fundamentos

Esse projeto tem a finalidade de ajudar na correção das listas de exercícios da disciplina de Fundamentos de Algoritmos da UFRGS.

# Pré-requisitos

* Sistema operacional UNIX (linux ou mac). Havia algumas funcionalidades que não funcionavam no mac, mas estamos arrumando para que funcione em ambas as plataformas. Se encontrar algum erro, envie um e-mail para jmflach@inf.ufrgs.br.

* Ter o `racket` instalado na máquina. Às vezes a versão disponível no respositório oficial das distros do linux é uma versão antiga. Você pode baixar a versão mais atualizada em https://download.racket-lang.org/

* Ter o `python` instalado na máquina, juntamente com o pacote de expressões regulares `re`.

* Alterar o caminho do `racket` no script `create-tests/insertTests.sh`, se necessário. Para saber o caminho na sua máquina, pode usar o comando `whereis racket` no terminal.

<!---# Uso



Existem 3 pastas:

## create-tests

Scripts utilizados para inserir os testes nos arquivos baixados do Moodle.


## run

Scripts utilizados para rodar os programas diretamente no terminal. Use somente se souber o que está fazendo.


## deprecated

Scripts antigos guardados para referência.--->

# Como corrigir

1 - Criar uma pasta nova em sua máquina para a correção da lista (`correcao-listaX`).

2 - Clone ou baixe este projeto para dentro da pasta criada (se baixar em zip, descompacte).

3 - Dentro da pasta criada (`correcao-listaX`), execute o comando

```
./correcao-fundamentos/correcao.sh --init .
```

"Serão criadas 3 pastas dentro de `correcao-listaX`: `submissoes`, `testes` e `gabarito`.

4 - Coloque todos os arquivos que achar pertinente (pdf da lista, resolução, template, testes a serem inseridos) na pasta `gabarito`

5 - Baixe os envios do Moodle, em um arquivo zip. Copie para a pasta `submissoes`.

6 - Rode o script

```
./correcao-fundamentos/correcao.sh --organize-files ./submissoes
```

Esse script espera que o zip com as submissões já esteja na pasta `submissoes`. Ele irá desempacotar as submissões do zip para a pasta `envios-originais`, bem como organizá-las em uma única pasta `envios`.

<!---Obs.: o script que faz a organização dos arquivos (correcao-fundamentos/organize-files/organize-files.sh) chama outro script (correcao-fundamentos/organize-files/fix-files.sh) que arruma alguns arquivos que eventualmente podem ter problemas, como: arquivo sem extensão, arquivo que outros scripts não conseguem ler (formatação diferente de UTF-8), etc. Porém essa tarefa é manual e, para cada arquivo que apresentar problema, deve-se adicionar neste script comandos para resolver.--->

Obs: Este script também verifica arquivos que contém espaço no nome e substitui cada espaço pela string "\_ESPACO\_" para ficar mais fácil detectar esses erros.

Neste momento você pode fazer a correção dos nomes dos arquivos.

7 - Agora vamos inserir os testes nos arquivos dos alunos. Neste passo, para cada submissão da pasta `envio`, serão adicionados os testes que estarão em outro arquivo separado, que deverá ser obtido com o professor responsável pela lista. Rode o script:

```
./correcao-fundamentos/correcao.sh --create-tests <test-file> submissoes/envios <gabarito>
```

É necessário passar o arquivo de gabarito também como parâmetro, para que os testes sejam inseridos no gabarito também. Deve-se sempre assertar que todos os testes passam sem erros no gabarito.

Ao rodar este comando, algum arquivo pode não ser lido corretamente pelo script, pois está com uma codificação diferente de UTF-8. Caso isso aconteça, você deverá identificar o arquivo e mudar usa codificação para UTF-8 e rodar novamente o comando. No linux, pode-se usar o comando `iconv` para converter as codificações.



Importante: Sempre que houver alguma dúvida no programa do aluno, cheque a versão original, na pasta `envios-originais`, pois pode ser que o nosso script tenha modificado alguma coisa (nunca aconteceu, mas é melhor sempre conferir no original). Caso isso tenha acontecido, por favor, comunique imediatamente o professor responsável, para que possamos resolver o problema.




# Colaboradores

* Leila Ribeiro
* João Marcos Flach
