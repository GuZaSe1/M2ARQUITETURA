# Disciplina: Arquitetura e Organização de Processadores
# Atividade: Avaliação 01 – Programação em Linguagem de Montagem
# Programa 01
# Grupo: Gustavo Segeuca, Marco Zanandrea e Felipe Hirata

.data
msg: .asciz "Informe um valor: "
msg_primo: .asciz "\nNumero Primo? (1=sim, 0=nao): "

.text
.globl main

main:
    # Imprime msg no console
    addi a7, zero, 4		# 4 = imprimir string
    la a0, msg
    ecall

    # Lê o valor digitado
    addi a7, zero, 5		# 5 = ler um numero inteiro
    ecall
    addi a1, a0, 0          	# guarda o valor digitado em a1

    # Chama a função (numeroPrimo)
    addi a0, a1, 0		# copia o valor de a1 p/ a0
    jal ra, numeroPrimo

    addi s0, a0, 0          	# guarda resultado em s0

    # Imprime o resultado se é primo ou não
    la a0, msg_primo
    addi a7, zero, 4
    ecall

    addi a0, s0, 0          	# copia o resultado de s0 p/ a0, preparando-o para imprimir
    addi a7, zero, 1		# coloca em a7 a syscall 1 p/ imprimir um inteiro no console
    ecall

    # Encerra o programa
    addi a7, zero, 93		# 93 = encerrar o programa
    addi a0, zero, 0		# codigo de saida 0 = encerrou sem erros
    ecall
		
    # Procedimento Folha: retorna 1 se for primo, e 0 se nao
    
numeroPrimo:
    addi sp, sp, -12        # reserva 12 bytes na pilha
    sw s0, 0(sp)            # salva registradores usados*
    sw t0, 4(sp)
    sw t1, 8(sp)

    # Verifica se o número <= 1 (nao primo)
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
    addi a0, zero, 0        # poe 0 em a0 p/ retornar que não eh primo

fimPrimo:
    lw s0, 0(sp)            # recupera registradores salvos*
    lw t0, 4(sp)
    lw t1, 8(sp)
    addi sp, sp, 12         # libera os 12 bytes da pilha
    jalr zero, ra, 0        # retorna pro main
