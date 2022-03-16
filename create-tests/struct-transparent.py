import re
import sys

def main():
    filename = (sys.argv[1])
    
    with open(filename,'r', encoding='utf8') as file:
        string = file.read()

    resultado = re.sub(r'(?s)(define-struct .*?\))', r'\1 #:transparent', string)

    with open(filename, "w") as file:
        file.write(resultado)

if __name__ == "__main__":
    main()
