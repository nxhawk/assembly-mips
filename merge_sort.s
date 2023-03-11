.data
	c: .word 0:100 # array result mergesort c[100]
	array: .word 56,3,46,47,34,12,1,5,10,8,33,25,29,31,50,43
	mess: .asciiz "Mang sau khi sap xep:\n"
	space: .asciiz " "
.text
.globl main
main:
	la $a0, array #address of array to $a0
	addi $a1, $zero, 0 #$a1 = low
	addi $a2, $zero, 15 #$a2 = high
	jal MergeSort
	j Print

MergeSort:#$a1 = low, $a2 = high
	slt $t0, $a1, $a2 #if low < high then $t0 = 1 else $t0 = 0
	beq $t0, $zero, Return
	
	addi $sp, $sp, -16
	sw $ra, 12($sp)	#return address
	sw $a1, 8($sp)		# low
	sw $a2, 4($sp)		# high

	add $s0, $a1, $a2 # mid = low + high
	sra $s0, $s0, 1 # mid = (low + high) / 2
	sw $s0, 0($sp)
	
	add $a2, $s0, $zero # mergesort(low, mid)
	jal MergeSort

	lw $s0, 0($sp) # load mid
	addi $a1, $s0, 1 # mid + 1
	lw $a2, 4($sp) # mergesort(mid + 1, high)
	jal MergeSort

	lw $a1, 8($sp) # low
	lw $a2, 4($sp) # high
	lw $a3, 0($sp) # mid
	jal Merge

	lw $ra, 12($sp)
	addi $sp, $sp, 16
	jr $ra

Return:
	jr $ra

#Merge two array
Merge:
	add $s0, $a1, $zero # i = low
	add $s1, $a1, $zero # k = low
	addi $s2, $a3, 1 # j = mid + 1 
	
While1:
	blt $a3, $s0, While2 # if mid < i => while2
	blt $a2, $s2, While2 # if high < j => while2
	# i <= mid and j <= high=> merge
If:
	#get a[i]
	sll $t0, $s0, 2 # $t0 = i*4
	add $t0, $t0, $a0 #$t0 = address(a[i])
	lw $t1, 0($t0) # $t1 = a[i]
	#get a[j]
	sll $t0, $s2, 2 # $t0 = j*4
	add $t0, $t0, $a0 #$t0 = address(a[j])
	lw $t3, 0($t0) # $t3 = a[j]
	
	blt $t3, $t1, Else # if a[j] < a[i] 
	# if a[i] < a[j]
	la $t4, c # get result array
	sll $t5, $s1, 2 # k*4
	add $t4, $t4, $t5 # $t4 = address(c[k])
	sw $t1, 0($t4) #c[k] = a[i]
	addi $s1, $s1, 1 # k++
	addi $s0, $s0, 1 # i++
	j While1
Else:
	la $t4, c # get result array
	sll $t5, $s1, 2 # k*4
	add $t4, $t4, $t5 # $t4 = address(c[k])
	sw $t3, 0($t4) #c[k] = a[j]
	addi $s1, $s1, 1 # k++
	addi $s2, $s2, 1 # j++
	j While1
	
While2:#high < j => add i -> mid
	blt $a3, $s0, While3 # mid < i => while3
	sll $t0, $s0, 2 # i*4
	add $t0, $t0, $a0 # $t0 = address(a[i])
	lw $t3, 0($t0) # $t3 = a[i]
	
	sll $t1, $s1, 2 # k*4
	la $t4, c
	add $t4, $t4, $t1 # $t4 = address(c[k])
	sw $t3, 0($t4) #c[k] = a[i]
	addi $s1, $s1, 1 # k++
	addi $s0, $s0, 1 # i++
	j While2


While3:#mid < i => add j($s2) -> high ($a2), k($s1)
	blt $a2, $s1, For_init # j > high => end merge
	sll $t2, $s2, 2 # j*4
	add $t2, $t2, $a0 # $t2 = address(a[j])
	lw $t3, 0($t2) # $t3 = a[j]
	
	la $t4, c #get address(c)
	sll $t5, $s1, 2 # k*4
	add $t4, $t4, $t5 # $t4 = address(c[k])
	sw $t3, 0($t4) # c[k] = a[j]
	addi $s2, $s2, 1 # j++
	addi $s1, $s1, 1 # k++
	j While3

#change array a[] => sort
For_init:
	add $t0, $a1, $zero # $t0 = low
	add $t1, $a2, $zero # $t1 = high
	la $t4, c # $t4 = address (c)
	
For:
	sle $t7, $t0, $t1 # $t7 = 1 if low <= high
	beq	$t7, $zero, MergeEnd # low > high end merge 
	sll $t2, $t0, 2 # low * 4
	add $t3, $t2, $a0 # $t3 = address(a[low])
	add $t5, $t2, $t4 # $t5 = address(c[low])
	lw $t6, 0($t5) # $t6 = c[low]
	sw $t6, 0($t3) # a[low] = c[low]
	addi $t0, $t0, 1 # low++
	j For	
MergeEnd:
	jr $ra

Print:
	#print mess
	li $v0, 4
	la $a0, mess
	syscall

	add $t0, $a1, $zero # $t0 = low
	add $t1, $a2, $zero # $t1 = high
	la $t4, c # array result

	
Print_loop:
	blt $t1, $t0, Exit

	#print integer
	lw $a0, ($t4)
	li $v0, 1	
	syscall

	#print space
	la $a0, space
	li $v0, 4
	syscall

	add $t4, $t4, 4 # i++
	add $t0, $t0, 1 # low++
	j Print_loop
Exit:
	li $v0, 10
	syscall
