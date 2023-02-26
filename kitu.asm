.data
	s1: .asciiz "Nhap ki tu: "
	s2: .asciiz "Ki tu lien truoc cua "
	s3: .asciiz "Ki tu lien sau cua "
	s4: .asciiz " la: " 
	s5: .asciiz "\n"
.text
.globl main
main:
	#xuat thong bao
	la $a0, s1
	li $v0, 4
	syscall
	#nhap ki tu
	li $v0, 12
	syscall
	move $s0, $v0
	#xuong hang
	la $a0, s5
	li $v0, 4
	syscall
	#ki tu lien truoc	
	la $a0, s2
	li $v0, 4
	syscall
	#in ki tu vua nhap
	move $a0, $s0
	li $v0, 11
	syscall
	#in la
	la $a0, s4
	li $v0, 4
	syscall
	#in ki tu lien truoc
	move $a0, $s0
	addi $a0, $a0, -1
	li $v0, 11
	syscall
	#xuong dong
	li $a0, 10
	li $v0, 11
	syscall
	#ki tu lien sau
	la $a0, s3
	li $v0, 4
	syscall
	#in ki tu vua nhap
	move $a0, $s0
	li $v0, 11
	syscall
	#in la
	la $a0, s4
	li $v0, 4
	syscall
	#in ki tu lien truoc
	move $a0, $s0
	addi $a0, $a0, 1
	li $v0, 11
	syscall