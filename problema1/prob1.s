.data
vetor: .word 1 2 3 4 5 6 7
.text
main:
    la x12, vetor       # atribui o endereço do inicio do vetor a variavel x12
    addi x13, x0, 7     # atribui o numero de elementos do vetor a variavel x13 = 7
    addi x13, x13, -1   # diminui em 1 o valor de x13 = 6
    slli x13, x13, 2    # multiplica o valor de x13 por 4, x13 = 24
    add x13, x13, x12   # armazena em x13 o último endereço do vetor
    jal x1, inverte     # chama a função inverte e atribui x1 = PC + 4
    beq x0, x0, FIM     # chama a função FIM
inverte:  
    lw x5, 0(x12)       # armazena em x5 o elemento armazenado em x12
    lw x6, 0(x13)       # armazena em x6 o elemento armazenado em x13
    sw x5, 0(x13)       # armazena no endereço de x13 o valor de x5
    sw x6, 0(x12)       # armazena no endereço de x12 o valor de x6

    addi x12, x12, 4    # atribui o endereço do elemento do vetor seguinte a x12
    addi x13, x13, -4   # atribui o endereço do elemento do vetor anterior a x13
    blt x12, x13, inverte   # se x12 >= x3 chama a função inverte
    jalr x0, 0(x1)

FIM: add x1, x0, x10