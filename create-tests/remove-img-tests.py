import re
import sys

def main():
    filename = (sys.argv[1])

    with open(filename,'r', encoding='utf8') as file:
        string = file.read()

    # to count newlines
    #resultado = re.sub('(?s)(\(check-expect((?!check-expect)(?!;;).)*#\(struct:object:image% ... ...\)\))', r';; TESTE COM IMAGEM REMOVIDO', string)

    resultado = re.sub('(\(check-expect(.)*#\(struct:object:image% ... ...\)\))', r';; TESTE COM IMAGEM REMOVIDO', string)

    #print(resultado)
    with open(filename, "w") as file:
        file.write(resultado)

if __name__ == "__main__":
    main()
