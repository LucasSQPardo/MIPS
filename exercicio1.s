# # # Lucas Serna Quinto Pardo R.A: 11201720490 

.data
    array: 
        .align 2 
        .space 40
    instr: .asciiz "Valor:"
    inslimite: .asciiz "Limite: "
    space: .asciiz " "

.text
.globl main
main:
    # Array
    move $t0, $zero             # CONTADOR - de 4 em 4 pq eh int
    li $t1, 40                  # FIM DO CONTADOR
    # Limites
    move $t2, $zero             # LIMITE INFERIOR
    move $t3, $zero             # LIMITE SUPERIOR
    # Variavel de teste 
    move $t4, $zero             # recebe o resultado da comparacao da condicional
setArray:
    # Condicional para parar loop
    beq $t0, $t1, resetIndex # verifica se devemos continuar a funcao
    # Imprime string "Valor:"
    li $v0, 4                   # prepara para imprimir uma string
    la $a0, instr               # atribui a string "Valor:" a variavel a
    syscall         
    # Pega o valor para colocar na posicao n da array
    li $v0, 5                   # prepara para receber um valor inteiro
    syscall
    sw $v0, array($t0)          # faz o store do valor inteiro na posicao n/4 da matriz em s0
    # Prepara prox indice e chama a funcao novamente
    addi $t0, $t0, 4            # atualiza posicao da array
    j setArray                  # chama funcao novamente 

setLimites:
    # Imprime string 
    li $v0, 4                   # prepara para imprimir uma string
    la $a0, inslimite               # atribui a string "Valor:" a variavel a
    syscall
    # Pega Limites
    li $v0, 5                   # prepara para receber um valor inteiro
    syscall
    add $t2, $v0, $zero          # pega o LIMITE INFERIOR t2 (=0) e adiciona 0 + o que estiver em $v0
    # li $v0, 4                   # prepara para imprimir uma string
    # la $a0, inslimite               # atribui a string "Valor:" a variavel a
    # syscall
    li $v0, 5                   # prepara para receber um valor inteiro
    syscall
    add $t3, $v0, $zero          # pega o LIMITE SUPERIOR t3 (=0) e adiciona 0 + o que estiver em $v0
    j getArray

resetIndex:
    move $t0, $zero             # contador - de 4 em 4 pq eh int
    j setLimites

getArray:
    # Condicional para parar loop
    move $a0, $zero
    beq $t0, $t1, finish # verifica se devemos continuar a funcao
    # Carrega valor do vetor
    lw, $a0, array($t0)
    # Verifica se eh menor que o limite inferior
    slt $t4, $a0, $t2
    beq $t4, 1, addIndex
    # Verifica se eh maior que o limite superior 
    slt $t4, $t3, $a0
    beq $t4, 1, addIndex
    # Imprime Valor
    j printPosition
    j getArray                  # chama funcao novamente 


addIndex:
    # Prepara prox indice e chama a funcao novamente
    addi $t0, $t0, 4            # atualiza posicao da array
    j getArray

printPosition:
    li $v0, 1                   # prepara para imprimir inteiro
    syscall
    li $v0, 4                   # prepara para imprimir string
    la $a0, space               # imprime quebra de linha 
    syscall
    j addIndex

finish:
    li $v0, 10                  # acaba o programa. Reference: https://www.doc.ic.ac.uk/lab/secondyear/spim/node8.html
    syscall