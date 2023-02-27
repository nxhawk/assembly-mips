.data
	list: .word 17, 5, 92, 87, 41, 10, 23, 55, 72, 36
	listSize: .word 10
	msg: .asciiz "Sorted list is: "
	strWel: .asciiz "Original list is: "
	space: .asciiz " "
	endline: .asciiz "\n"
.text
.globl main
main:
	#print original list
	la $a0, strWel
	li $v0, 4
	syscall
	
	jal print_array
	#endline
	li $v0, 4
	la $a0, endline
	syscall
	
	#init 
	la $a0, list
	lw $t0, listSize
	addi $t0, $t0, -1 #loop 1 n-1 -> 0, t0 = i
	
	loop1:
		blt $t0, $zero, out1
		li $t1, 0#t1 = j
		loop2:
			bge $t1, $t0, out2
			addi $t2, $t1, 1 #j + 1
			
			#get list[j]
			sll $t3, $t1, 2
			add $t3, $t3, $a0 # &list[j]
			#get list[j+1]
			sll $t4, $t2, 2
			add $t4, $t4, $a0 # &list[j+1]
			#get value
			lw $t5, ($t3)# list[j]
			lw $t6, ($t4)# list[j+1]
			ble $t5, $t6, endif
			sw $t5, ($t4)
			sw $t6, ($t3)
			endif:
				addi $t1, $t1, 1
				j loop2	
	out2:
		addi $t0, $t0, -1
		j loop1

out1:
	li $v0, 4
	la $a0, msg
	syscall
	jal print_array	

exit:
	li $v0, 10
	syscall

print_array:
	lw $t0, listSize#n
	la $a2, list# array
	li $t1, 0 #i

	Loop:
		beq $t1, $t0, return#check if
		lw $a0, ($a2)#load data
		li $v0, 1
		syscall
		#print space
		li $v0, 4
		la $a0, space
		syscall
		#inc i
		addi $t1, $t1, 1
		addi $a2, $a2, 4
		j Loop

	return:
		jr $ra
