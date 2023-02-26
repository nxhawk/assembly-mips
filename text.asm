.data #du lieu
str: .asciiz "Xin chao"
st: .asciiz

.text #Chay chuong trinh
	#li $s0, 10
	#add $s1, $zero, 15
	#li $t0, 4
	#la $a0, str#address
	#syscall
	# nhap chuoi
	#li $v0, 8
	#la $a0, st
	#li $a1, 3# 2 ki tu
	#syscall
	#li $s1, -10
	#li $s2, 5
	#addu $s0, $s1, $s2#sub
	#li $s1, 1000000
	#li $s2, 120000
	#mult $s1, $s2
	#mflo $s0#mfhi $s0
	#li $s1, 10
	#li $s2, 3
	#div $s1, $s2
	#mtlo $s1

	li $s0, 10
	li $s1, 15
	seq $t0, $s0, $s1 #ss s0 = s1
 	slt $t1, $s0, $s1 #ss s0 < s1
	sle $t2, $s0, $s1 #ss s0 <= s1
	sgt $t3, $s0, $s1 #ss s0 > s1
	sge $t4, $s0, $s1 #ss s0 >= s1