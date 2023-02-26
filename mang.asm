.data
	s1: .asciiz "Nhap n: "
	s2: .asciiz "["
	s3: .asciiz "]="
	s4: .asciiz "Mang vua nhap: "
	s5: .asciiz "So lon nhat trong mang: "
	s6: .asciiz "So nho nhat trong mang: "
	s7: .asciiz "\n"
	array: .word 0:100 #int array[100]
	#t0 = n
.text
.globl main
main:
	#nhap n
	la $a0, s1
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0
	
	#khoi tao
	li $t1, 0
	la $a1, array
	
	NhapMang:
		#kiem tra so lan nhap lieu
		subu $t2, $t1, $t0
		bgez $t2, KetThucNhap
		#Xuat dau lan nhap thu 
		la $a0, s2
		li $v0, 4
		syscall
		move $a0, $t1
		li $v0, 1
		syscall
		la $a0, s3
		li $v0, 4
		syscall
		#Nhap gia tri phan tu thu i
		li $v0, 5
		syscall
		sw $v0, ($a1)
		#tang chi so phan tu
		addi $a1, $a1, 4
		addi $t1, $t1, 1
		j NhapMang
	KetThucNhap:
		la $a0, s4
		li $v0, 4
		syscall
		#khoi tao
		li $t1, 0
		la $a1, array
	XuatMang:
		subu $t2, $t1, $t0
		bgez $t2, TimMinMax
		lw $a0, ($a1)
		li $v0, 1
		syscall
		#print cach
		li $a0, 0x20
		li $v0, 11
		syscall
		#tang chi so
		addi $t1, $t1, 1
		addi $a1, $a1, 4
		j XuatMang
	TimMinMax:
		#khoi tao
		li $t1, 0
		la $a1, array
		lw $a2, ($a1)#$a2 la max
		lw $a3, ($a1)#$a3 la min
		Loop:
		#check 
		subu $t2, $t1, $t0
		bgez $t2, XuatMinMax
		#lay gia tri thu i
		lw $t3, ($a1)
		#tang i
		addi $t1, $t1, 1
		addi $a1, $a1, 4
		#kiem tra max 
		slt $t2, $t3, $a2
		beqz $t2, SSMax

		slt $t2, $a3, $t3
		beqz $t2, SSMin
		j Loop
	SSMax:
		move $a2, $t3
		slt $t2, $a3, $t3
		beqz $t2, SSMin
		j Loop
	SSMin:
		 move $a3, $t3
		 j Loop
	XuatMinMax:
		jal XuongDong
		#xuat so lon nhat
		la $a0, s5
		li $v0, 4
		syscall
		move $a0, $a2
		li $v0, 1
		syscall
		jal XuongDong
		#Xuat so nho nhat
		la $a0, s6
		li $v0, 4
		syscall
		move $a0, $a3
		li $v0, 1
		syscall
		j KetThuc
	XuongDong:
	la $a0, s7
	li $v0, 4
	syscall
	jr $ra

	KetThuc:
		li $v0, 10
		syscall