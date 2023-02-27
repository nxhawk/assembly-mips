.data
	msg: .asciiz "Enter a number: "
	answer: .asciiz "\nFactorial is: "
.text
main:
	#input number
	la $a0, msg
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	#print number
	move $a0, $v0
	li $v0, 1
	syscall

	jal calculate_factorial
	move $a1, $v0
	
	la $a0, answer
	li $v0, 4
	syscall

	move $a0, $a1
	li $v0, 1
	syscall
		
exit:
	li $v0, 10
	syscall

calculate_factorial:
	addi $sp, $sp, -4
	sw $ra, ($sp)
	
	li $v0, 1
	multi:
		beq $a0, $zero, return
		mul $v0, $v0, $a0
		addi $a0, $a0, -1
		j multi

	return:
		lw $ra, ($sp)
		addi $sp, $sp, 4
		jr $ra
		