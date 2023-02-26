.data
	s1: .asciiz "Nhap vao chuoi: "
	s2: .asciiz "Chuoi sau khi dao nguoc: "
	input: .space 16
.text
main:	
	#xuat s1 ra console
	la $a0, s1
	li $v0, 4
	syscall
	#input chuoi
	li $v0, 8
	la $a0, input
	li $a1, 16
	syscall

	#print 
	li $v0, 4
	la $a0, s2
	syscall
	
	la $a0, input
	li $v0, 4
	syscall
	
	#xuat ra ki tu thu i
	li $v0, 5
	syscall
	move $t0, $v0
	
	la $a0, input
	add $a0, $a0, $t0
	
	lb $a1, ($a0)
	li $v0, 11
	move $a0,$a1
	syscall
	
	
