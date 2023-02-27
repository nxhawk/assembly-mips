.data
	float_val: .float 0.001
	double_val: .double 0.002
	floatMsg: .asciiz "Floating point number entered is: "
	doubleMsg: .asciiz "Double is: "
	newline: .asciiz "\n"
.text

main:
	#print floating point
	l.s $f12, float_val
	li $v0, 2
	syscall 

	jal print_new_line

	#print double 
	l.d $f12, double_val
	li $v0, 3
	syscall 

	jal print_new_line

	#read float
	li $v0, 6
	syscall
	mov.s $f3, $f0
	
	#read double
	li $v0, 7
	syscall

	#convert float to double
	cvt.d.s $f4, $f3# f4: result, f3: float
	
	#sum of numbers => convert to double or float
	add.d $f12, $f4, $f0
	li $v0, 3
	syscall
	jal print_new_line

	#diff of numbers
	sub.d $f12, $f4, $f0
	li $v0, 3
	syscall
	jal print_new_line
exit:
	li $v0, 10
	syscall

print_new_line:
	li $v0, 4
	la $a0, newline
	syscall
	jr $ra
