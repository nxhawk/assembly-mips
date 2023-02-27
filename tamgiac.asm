.data
	msg: .asciiz "Enter height of pyramid: "
	space: .asciiz " "
	star: .asciiz "* "
	newline: .asciiz "\n"
.text
main:
	#input
	la $a0, msg
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $s0, $v0 #s0 = n
	move $s1, $v0
	addi $s1, $s1, -1#number space start line
	
	
	li $t0, 1#current line and current number star at line
	loop:
		#new line
		li $v0, 4
		la $a0, newline
		syscall
		#exit
		bgt $t0, $s0, exit
		#print spaces start line
		move $a1, $s1
		jal print_spaces
		addi $s1, $s1, -1
		
		#print stars
		move $a1, $t0
		jal print_stars
		addi $t0, $t0, 1
		
		j loop

print_stars:
	li $v0, 4
	la $a0, star
	print_star:
		beq $a1, $zero, return_stars
		syscall
		addi $a1, $a1, -1
		j print_star

	return_stars:
		jr $ra
	
print_spaces:
	li $v0, 4
	la $a0, space
	print_space:
		beq $a1, $zero, return_spaces
		syscall
		addi $a1, $a1, -1
		j print_space
	return_spaces:
		
		jr $ra	
	
exit:
	li $v0, 10
	syscall
	
	
	
