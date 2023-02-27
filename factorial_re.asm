.data
	msg: .asciiz "Enter a number: "
.text
.globl main
main:
	la $a0, msg
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $a0, $v0#store
	
	jal factorial
	
	move $a0, $v0
	li $v0, 1
	syscall
	

exit:
	li $v0, 10
	syscall

factorial:
	addi $sp, $sp, -4
	sw $ra, ($sp)
	move $v1, $a0
	li $v0, 1
	beq $a0, $zero, return
	addi $a0, $a0, -1
	
	addi $sp, $sp, -8
	sw $v1, ($sp)
	sw $a0, 4($sp)
	
	jal factorial
	
	lw $v1, 0($sp)
	lw $a0, 4($sp)
	addi $sp, $sp, 8
	mul $v0, $v0, $v1
return:
	lw $ra, ($sp)
	addi $sp, $sp, 4
	jr $ra 
