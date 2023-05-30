from Compiler.Lex_Analysis import Lexer
from Compiler.Syn_Analysis import Parser
from Compiler.Interim_Date import IntermidateCodeGeneration
from Compiler.Optimization_Date import CodeOptimization
from Compiler.Generation_Code import CodeGeneration

"""
o = nasm -f elf64 output.asm
man ld
ld -m elf_x86_64 -s -o output output.o
./output
"""
counter = 0


while True:
    counter += 1
    f = open("input.txt", 'r')
    a = f.read()

    try:
        arr = Lexer(a).get_tokens();
        print('-----------------Tokens-----------------')
        print('Type/Lexeme\n')
        print(arr)
        with open(f"lexer_{counter}.txt", "w") as f:
            f.write("Lexical Analyzer:\n")
            f.write("-----------------Tokens-----------------\n")
            f.write('Type/Lexeme\n\n')
            f.write(str(arr) + "\n")

        tree = Parser(arr).get_root();
        print("-" * 50)
        print('AST:\n')
        print(tree)
        print("-" * 50)
        with open(f"Parser_{counter}.txt", "w") as f:
            f.write(f"\nParser:\n---------------\n")
            f.write("AST:\n\n")
            f.write(str(tree) + "\n")

        code, identifiers, constants = IntermidateCodeGeneration(tree).get_code();

        code, identifiers, constants, tempmap = CodeOptimization(code, identifiers, constants).get_code();
        print("-" * 50)
        print('Code Optimization:\n')
        print(identifiers)
        print(constants)
        code.print_extra()
        print("-"*50)



        print("-"*50)
        print(f"[{counter}] : ", end="\n\n")
        CodeGeneration(code, identifiers, constants, tempmap)
        print("-"*50)

    except Exception as e:
        print(e)

    f.close()
    input()
