.data
	welcome: .asciiz "Enter a srting: "
	userString: .space 256
	newline: .asciiz "\n"
	yes: .asciiz "IS PALINDROME"
	no: .asciiz "NOT PALINDROME"
.text
.globl main
main:
	#print input
	li $v0, 4
	la $a0, welcome
	syscall
	#input string
	la $a0, userString
	li $a1, 256
	li $v0, 8
	syscall
	#print input 
	li $v0, 4
	la $a0, userString
	syscall

	#
	lb $t5, newline #endline =>end string
	la $a0, userString
	add $t1, $a0, $zero
	length:
		lb $t3, ($t1)
		addi $t1, $t1, 1
		bne $t3, $t5, length
	done:
		addi $t1, $t1, -2#get character last
		#check palindrome
		add $t0, $a0, $zero
		check_lectter:
			lb $t2, ($t0) #top
			lb $t3, ($t1) #bottom
			bne $t2, $t3, notPalindrome
			addi $t0, $t0, 1
			addi $t1, $t1, -1
			blt $t0, $t1, check_lectter
		#all good
		li $v0, 4
		la $a0, yes
		syscall
		j exit

	notPalindrome:
		li $v0, 4
		la $a0, no
		syscall	
exit: 
	li $v0, 10
	syscall

print_new_line:
	la $a0, newline
	li $v0, 4
	syscall
	jr $ra