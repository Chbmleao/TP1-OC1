.data
vetor: .word 1 2 3 4 5 6 7 8 9 10 11
.text
main:
la x12, vetor       # atribui o endereço do inicio do vetor a x12
addi x13, x0, 11    # atribui x13 = 11
addi x14, x0, 0     # atribui x14 = 0
jal x1, verificadastro  # chama a função verifica cadastro e x1 = PC + 4
beq x0, x0, FIM       # chama a função FIM

loop1:
    lw x30, 0(x28) # x30 = vetor[i]
    mul x6, x30, x7 # x6 = vetor[i] * j
    add x5, x5, x6 # x5 = resultado + multiplicacao (vetor[i] * j)
    addi x7, x7, -1 # decrementa o valor de j, j--
    addi x28, x28, 4  # incrementa o i em 4, para acessar a próxima posição do vetor
    blt x28, x29, loop1   # se endereço de x28 menor que de x29 chama a função loop1

    addi x6, x0, 10     # armazena x6 = 10
    mul x5, x5, x6      # armazena x5 = resultado * 10
    addi x6, x0, 11     # armazena x6 = 11
    rem x5, x5, x6      # armazena x5 = x5 % 11

    jalr x0, 0(x1)

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

    jal x1, loop1

    lw x30, 0(x28)
    bne x5, x30, FIM

    # verificacao do segundo digito
    addi x5, x0, 0  # temporario x5 armazena o resultado
    addi x6, x0, 0  # temporario x6 armazena a multiplicacao
    addi x7, x0, 11 # temporario x7 armazena j = 11
    addi x28, x12, 0 # x28 armazena endereço inicial do vetor
    addi x29, x0, 10 # temporario x29 armazena limite do loop = 10
    slli x29, x29, 2 # temporario x29 multiplicado por 4
    add x29, x12, x29 # x29 armazena o endereço do 10 elemento do vetor

    jal x1, loop1 # chama a função loop1

    lw x30, 0(x28)      # x30 = ultimo elemento do vetor
    bne x5, x30, FIM    # se x5 != x30 chama FIM

    addi x10, x0, 1     # se o cpf é válido atribui 

    lw x1, 0(sp)        # x1 = endereço do topo da pilha
    addi sp, sp, 4      # desaloca 1 palavra do topo da pilha

    jalr x0, 0(x1)

verificacnpj: 
    addi sp, sp, -4     # aumenta o espaço na pilha para mais 1 palavra
    sw x1, 0(sp)        # armazena o endereço de retorno na pilha

    




    lw x1, 0(sp)        # x1 = endereço do topo da pilha
    addi sp, sp, 4      # desaloca 1 palavra do topo da pilha

    jalr x0, 0(x1)

verificadastro: 
    addi sp, sp, -4     # aumenta o espaço na pilha para mais 1 palavra
    sw x1, 0(sp)        # armazena o endereço de retorno na pilha
    beq x0, x14, cpf
    cnpj:
        jal x1, verificacnpj
        lw x1, 0(sp)        # x1 = endereço do topo da pilha
        addi sp, sp, 4      # desaloca 1 palavra do topo da pilha
        jalr x0, 0(x1)

    cpf:
        jal x1, verificacpf
        lw x1, 0(sp)        # x1 = endereço do topo da pilha
        addi sp, sp, 4      # desaloca 1 palavra do topo da pilha
        jalr x0, 0(x1)
    
FIM: add x1, x0, x10