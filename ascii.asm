.data
	strNhap: .asciiz "Nhap ky tu: "
	strXuat: .asciiz "\nMa ASCII tuong ung: "
.text
.globl main
main:
	#print "Nhap ky tu: "
	la $a0, strNhap
	li $v0, 4
	syscall
	#input
	li $v0, 12
	syscall
	#store
	move $t0, $v0
	#print ascii
	la $a0, strXuat
	li $v0, 4
	syscall
	
	move $a0, $t0
	li $v0, 1
	syscall
