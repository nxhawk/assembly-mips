.data
	space: .asciiz " "
.text
.globl main
main:
	li $s0, 10
	li $s1, 0
	li $s2, 1
	
	#init stack
	addi $sp, $sp, -8
	sw $s1, ($sp)
	sw $s2, 4($sp)

	move $t2, $s0
loop:
	lw $t0, ($sp)
	lw $t1, 4($sp)
	addi $sp, $sp, 8
	
	add $t0, $t0, $t1
	li $v0, 1
	move $a0, $t0
	syscall
	
	li $v0, 4
	la $a0, space
	syscall
	
	#push back
	addi $sp, $sp, -8
	sw $t1, ($sp)
	sw $t0, 4($sp)
	
	addi $t2, $t2, -1
	bgt $t2, 0, loop 