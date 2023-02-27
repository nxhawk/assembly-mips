.data
	welcome: .asciiz "Enter two integer number: "
	quotient: .asciiz "Quotient: "
	remainder: .asciiz "Remainder: "
	decimal: .asciiz "Quotient in decimal: "
	newline: .asciiz "\n"
.text
main:
	li $v0, 4
	la $a0, welcome
	syscall

	#read two number
	li $v0, 5
	syscall
	move $t0, $v0
	li $v0, 5
	syscall
	move $t1, $v0
	
	#multiply integers
	mul $a0, $t0, $t1
	li $v0, 1
	syscall
	
	jal print_new_line
	
	#divide (quotient, remainder)
	div $t0, $t1
	li $v0, 4
	la $a0, quotient
	syscall
	li $v0, 1
	mflo $a0
	syscall
	jal print_new_line

	li $v0, 4
	la $a0, remainder
	syscall
	li $v0, 1
	mfhi $a0
	syscall
	jal print_new_line
	
	#divide integers (FP answer)
	
	#word to floating point
	mtc1 $t0, $f12
	cvt.s.w $f3, $f12

	mtc1 $t1, $f12
	cvt.s.w $f4, $f12

	div.s $f12, $f3, $f4
	li $v0, 4
	la $a0, decimal
	syscall
	li $v0, 2
	syscall
	
exit:
	li $v0, 10
	syscall
print_new_line:
	li $v0, 4
	la $a0, newline
	syscall
	jr $ra
	