.data
	mess: .asciiz "Input your string: "
	str: .space 256
	endl: .byte '\n'
.text
.globl main
main:
	li $v0, 4
	la $a0, mess
	syscall

	li $v0, 8
	la $a0, str
	li $a1, 256
	syscall
	lb $t5, endl

	la $t1, str
	loop:
		lb $t2, ($t1)
		beq $t2, $t5, print
		li $t3, 'a'
		blt $t2, $t3, next
		li $t4, 'z'
		bgt $t2, $t4, next
		addi $t2, $t2, -32
		sb $t2, ($t1)
	next:
		addi $t1, $t1, 1
		j loop 

print:
	la $a0, str
	li $v0, 4
	syscall
exit:
	li $v0, 10
	syscall
	