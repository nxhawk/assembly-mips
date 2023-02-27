#sub and add two number input
.data
	strDown: .asciiz "\n"
	strInput: .asciiz "Nhap vao 2 so nguyen: "
	strSum: .asciiz "Tong hai so vua nhap: "
	strSub: .asciiz "Hieu hai so vua nhap: " 
.text
.globl main
main:
	#print input mess
	la $a0, strInput
	li $v0, 4
	syscall
	
	#read number integer
	li $v0, 5
	syscall
	move $t0, $v0 #store number 1
	
	li $v0, 5
	syscall
	move $t1, $v0 #store number 2
	
	#add two number
	#display
	la $a0, strSum
	li $v0, 4
	syscall
	#add
	add $a0, $t0, $t1
	li $v0, 1
	syscall
	#print \n
	la $a0, strDown 
	li $v0, 4
	syscall
	#sub two number
	#display
	la $a0, strSub
	li $v0, 4
	syscall
	#add
	sub $a0, $t0, $t1
	li $v0, 1
	syscall
	
EXIT:
	li $v0, 10
	syscall