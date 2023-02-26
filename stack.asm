.data
	strNhapN: .asciiz "Nhap N: "
	strNhapCacPT: .asciiz "Nhap cac phan tu:\n"
	strMangVuaNhap: .asciiz "Mang vua nhap la:\n"
	strXuongDong: .asciiz "\n"
	strTongCacPT: .asciiz "\nTong cac phan tu = "
.text
.globl main
main:
	#Nhap so luong phan tu N
	jal NhapN
	move $s0, $v0
	
	#Khoi tao stack
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
#Nhap Mang
	#print string
	li $v0, 4
	la $a0, strNhapCacPT
	syscall
	
	add $a0, $0, $sp
	add $a1, $0, $s0
	jal push_stack
	jal pop_stack


	j Thoat
	
##################
Thoat:
	li $v0, 10
	syscall

#################
NhapN:
	#print string
	la $a0, strNhapN
	li $v0, 4
	syscall
	#input integer
	li $v0, 5
	syscall
	#check N > 0
	ble $v0, 0, NhapN
	jr $ra
NhapTungPT:
	li $v0, 5
	syscall
	sw $v0, ($a0)
	addi $a0, $a0, 4
	addi $t1, $t1, 1
	blt $t1, $a1, NhapTungPT
	jr $ra
push_stack:
	subu $sp, $sp, 8
	sw $a0, 4($sp)
	sw $ra, ($sp)
	li $t1, 0
	jal NhapTungPT
	lw $ra, ($sp)
	lw $a0, 4($sp)
	addi $sp, $sp, 8
	jr $ra
pop_stack:
	subu $sp, $sp, 8
	sw $a0, 4($sp)
	sw $ra, ($sp)
	add $a2, $0, $a0

	li $v0, 4
	la $a0, strMangVuaNhap
	syscall

	addi $t1, $0, 0
	jal XuatTungPT
	lw $ra, ($sp)
	lw $a0, 4($sp)
	addi $sp, $sp, 8
	jr $ra
	


XuatTungPT:
	li $v0, 1
	lw $a0, ($a2)
	syscall
	addi $a2, $a2, 4
	addi $t1, $t1, 1
	
	li $v0, 4
	la $a0, strXuongDong
	syscall
		
	blt $t1, $a1, XuatTungPT
	jr $ra 	