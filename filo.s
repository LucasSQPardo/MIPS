.data
    array: 
        .align 2 
        .space 40
    opcao: 
        .align 2 
        .space 4
    pushArray: .asciiz "e"
    popArray: .asciiz "d"
    printArray: .asciiz "i"
    finishProgram: .asciiz "s"
    inStr: .asciiz "Valor:"
    space: .asciiz "\n"
    teststr: .asciiz "entrou no eX"
.text
.globl main
main:
    move $t0, $zero             # contador - de 4 em 4 pq eh int
    li $t1, 40                  # fim do contador
    # Opcoes para comparar no loop
    la $t2, pushArray($t0)
    la $t3, popArray
    la $t4, printArray
    la $t5, finishProgram
loop:
    # Aqui deve ficar lendo qual das opcoes que entra: 
    # eX: push(), d: pop(), i: getArray(), s: finish() 
    la $a0, inStr               # atribui a string "Valor:" a variavel a
    jal print

    li $v0, 12
    la $a0, opcao
    la $a1, 1
    syscall
    sw $a0, opcao

    la $a0, opcao              # atribui o que foi colocado em opcao em $a0
    # beq $t2, $a0, teste
    jal print                   # printa o que foi atribuido em $a0


    jal finish

teste:
    li $v0, 4
    la $a0, teststr
    syscall
    j finish

# eX (empilha o valor inteiro X)
push:
    jr $ra

# d (desempilha o último valor - não precisa fazer nada com o valor em si)
pop:
    jr $ra 

resetIndex:
    move $t0, $zero             # contador - de 4 em 4 pq eh int
    jr $ra 

# i (imprime o conteúdo da pilha na ordem em que os itens foram empilhados),
print:
    li $v0, 4                   # prepara para imprimir uma string
    syscall  
    jr $ra 

# Condicional para parar loop
getArray:
    beq $t0, $t1, finish # verifica se devemos continuar a funcao
    # Imprime Valor
    li $v0, 1                   # prepara para imprimir inteiro
    lw $a0, array($t0)          # atribui o valor de array(n) a $a0 
    syscall
    li $v0, 4                   # prepara para imprimir string
    la $a0, space               # imprime quebra de linha 
    syscall
    # Prepara prox indice e chama a funcao novamente
    addi $t0, $t0, 4            # atualiza posicao da array
    j getArray                  # chama funcao novamente 

# s: termina o programa
finish:
    li $v0, 10                  # acaba o programa. Reference: https://www.doc.ic.ac.uk/lab/secondyear/spim/node8.html
    syscall