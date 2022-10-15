.data
vetor: .word 0 9 9 3 4 2 0 6 6 4 1
magicNumbers: .word 6 5 4 3 2 9 8 7 6 5 4 3 2
.text
main:
la x12, vetor       # atribui o endereço do inicio do vetor a x12
addi x13, x0, 11    # atribui x13 = num de elementos no vetor
addi x14, x0, 0     # atribui x14 = 0 se for cpf, x14 = 1 se for cnpj
jal x1, verificadastro  # chama a função verifica cadastro e x1 = PC + 4
beq x0, x0, FIM       # chama a função FIM

temTodosDigitosIguais:
    lw x30, 0(x28)          # x30 = vetor[i]
    bne x30, x5, diferente  # se vetor[i] != vetor[0], existem digitos diferentes
    addi x28, x28, 4        # incrementa o i em 4, para acessar a próxima posição do vetor
    blt x28, x29, temTodosDigitosIguais  # se &vetor[i] < &vetor[11]

    addi x6, x0, 1  # x6 = 1
    jalr x0, 0(x1)  # retorna a função

    diferente:
        addi x6, x0, 0  # x6 = 0
        jalr x0, 0(x1)  # retorna a função

loop1:
    lw x30, 0(x28) # x30 = vetor[i]
    mul x6, x30, x7 # x6 = vetor[i] * j
    add x5, x5, x6 # x5 = resultado + multiplicacao (vetor[i] * j)
    addi x7, x7, -1 # decrementa o valor de j, j--
    addi x28, x28, 4  # incrementa o i em 4, para acessar a próxima posição do vetor
    blt x28, x29, loop1   # se endereço de x28 menor que de x29 chama a função loop1

    addi x6, x0, 11     # armazena x6 = 11
    rem x5, x5, x6      # armazena x5 = x5 % 11

    jalr x0, 0(x1)      # retorna a função

verificacpf:
    addi sp, sp, -4     # aumenta o espaço na pilha para mais 1 palavra
    sw x1, 0(sp)        # armazena o endereço de retorno na pilha

    # verificacao do primeiro digito
    addi x5, x0, 0  # temporario x5 armazena o resultado
    addi x6, x0, 0  # temporario x6 armazena a multiplicacao
    addi x7, x0, 10 # temporario x7 armazena j = 10
    add x28, x12, x28 # x28 armazena endereço inicial do vetor
    addi x29, x0, 9 # temporario x29 armazena limite do loop = 9
    slli x29, x29, 2 # temporario x29 multiplicado por 4
    add x29, x12, x29 # x29 armazena o endereço do 9 elemento do vetor

    jal x1, loop1   # chama a função loop1

    lw x30, 0(x28)  # x30 = vetor[9]
    addi x6, x0, 2  # x6 = 2
    bge x5, x6, Else1   # se x5 >= 2, Else1
    bne x30, x0, invalido # se vetor[9] != 0, chama função invalido
    beq x0, x0, continua1
    Else1:
    addi x6, x0, 11  # x6 = 11
    sub x5, x6, x5   # x5 = 11 - resultado
    bne x30, x5, invalido # se vetor[12] != 11 - resultado, chama função invalido
    continua1:


    # verificacao do segundo digito
    addi x5, x0, 0  # temporario x5 armazena o resultado
    addi x6, x0, 0  # temporario x6 armazena a multiplicacao
    addi x7, x0, 11 # temporario x7 armazena j = 11
    addi x28, x12, 0 # x28 armazena endereço inicial do vetor
    addi x29, x0, 10 # temporario x29 armazena limite do loop = 10
    slli x29, x29, 2 # temporario x29 multiplicado por 4
    add x29, x12, x29 # x29 armazena o endereço do 10 elemento do vetor

    jal x1, loop1 # chama a função loop1

    lw x30, 0(x28)  # x30 = vetor[9]
    addi x6, x0, 2  # x6 = 2
    bge x5, x6, Else2   # se x5 >= 2, Else2
    bne x30, x0, invalido # se vetor[12] != 0, chama função invalido
    beq x0, x0, continua2
    Else2:
    addi x6, x0, 11  # x6 = 11
    sub x5, x6, x5   # x5 = 11 - resultado
    bne x30, x5, invalido # se vetor[12] != 11 - resultado, chama função invalido
    continua2:

    # verificar se todos os números do cpf são repetidos
    addi x28, x12, 0    # x28 = *vetor[0]
    addi x29, x13, -1   # x29 = 10
    slli x29, x29, 2    # x29 = 10 * 4
    add x29, x12, x29   # x29 = *vetor[10]
    lw x5, 0(x28)       # x5 = vetor[0]
    addi x28, x12, 4    # x28 = *vetor[1]

    jal x1, temTodosDigitosIguais   # caso cpf tenha todos os digitos repetidos, x6 = 1, caso contrário, x6 = 0

    addi x5, x0, 1          # x5 = 1
    beq x6, x5, invalido    # se x6 == 1, chama a função invalido

    addi x10, x0, 1     # o cpf é válido, portanto, atribui x10 = 1

    lw x1, 0(sp)        # x1 = endereço do topo da pilha
    addi sp, sp, 4      # desaloca 1 palavra do topo da pilha

    jalr x0, 0(x1)      # retorna a função

