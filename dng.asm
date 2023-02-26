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
		
	#Dao nguoc chuoi
	#print 
	li $v0, 4
	la $a0, s2
	syscall	
	
	#get length string
	strlen:
		li $v0, 0
		la $a0, input
		loop:
			lb $t1, ($a0)
			beq $t1, 10, exit#10 la dau xuong dong do nhap tu ban phim
			#beqz $t1, exit #neu chuoi mac dinh
			addi $a0, $a0, 1
			addi $v0, $v0, 1
			j loop
	
	exit:
		#print nguoc
		move $s0, $v0
		la $t0, input
		add $t0, $t0, $s0
		lop:
			li $v0, 11
			lb $a0, ($t0)
			syscall
			subi $s0, $s0, 1
			subi $t0, $t0, 1
			beq $s0, -1, re
			j lop
	re: