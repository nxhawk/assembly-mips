.data
	msg: .asciiz "Triagle(0) or Square(1)?: "
	size: .asciiz "Required size: "
	star: .asciiz "*"
	newline: .asciiz "\n"
.text
main:
	li $v0, 4
	la $a0, msg
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0
	
	li $v0, 4
	la $a0, size
	syscall
	
	li $v0, 5
	syscall
	move $a1, $v0#n
	
	beq $t0, $zero, triangle
	jal print_square
	j exit
	triangle:
		jal print_triangle

exit:
	li $v0, 10
	syscall
	
print_square:
	li $t0, 1	
	move $t1, $a1
	addi $sp, $sp, -4
	sw $ra, ($sp)
	print_line2:
		move $a1, $t1
		jal print_star
		addi $t0, $t0, 1
		ble $t0, $t1, print_line2
	lw $ra, ($sp)
	addi $sp, $sp, 4
	jr $ra


print_triangle:
	li $t0, 1	
	move $t1, $a1
	addi $sp, $sp, -4
	sw $ra, ($sp)
	print_line:
		move $a1, $t0
		jal print_star
		addi $t0, $t0, 1
		ble $t0, $t1, print_line
	lw $ra, ($sp)
	addi $sp, $sp, 4
	jr $ra
print_star:
	addi $sp, $sp, -4
	sw $ra, ($sp)
	li $v0, 4
	la $a0, star
	printstar:
		syscall
		addi $a1, $a1, -1
		bgt $a1, $zero, printstar
	
	la $a0, newline
	syscall
	
	lw $ra, ($sp)
	addi $sp, $sp, 4
	jr $ra

	
	