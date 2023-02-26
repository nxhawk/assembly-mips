.data
Nhap: .asciiz "Nhap N(N>0): "
Xuat: .asciiz "Mang vua nhap la:\n"
XuongHang: .asciiz "\n"
PhanTuThu: .asciiz "Phan tu thu "
DauHaiCham: .asciiz ": "
DauCach: .asciiz " "

array: .word 0:50 # array[50]

.text
main:
	#Xuat chuoi Nhap
	la $a0, Nhap
	li $v0, 4
	syscall

	#Nhap so luong phan tu
	li $v0, 5
	syscall
	move $s0, $v0

	jal NhapMang

	#1
	j XuatMang

NhapMang:
	li $t0, 0 #chi so phan tu
	la $a1, array #$a1 = &array

NhapPhanTu:
	slt $t1, $t0, $s0#ss t0 < s0 => t1 = 1
	beq $t1, 0, KetThuc
	
#Xuat Thong bao nhap lieu

	#print nhap phan tu thu 
	la $a0, PhanTuThu
	li $v0, 4
	syscall
	#xuat chi so phan tu
	move $a0, $t0 	 
	li $v0, 1
	syscall
	#xuat dau hai cham
	la $a0, DauHaiCham
	li $v0, 4
	syscall

#Nhap lieu
	#Nhap so nguyen
	li $v0, 5
	syscall
	sw $v0, ($a1)#luu 1 word trong thanh ghi vao ram
	
	#tang chi so
	addi $t0, $t0, 1#t0++
	addi $a1, $a1, 4
	
	#loop
	j NhapPhanTu

KetThuc:
	jr $ra#tro lai #1
 
XuatMang:
	#xuong hang
	la $a0, XuongHang
	li $v0, 4	
	syscall
	#Xuat Mang Vua Nhap: 
	la $a0, Xuat
	li $v0, 4	
	syscall

	#khoi tao phan tu dau
	la $a1, array
	move $t0, $0
	
	#loop print
	XuatPhanTu:
		slt $t1, $t0, $s0
		beq $t1, 0, Thoat
		
		#Xuat phan tu thu
		la $a0, PhanTuThu
		li $v0, 4
		syscall

		#i
		move $a0, $t0
		li $v0, 1
		syscall

		#Xuat dau hai cham
		la $a0, DauHaiCham
		li $v0, 4
		syscall

		#Xuat Thong tin phan tu thu i
		lw $a0, ($a1)
		li $v0, 1
		syscall

		#Xuat xuong dong
		la $a0, XuongHang
		li $v0, 4
		syscall

		#tang i
		addi $t0, $t0, 1 #t0++
		addi $a1, $a1, 4

		#loop
		j XuatPhanTu

Thoat:
	li $v0, 10
	syscall 