loop2:
    lw x30, 0(x28)  # x30 = vetor[i]
    lw x6, 0(x7)    # x6 = magicNumbers[j]
    mul x6, x30, x6 # x6 = vetor[i] * magiNumbers[j]
    add x5, x5, x6 # x5 = resultado + vetor[i] * magiNumbers[j]
    addi x28, x28, 4 # x28 = *vetor[i+1]
    addi x7, x7, 4  # x7 = *magicNumbers[j+1]

    blt x28, x29, loop2   # se endereço de x28 menor que de x29 chama a função loop2

    addi x6, x0, 11     # x6 = 11
    rem x5, x5, x6      # x5 = x5 % 11

    jalr x0, 0(x1)

verificacnpj: 
    addi sp, sp, -4     # aumenta o espaço na pilha para mais 1 palavra
    sw x1, 0(sp)        # armazena o endereço de retorno na pilha

    la x31, magicNumbers # x31 = inicio magicNumbers

    # verificacao do primeiro digito
    addi x5, x0, 0  # temporario x5 armazena o resultado
    addi x6, x0, 0  # temporario x6 armazena a multiplicacao
    addi x7, x31, 4 # temporario x7 magicNumbers[1]
    addi x28, x12, 0 # x28 armazena endereço inicial do vetor
    addi x29, x0, 12 # temporario x29 armazena limite do loop = 12
    slli x29, x29, 2 # temporario x29 multiplicado por 4
    add x29, x12, x29 # x29 armazena o endereço do 12 elemento do vetor

    jal x1, loop2   # chama a função loop2

    lw x30, 0(x28)  # x30 = vetor[12]
    addi x6, x0, 2  # x6 = 2
    bge x5, x6, Else3   # se x5 >= 2, Else3
    bne x30, x0, invalido # se vetor[12] != 0, chama função invalido
    beq x0, x0, continua3
    Else3:
    addi x6, x0, 11  # x6 = 11
    sub x5, x6, x5   # x5 = 11 - resultado
    bne x30, x5, invalido # se vetor[12] != 11 - resultado, chama função invalido
    continua3:

    # verificacao do segundo digito
    addi x5, x0, 0  # temporario x5 armazena o resultado
    addi x6, x0, 0  # temporario x6 armazena a multiplicacao
    addi x7, x31, 0 # temporario x7 magicNumbers[0]
    addi x28, x12, 0 # x28 armazena endereço inicial do vetor
    addi x29, x0, 13 # temporario x29 armazena limite do loop = 13
    slli x29, x29, 2 # temporario x29 multiplicado por 4
    add x29, x12, x29 # x29 armazena o endereço do 13 elemento do vetor

    jal x1, loop2   # chama a função loop2

    lw x30, 0(x28)  # x30 = vetor[13]
    addi x6, x0, 2  # x6 = 2
    bge x5, x6, Else4   # se x5 >= 2, Else4
    bne x30, x0, invalido # se vetor[13] != 0, chama a função invalido
    beq x0, x0, continua4
    Else4:
    addi x6, x0, 11  # x6 = 11
    sub x5, x6, x5   # x5 = 11 - resultado
    bne x30, x5, invalido # se vetor[13] != 11 - resultado, chama função invalido
    continua4:

    addi x10, x0, 1     # o cpf é válido, portanto, atribui x10 = 1

    lw x1, 0(sp)        # x1 = endereço do topo da pilha
    addi sp, sp, 4      # desaloca 1 palavra do topo da pilha

    jalr x0, 0(x1)      # retorna a função


verificadastro: 
    addi sp, sp, -4     # aumenta o espaço na pilha para mais 1 palavra
    sw x1, 0(sp)        # armazena o endereço de retorno na pilha
    beq x0, x14, cpf    # se x14 == x0, chama a função cpf
    cnpj:
        jal x1, verificacnpj
        lw x1, 0(sp)        # x1 = endereço do topo da pilha
        addi sp, sp, 4      # desaloca 1 palavra do topo da pilha
        jalr x0, 0(x1)      # retorna a função

    cpf:
        jal x1, verificacpf
        lw x1, 0(sp)        # x1 = endereço do topo da pilha
        addi sp, sp, 4      # desaloca 1 palavra do topo da pilha
        jalr x0, 0(x1)      # retorna a função

invalido:
    addi x10, x0, 0     # cpf é inválido, atribui x10 = 0
    lw x1, 0(sp)        # x1 = endereço do topo da pilha
    addi sp, sp, 4      # desaloca 1 palavra do topo da pilha

    jalr x0, 0(x1)      # retorna a função verificacpf ou verificacpnj

# se x1 == 1 -> o documento é válido!
# se x1 == 0 -> o documento é inválido
FIM: add x1, x0, x10