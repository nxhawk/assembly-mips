.data
	strNHT: .asciiz "Nhap nam hien tai: "
	strNS: .asciiz "Nhap nam sinh cua ban: "
	strKQ: .asciiz "Tuoi cua ban la: " 
.text
.globl main
main:
	#print "Nhap nam hien tai: "
	la $a0, strNHT
	li $v0, 4
	syscall

	#input nht
	li $v0, 5
	syscall
	move $s0, $v0
	
	#print "Nhap nam sinh cua ban: "
	la $a0, strNS
	li $v0, 4
	syscall

	#input nam sinh
	li $v0, 5
	syscall
	move $s1, $v0
	
	#tinh tuoi
	sub $s2, $s0, $s1
	addi $s2, $s2, 1
	
	#Xuat tuoi
	la $a0, strKQ
	li $v0, 4
	syscall

	move $a0, $s2
	li $v0, 1
	syscall	