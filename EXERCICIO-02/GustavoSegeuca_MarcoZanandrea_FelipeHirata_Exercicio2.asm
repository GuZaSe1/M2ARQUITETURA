# Disciplina: Arquitetura e Organização de Processadores
# Atividade: Avaliação 01 – Programação em Linguagem de Montagem
# Programa 02
# Grupo: Gustavo Segeuca, Marco Zanandrea e Felipe Hirata

.data
msg: .asciz "\nOs 10 primeiros primos a partir de 100 sao:\n"

.text
.globl main

main:
    # Imprime msg no console
    addi a7, zero, 4		# 4 = imprimir string
    la a0, msg
    ecall

    jal ra, imprimir10Primos

    # Encerra o programa
    addi a7, zero, 93		# 93 = encerrar o programa
    addi a0, zero, 0		# codigo de saida 0 = encerrou sem erros
    ecall

# Imprime os 10 primeiros primos a partir de 100 (NÃO FOLHA)
imprimir10Primos:
    addi sp, sp, -20		# reserva 20 bytes na pilha
    sw s0, 0(sp)		# salva registradores usados*
    sw s1, 4(sp)
    sw s2, 8(sp)
    sw ra, 12(sp)
    sw t0, 16(sp)

    addi s0, zero, 0      	# contador = 0 (não foi achado nenhum primo)
    addi s1, zero, 100    	# número inicial (100)

# Loop principal, encontra e imprime os numeros primos
loop_primos:
    addi a0, s1, 0
    jal ra, numeroPrimo
    addi s2, a0, 0		# resultado salvo em s2 (1 se primo, 0 se não)

    beq s2, zero, proximo	# se s2 == 0, vai para o proximo

    addi a0, s1, 0
    addi a7, zero, 1		# 1 = imprime um inteiro
    ecall

    li a0, 10			# 10 = (\n)
    li a7, 11			# 11 = imprime um caractere
    ecall

    addi s0, s0, 1		# adiciona 1 ao contador

proximo:
    addi s1, s1, 1		# incrementa s1 em 1
    li t0, 10			# compara s0 com 10
    blt s0, t0, loop_primos	# se s0 < 10, volta ao inicio

    lw s0, 0(sp)		# recupera registradores salvos* 
    lw s1, 4(sp)
    lw s2, 8(sp)
    lw ra, 12(sp)
    lw t0, 16(sp)
    addi sp, sp, 20		# libera os 20 bytes da pilha
    jalr zero, ra, 0		# retorna pro main	

# Procedimentos da Funcao do programa 01 para detectar um número primo
    
numeroPrimo:
    addi sp, sp, -12        # reserva 12 bytes na pilha
    sw s0, 0(sp)            # salva registradores usados*
    sw t0, 4(sp)
    sw t1, 8(sp)

    # Verifica se o numero <= 1 (nao primo)
    addi t0, zero, 1
    ble a0, t0, naoPrimo

    # Inicia o loop de verificacao de primo
    addi t0, zero, 2        # i = 2
    
loopPrimo:
    mul t1, t0, t0          # calcula i*i
    bgt t1, a0, ePrimo      # se i*i > numero, e nao encontrou nenhum divisor, eh primo	

    rem s0, a0, t0          # resto da divisao entre a0(num. original) e t0(i atual)
    beq s0, zero, naoPrimo  # resto zero = não primo

    addi t0, t0, 1          # incrementa i
    j loopPrimo             # repete loop
    
ePrimo:
    addi a0, zero, 1        # poe 1 em a0 p/ retornar que eh primo
    j fimPrimo              # pula p/ fimPrimo

naoPrimo:
    addi a0, zero, 0        # poe 0 em a0 p/ retornar que nao eh primo

fimPrimo:
    lw s0, 0(sp)            # recupera registradores salvos*
    lw t0, 4(sp)
    lw t1, 8(sp)
    addi sp, sp, 12         # libera os 12 bytes da pilha
    jalr zero, ra, 0        # retorna pro main
