.data
	mess1: .asciiz "Input size array n = "
	mess2: .asciiz "Input array:\n"
	mess3: .asciiz "Array sorted: "
	
	space: .asciiz " "
	str1: .asciiz "a["
	str2: .asciiz "]= "
	
	array: .word 0:100
	len: .word 0
	
.text
.globl main
main:
		
	#input array
	
	#input n
	la $a0, mess1
	li $v0, 4
	syscall

	li $v0, 5
	syscall
	sw $v0, len

	#input array
	li $t1, 0 # i
	la $s0, array # &array
	lw $a1, len # n

	la $a0, mess2
	li $v0, 4
	syscall

	lap:
		bge $t1, $a1, Sort
		
		la $a0, str1
		li $v0, 4
		syscall

		li $v0, 1
		move $a0, $t1
		syscall

		la $a0, str2
		li $v0, 4
		syscall
				
		li $v0, 5
		syscall
		
		sw $v0, 0($s0)
		addi $s0, $s0, 4
		addi $t1, $t1, 1
		j lap
	Sort:
	################
	lw $a1, len # a1 = len
	li $t1, 0 # t1 = i
	la $t0, array # t0 = address(array)
	loop1:
		bge $t1, $a1, print
		#for j
		move $s1, $t1 # min = $s1
		addi $t2, $t1, 1 # $t2 = j
		loop2:
			bge $t2, $a1, continue
			#get a[min], a[j]

			#a[min]
			sll $t3, $s1, 2 # min*4
			add $t3, $t3, $t0 # &a[min]
			lw $t4, 0($t3)

			#a[j]
			sll $t5, $t2, 2 # j*4
			add $t5, $t5, $t0 # &a[j]
			lw $t6, 0($t5)

			ble $t4, $t6, next
			#change min
			move $s1, $t2 
			next:
				addi $t2, $t2, 1
				j loop2
		continue:
			#swap min - i ($s1, $t1)
			sll $t3, $s1, 2 # min*4
			add $t3, $t3, $t0 # &a[min]
			lw $t4, 0($t3)

			sll $t5, $t1, 2 # i*4
			add $t5, $t5, $t0 # &a[i]
			lw $t6, 0($t5)

			sw $t6, 0($t3)
			sw $t4, 0($t5)

			addi $t1, $t1, 1
			j loop1

print:
	la $a0, mess3
	li $v0, 4
	syscall

	li $t1, 0
	la $t0, array
	lw $a1, len
	loop:
		bge $t1, $a1, exit

		lw $a0, 0($t0)
		li $v0, 1
		syscall

		la $a0, space
		li $v0, 4
		syscall

		addi $t1, $t1, 1
		addi $t0, $t0, 4		
		j loop

exit:
	li $v0, 10
	syscall
