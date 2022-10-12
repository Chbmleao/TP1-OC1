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
    addi sp, sp, -4     # aumenta o espaço na pilha para mais 1 palavra
    sw x1, 0(sp)        # armazena o endereço de retorno na pilha

    lw x5, 0(x12)       # armazena em x5 o elemento armazenado em x12, inicio do vetor
    lw x6, 0(x13)       # armazena em x6 o elemento armazenado em x13, final do vetor
    sw x5, 0(x13)       # armazena no endereço de x13 o valor de x5
    sw x6, 0(x12)       # armazena no endereço de x12 o valor de x6

    addi x28, x12, 4    # armazena em x28 o proximo endereço da esquerda
    addi x29, x13, -4   # armazena em x29 o proximo endereço da direita
    blt x28, x29, L1    # se x12+4 < x13-4 chama a função L1

    addi sp, sp, 4      # desaloca 1 palavra da pilha
    jalr x0, 0(x1)      # retorna para o endereço de x1

L1:
    addi x12, x12, 4    # x12 = o elemento seguinte a x12
    addi x13, x13, -4   # x13 = o elemento anterior a x13
    jal x1, inverte     # chama a função inverte e x1 = PC + 4
    lw x1, 0(sp)        # x1 = endereço do topo da pilha
    addi sp, sp, 4      # desaloca 1 palavra do topo da pilha
    jalr x0, 0(x1)      # retorna para o endereço de x1

FIM: add x1, x0, x10