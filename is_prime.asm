.data 
	str: .asciiz "Enter a number: "
	yes: .asciiz "Is Prime"
	no: .asciiz "Not Prime"
.text
.globl main
main:
	#input number
	la $a0, str
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $a1, $v0#a1 = n

	jal is_prime
	move $a2, $v0
	beqz $a2, SNT

	la $a0, yes
	li $v0, 4
	syscall
	j exit
SNT:
	la $a0, no
	li $v0, 4
	syscall

exit:
	li $v0, 10
	syscall

is_prime:
	li $v0, 0
	blt $a1, 1, return
	li $v0, 1 #return 0:no, 1:yes
	li $t0, 1 #i
	loop:
		addi $t0, $t0, 1
		ble $a1, $t0, return
		div $a1, $t0
		mfhi $t1
		bgtz $t1, loop
		li $v0, 0 
return:
	jr $ra