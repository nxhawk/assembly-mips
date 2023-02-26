.data
	s1: .asciiz "Nhap so a: "
	s2: .asciiz "Nhap so b: "
	s3: .asciiz "Nhap so c: "
	s4: .asciiz "Sau khi sap thu tu: "
.text
.globl main
main:
	#Nhap so a
	la $a0, s1
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0	

	#Nhap so b
	la $a0, s2
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $t1, $v0

	#Nhap so c
	la $a0, s3
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $t2, $v0

	#tim so lon nhat
	slt $s0, $t1, $t0
	bne $s0, $0, L1
	j Next1
	L1:
	move $t3, $t1
	move $t1, $t0
	move $t0, $t3
	Next1:
		slt $s0, $t2, $t0
		bne $s0, $0, L2
		j Next2
	L2:
	move $t3, $t2
	move $t2, $t0
	move $t0, $t3
	Next2:
		slt $s0, $t2, $t1
		bne $s0, $0, L3
		j Next3
	L3:
	move $t3, $t2
	move $t2, $t1
	move $t1, $t3
	Next3:
		#print
		la $a0, s4
		li $v0, 4
		syscall
		
		move $a0, $t0
		li $v0, 1
		syscall
		
		#Dau cach
		li $a0, 32
		li $v0, 11
		syscall

		move $a0, $t1
		li $v0, 1
		syscall
		
		#Dau cach
		li $a0, 32
		li $v0, 11
		syscall

		move $a0, $t2
		li $v0, 1
		syscall