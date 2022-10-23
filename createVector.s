.data
    array: 
        .align 2 
        .space 40
    inStr: .asciiz "Valor:"
    space: .asciiz "\n"

.text
.globl main
main:
    move $t0, $zero             # contador - de 4 em 4 pq eh int
    li $t1, 40                   # fim do contador
    j setArray
setArray:
    # Condicional para parar loop
    beq $t0, $t1, resetIndex # verifica se devemos continuar a funcao
    # Imprime string "Valor:"
    li $v0, 4                   # prepara para imprimir uma string
    la $a0, inStr               # atribui a string "Valor:" a variavel a
    syscall         
    # Pega o valor para colocar na1 posicao n da array
    li $v0, 5                   # prepara para receber um valor inteiro
    syscall
    sw $v0, array($t0)          # faz o store do valor inteiro na posicao n/4 da matriz em s0
    # Prepara prox indice e chama a funcao novamente
    addi $t0, $t0, 4            # atualiza posicao da array
    j setArray                  # chama funcao novamente 

resetIndex:
    move $t0, $zero             # contador - de 4 em 4 pq eh int
    j getArray

getArray:
    # Condicional para parar loop
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

finish:
    li $v0, 10                  # acaba o programa. Reference: https://www.doc.ic.ac.uk/lab/secondyear/spim/node8.html
