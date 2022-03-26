# correcao-fundamentos

Esse projeto tem a finalidade de ajudar na correção das listas de exercícios da disciplina de Fundamentos de Algoritmos da UFRGS.

# Uso

A princípio, funciona em sistemas linux. Havia algumas funcionalidades que não funcionavam no mac, mas está sendo arrumado. Se encontrar algum erro, envie um e-mail para jmflach@inf.ufrgs.br.

Importante: altere o caminho para o racket no script create-tests/insertTests.sh se necessário.

Existem 3 pastas:

## create-tests

Scripts utilizados para inserir os testes nos arquivos baixados do Moodle.


## run

Scripts utilizados para rodar os programas diretamente no terminal. Use somente se souber o que está fazendo.


## deprecated

Scripts antigos guardados para referência.

# Como corrigir

1 - Criar uma pasta em seu computador, chamada "correcao-listaX"

2 - Clone ou baixe este projeto para dentro da pasta criada.

3 - Execute o comando

```
./correcao-fundamentos/correcao.sh --init .
```

"Serão criadas 3 pastas: submissoes, testes e gabarito

4 - Coloque todos os arquivos que achar pertinente (pdf da lista, resolução, template, testes a serem inseridos) na pasta gabarito

5 - Baixe os envios do Moodle, em um arquivo zip. Copie para a pasta submissoes.

6 - Rode o script

```
./correcao-fundamentos/correcao.sh --organize-files ./submissoes
```

Esse script espera que o zip com as submissões já esteja na pasta submissoes. Ele irá desempacotar as submissões do zip para a pasta `envios-originais`, bem como organizá-las em uma única pasta `envios`.

<!---Obs.: o script que faz a organização dos arquivos (correcao-fundamentos/organize-files/organize-files.sh) chama outro script (correcao-fundamentos/organize-files/fix-files.sh) que arruma alguns arquivos que eventualmente podem ter problemas, como: arquivo sem extensão, arquivo que outros scripts não conseguem ler (formatação diferente de UTF-8), etc. Porém essa tarefa é manual e, para cada arquivo que apresentar problema, deve-se adicionar neste script comandos para resolver.--->

Obs: Este script também verifica arquivos que contém espaço no nome e substitui cada espaço pela string "\_ESPACO\_" para ficar mais fácil detectar esses erros.

7 - Agora vamos inserir os testes nos arquivos dos alunos. Neste passo, para cada submissão da pasta `envio`, serão adicionados os testes que estarão em outro arquivo separado, que deverá ser obtido com o professor responsável pela lista. Rode o script:

```
./correcao-fundamentos/correcao.sh --create-tests <test-file> submissoes/envios <gabarito>
```

É necessário passar o gabarito também como parâmetro, para que os testes sejam inseridos no gabarito também. É melhor assertar que todos os testes passam sem erros no gabarito.







# Colaboradores

* Leila Ribeiro
* João Marcos Flach
